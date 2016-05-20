//
//  BGPasscodeViewController.m
//  BYCloud
//
//  Created by user on 15/12/17.
//  Copyright © 2015年 bangying. All rights reserved.
//

#import "BGPasscodeViewController.h"

static NSString *BulletCharacter = @"\u25CF";
@interface BGPasscodeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *topMessageLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *digstLabel1;
@property (weak, nonatomic) IBOutlet UILabel *digstLabel2;
@property (weak, nonatomic) IBOutlet UILabel *digstLabel3;
@property (weak, nonatomic) IBOutlet UILabel *digstLabel4;
@property (weak, nonatomic) IBOutlet UILabel *bottomTipLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerLayoutConstraint;


@property (nonatomic, assign) BGPassCodeAction passCodeAction;
/**
 *  备用输入的数字密码
 */
@property (nonatomic, copy) NSString *enterAlternativePasscode;
/**
 *  输入的数字密码
 */
@property (nonatomic, copy) NSString *enterPasscode;

/**
 *  错误尝试的次数
 */
@property (nonatomic, assign) NSInteger failedAttempts;
/**
 *  更新密码时，是否输入了正确的原始密码
 */
@property (nonatomic, assign) BOOL isInputCorrectOriginPasscode;
@end

@implementation BGPasscodeViewController

+ (instancetype)passcodeViewControllerWithAction:(BGPassCodeAction)passCodeAction delegate:(id<BGPasscodeViewControllerDelegate>)delegate {
    BGPasscodeViewController *controller = [[BGPasscodeViewController alloc] init];
    controller.passCodeAction = passCodeAction;
    controller.delegate = delegate;
    return controller;
}

- (instancetype)init {
    if(self = [super init]) {
        self.cancelButtonTitleColor = [UIColor grayColor];
        self.enterFailPrompt = @"输入有误";
        self.confirmFailPrompt = @"确认密码有误";
        self.cancelButtonTitle = @"取消";
        self.failPromptColor = [UIColor redColor];
        self.promptColor = [UIColor blackColor];
    }
    return self;
}

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if([self.delegate respondsToSelector:@selector(passcodeViewControllerDidCancel:)]) {
        self.navigationItem.rightBarButtonItem = [self cancelButtomItem];
    }
    
    [self setupViews];
    
    // Do any additional setup after loading the view from its nib.
}

