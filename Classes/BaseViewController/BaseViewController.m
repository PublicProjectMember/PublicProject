//
//
//  
//
//  Created by user on 15/4/7.
//  Copyright (c) 2015年 家伟 李. All rights reserved.
//

#import "BaseViewController.h"
#import "UIImage+Additional.h"
#import "MBProgressHUD.h"
#import "Helper.h"
#import "Reachability.h"
#import "MacroHeader.h"
#import "UIView+Additional.h"

//导航栏背景色
#define kNavBackGround RGB(247, 247, 247)
//导航栏标题
#define kNavTitleColor RGB(52.f, 52.f, 52.f)
/** 高亮文字颜色 */
#define kHighlightTextColor RGB(255.f, 57.f, 56.f)

@interface BaseViewController (){
    MBProgressHUD *progressView;
}
@property (nonatomic, assign) BOOL isHideNavigationBar;
@end

@implementation BaseViewController
+ (instancetype)viewController{
    BaseViewController *ctrl = [[self alloc] init];
    ctrl.hidesBottomBarWhenPushed = YES;
    return ctrl;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    if(!_isNotUseNavArrow){
        [self setNavBackArrow];
    }
    //初始化视图
    [self initViews];
    
    //设置导航栏
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)initViews{
    UIImage * image = [UIImage imageWithColor:kNavBackGround size:CGSizeMake(kMainBoundsWidth, 128)];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    progressView = [[MBProgressHUD alloc] initWithView:self.view];
    progressView.dimBackground = NO;
    [self.view addSubview:progressView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)setupViews{
}
- (void)setupDatas{
}


#pragma mark public method
- (void)setNavRightButtonwithImg:(NSString *)normalImg selImg:(NSString *)selImg title:(NSString *)title action:(SEL)action
{
    self.navigationItem.rightBarButtonItem = [self getButtonItemWithImg:normalImg selImg:selImg title:title action:action type:1];
}

- (void)setNavLeftButtonwithImg:(NSString *)normalImg selImg:(NSString *)selImg title:(NSString *)title action:(SEL)action
{
    self.navigationItem.leftBarButtonItem = [self getButtonItemWithImg:normalImg selImg:selImg title:title action:action type:0];
}
- (void)setNavTitle:(NSString *)title
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainBoundsWidth, 44)];
    titleView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    titleView.autoresizesSubviews = YES;
    titleView.backgroundColor = [UIColor clearColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kMainBoundsWidth, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = kNavTitleColor;
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    titleLabel.autoresizingMask = titleView.autoresizingMask;
    
    CGFloat width = [Helper widthForLabelWithString:title withFontSize:18 withWidth:kMainBoundsWidth withHeight:44];
    CGFloat maxWidth = 120;
    if(width <= kMainBoundsWidth-2*maxWidth){
        titleLabel.frame = CGRectMake(0, 0, kMainBoundsWidth-maxWidth*2, 44);
        titleView.frame = CGRectMake(maxWidth, 0, kMainBoundsWidth-maxWidth*2, 44);
    }
    else{
        //左边item占用宽度
        CGFloat leftViewWidth = 0;
        if(self.navigationItem.leftBarButtonItems.count > 0) {
            for (UIBarButtonItem *item in self.navigationItem.leftBarButtonItems) {
                if(item.customView.right > leftViewWidth) {
                    leftViewWidth = item.customView.right;
                }
            }
        }
        else {
            leftViewWidth = self.navigationItem.leftBarButtonItem.customView.right;
        }
        
        CGFloat rightItemLeft = 0;
        if(self.navigationItem.leftBarButtonItems.count > 0) {
            for (UIBarButtonItem *item in self.navigationItem.rightBarButtonItems) {
                if(item.customView.left < rightItemLeft) {
                    rightItemLeft = item.customView.left;
                }
            }
        }
        else {
            rightItemLeft = self.navigationItem.rightBarButtonItem.customView.left;
        }
        
        CGFloat rightViewWidth = rightItemLeft > 0 ? kMainBoundsWidth - rightItemLeft : 0;
        
        //以最大的一个为标准
        CGFloat maxWidth = leftViewWidth > rightViewWidth ? leftViewWidth : rightViewWidth;
        //给一个左右8像素的缓冲
        maxWidth += 8;
        titleLabel.width = kMainBoundsWidth - maxWidth*2;
        titleView.width = kMainBoundsWidth - maxWidth*2;
        titleView.left = maxWidth;
    }
    titleLabel.text = title;
    [titleView addSubview:titleLabel];
    self.navigationItem.titleView = titleView;
}

- (void)setIsNotUseNavArrow:(BOOL)isNotUseNavArrow
{
    if (isNotUseNavArrow == _isNotUseNavArrow)
    {
        return;
    }
    if(isNotUseNavArrow)
    {
        self.navigationItem.leftBarButtonItem = nil;
    }
    else
    {
        [self setNavBackArrow];
    }
    _isNotUseNavArrow = isNotUseNavArrow;
}

- (void)setNavBackArrow{
    [self setNavBackArrowWithWidth:40];
}

- (void)setNavigationBarHide:(BOOL)isHide{
    _isHideNavigationBar = isHide;
}

#pragma mark private method
//获取一个UIBarButtonItem
- (UIBarButtonItem *)getButtonItemWithImg:(NSString *)norImg selImg:(NSString *)selImg title:(NSString *)title action:(SEL)action type:(int)leftOrRight
{
    CGSize navbarSize = self.navigationController.navigationBar.bounds.size;
    CGRect frame = CGRectMake(0, 0, navbarSize .height, navbarSize.height - 3);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.exclusiveTouch = YES;
    if (norImg)
        [button setImage:[UIImage imageNamed:norImg] forState:UIControlStateNormal];
    if (selImg)
        [button setImage:[UIImage imageNamed:selImg] forState:UIControlStateHighlighted];
    if (title) {
        CGSize strSize = [title sizeWithFont:[UIFont boldSystemFontOfSize:14]];
        [button setTitle:title forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [button setTitleColor:kHighlightTextColor forState:UIControlStateNormal];
        frame.size.width = MAX(frame.size.width, strSize.width + 20);
    }
    button.frame = frame;
    if (leftOrRight==0) {
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    }else{
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    }
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* tmpBarBtnItem=[[UIBarButtonItem alloc] initWithCustomView:button];
    return tmpBarBtnItem;
}

//设置返回按钮
- (void)setNavBackArrowWithWidth:(CGFloat)width
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.exclusiveTouch = YES;
    [button setImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 50, width);
    if (iOS7System) {
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, -35, 0, 0)];
    }else{
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    }
    [button addTarget:self action:@selector(navBackButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backItem;
}

//返回按钮点击事件
- (void)navBackButtonClicked:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

#pragma mark - ProgressView Event
- (void)showProgressViewWithTitle:(NSString *)title
{
    [self.view bringSubviewToFront:progressView];
    if (title)
        progressView.labelText = title;
    [progressView show:YES];
}

#pragma mark -

- (void)hideProgressView{
    [progressView hide:YES];
}

@end
