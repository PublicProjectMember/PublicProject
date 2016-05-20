//
//  
//
//
//  Created by user on 15/4/7.
//  Copyright (c) 2015年 家伟 李. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
/**
 *@brief 是否不使用左侧箭头返回按钮 YES:不使用 默认为使用
 */
@property (nonatomic,assign) BOOL isNotUseNavArrow;


/**
 *@brief 使用alloc创建的控制器
 */
+ (instancetype)viewController;
/**
 * @brief 设置导航栏是否隐藏
 */
- (void)setNavigationBarHide:(BOOL)isHide;
/**
 *  @brief 初始化View
 */
-(void)setupViews;
/**
 *  @brief 初始化Data
 */
-(void)setupDatas;
/**
 *  @brief 返回按钮点击事件
 */
- (void)navBackButtonClicked:(UIButton *)sender;
/**
 *  @brief 设置导航器右边按钮
 */
- (void)setNavRightButtonwithImg:(NSString *)normalImg selImg:(NSString *)selImg title:(NSString *)title action:(SEL)action;
/**
 *  @brief 设置导航器左边按钮
 */
- (void)setNavLeftButtonwithImg:(NSString *)normalImg selImg:(NSString *)selImg title:(NSString *)title action:(SEL)action;
/**
 *	@brief	自定义titlte居中处理
 *
 *	@param 	title 	title
 */
- (void)setNavTitle:(NSString *)title;
//- (void)setNavBackArrow;
/**
 *  @brief 展示加载框
 */
- (void)showProgressViewWithTitle:(NSString *)title;
/**
 *  @brief 隐藏加载框
 */
- (void)hideProgressView;

/** 点击返回按钮时，如果是pop的话，是否弹到根控制器，默认NO */
@property (nonatomic, assign) BOOL isBackToRoot;

@end