- (UIBarButtonItem *)cancelButtomItem {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 80, 46);
    [button setTitle:self.cancelButtonTitle forState:UIControlStateNormal];
    [button setTitleColor:self.cancelButtonTitleColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    button.titleLabel.font = [UIFont systemFontOfSize:13.0];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.textField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.textField resignFirstResponder];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)setupViews {
    //设置输入框
    self.textField.hidden = YES;
    [self.textField addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    //清空输入框label中的值
    [self clearPasscode];
    
    //提醒文本
    self.topMessageLabel.text = self.enterPasscodePrompt;
    self.topMessageLabel.textColor = self.promptColor;
    self.bottomTipLabel.text = @"";
    self.bottomTipLabel.textColor = self.failPromptColor;
}

- (void)textFieldValueChanged:(UITextField *)textField {
    NSInteger inputLength = self.textField.text.length;
    if(inputLength > 4) {
        NSLog(@"输入错误！！！！！");
        return;
    }
    //记录输入内容
    self.enterPasscode = textField.text;
    
    //改变填充数量
    [self updateDisgstLabels:textField.text];
    
    //如果已经输入4个数字
    if(inputLength == 4) {
        [self didEnterFourNumPasscode];
    }
    
}

- (void)cancelButtonAction:(UIButton *)button {
    [self.textField resignFirstResponder];
    [self.delegate passcodeViewControllerDidCancel:self];
}

#pragma mark - enter method
/**
 *  已经输入了4位数字密码
 */
- (void)didEnterFourNumPasscode {
    switch (self.passCodeAction) {
        case BGPassCodeActionEnter: {
            if(self.originalPasscode.length != 4) {
                NSLog(@"Error: 需要给定4位原始密码!!!");
                return;
            }
            if([self.originalPasscode isEqualToString:self.enterPasscode]) {
                //键盘消失
                [self.textField resignFirstResponder];
                if([self.delegate respondsToSelector:@selector(passcodeViewController:didEnterCorrectPasscode:)]) {
                    [self.delegate passcodeViewController:self didEnterCorrectPasscode:self.enterPasscode];
                }
            }
            else {
                self.failedAttempts ++;
                self.bottomTipLabel.text = self.enterFailPrompt;
                [self shakePassCodeView:^{
                    [self clearPasscode];
                }];
                if([self.delegate respondsToSelector:@selector(passcodeViewController:didFailToEnterPasscode:)]) {
                    [self.delegate passcodeViewController:self didFailToEnterPasscode:self.failedAttempts];
                }
            }
        }
            break;
        case BGPassCodeActionSet: {
            if(self.enterAlternativePasscode == nil) { //初次输入
                self.enterAlternativePasscode = self.enterPasscode;
                self.topMessageLabel.text = self.confirmPasscodePrompt;
                [self clearPasscode];
            }
            else { //再次输入
                if([self.enterAlternativePasscode isEqualToString:self.enterPasscode]) {
                    //键盘消失
                    [self.textField resignFirstResponder];
                    if([self.delegate respondsToSelector:@selector(passcodeViewController:didSetNewPasscode:)]) {
                        [self.delegate passcodeViewController:self didSetNewPasscode:self.enterAlternativePasscode];
                    }
                }
                else {
                    self.failedAttempts ++;
                    self.bottomTipLabel.text = self.confirmFailPrompt;
                    [self shakePassCodeView:^{
                        [self clearPasscode];
                    }];
                }
            }
        }
            break;
        case BGPassCodeActionChange: {
            if(self.originalPasscode.length != 4) {
                NSLog(@"Error: 需要给定4位原始密码!!!");
                return;
            }
            if(self.isInputCorrectOriginPasscode) {
                if(self.enterAlternativePasscode == nil) {
                    self.enterAlternativePasscode = self.enterPasscode;
                    self.topMessageLabel.text = self.confirmNewPasscodePrompt;
                    [self clearPasscode];
                }
                else {
                    if([self.enterAlternativePasscode isEqualToString:self.enterPasscode]) {
                        if([self.delegate respondsToSelector:@selector(passcodeViewController:didChangePasscode:)]) {
                            [self.delegate passcodeViewController:self didChangePasscode:self.enterAlternativePasscode];
                        }
                    }
                    else {
                        self.failedAttempts ++;
                        self.bottomTipLabel.text = self.confirmFailPrompt;
                        [self shakePassCodeView:^{
                            [self clearPasscode];
                        }];
                    }
                }
            }
            else {
                if([self.originalPasscode isEqualToString:self.enterPasscode]) {
                    self.isInputCorrectOriginPasscode = YES;
                    self.topMessageLabel.text = self.enterNewPasscodePrompt;
                    self.bottomTipLabel.text = @"";
                    self.failedAttempts = 0;
                    [self clearPasscode];
                }
                else {
                    self.failedAttempts ++;
                    self.bottomTipLabel.text = self.enterFailPrompt;
                    [self shakePassCodeView:^{
                        [self clearPasscode];
                    }];
                }
            }
            
        }
            break;
        default:
            break;
    }
}

- (void)clearPasscode {
    self.textField.text = @"";
    [self textFieldValueChanged:self.textField];
}

/**
 *  更新输入的数字文本
 */
- (void)updateDisgstLabels:(NSString *)inputText {
    NSArray *labelArr = @[self.digstLabel1, self.digstLabel2, self.digstLabel3, self.digstLabel4];
    for (NSInteger i = 0, inputLength = inputText.length, labelCount = labelArr.count; i < labelCount; i++) {
        UILabel *label = labelArr[i];
        if(i < inputLength) {
            label.text = BulletCharacter;
        }
        else {
            label.text = @"";
        }
    }
}

- (void)shakePassCodeView: (void (^)())block {
    self.centerLayoutConstraint.constant = 50;
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:10.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.centerLayoutConstraint.constant = 0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if(finished) {
            [self.view layoutIfNeeded];
            block();
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
