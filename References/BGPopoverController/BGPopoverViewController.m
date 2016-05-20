//
//  BGPopoverViewController.m
//  BYCloud
//
//  Created by user on 15/12/24.
//  Copyright © 2015年 bangying. All rights reserved.
//

#import "BGPopoverViewController.h"

#define BGPopoverViewControllerRGBA(r, g, b, a) [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]
@interface BGPopoverViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIWindow *window;
@end

@implementation BGPopoverViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width-20, [UIScreen mainScreen].bounds.size.height-120);
    }
    return self;
}

- (UIWindow *)window {
    if(_window == nil) {
        UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        window.hidden = NO;
        window.windowLevel = UIWindowLevelAlert+1;
        _window = window;
    }
    return _window;
}

- (void)show {
    self.window.rootViewController = self;
    self.window.layer.backgroundColor = BGPopoverViewControllerRGBA(0, 0, 0, 0.6).CGColor;
    self.view.frame = CGRectMake((self.window.frame.size.width-self.contentSize.width)/2.0, (self.window.frame.size.height-self.contentSize.height)/2.0, self.contentSize.width, self.contentSize.height);
    self.view.layer.cornerRadius = 5.0;
    self.view.layer.masksToBounds = YES;
    
    //window add tap gesture
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapWindowAction:)];
    tap.delegate = self;
    [self.window addGestureRecognizer:tap];
}

- (void)dismiss {
    self.window.rootViewController = nil;
    self.window.hidden = YES;
    self.window = nil;
}

- (void)tapWindowAction:(UITapGestureRecognizer *)tap {
    if(self.touchLayerBlock) {
        self.touchLayerBlock();
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGPoint touchPoint = [touch locationInView:self.window];
    if(CGRectContainsPoint(self.view.frame, touchPoint)) {
        return NO;
    }
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
