//
//  BGPasscodeViewController.h
//  BYCloud
//
//  Created by user on 15/12/17.
//  Copyright © 2015年 bangying. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  passcode行为
 */
typedef NS_ENUM(NSInteger, BGPassCodeAction) {
    /**
     *  设置数字密码
     */
    BGPassCodeActionSet,
    /**
     *  输入确认数字密码
     */
    BGPassCodeActionEnter,
    /**
     *  修改数字密码
     */
    BGPassCodeActionChange,
};

@protocol BGPasscodeViewControllerDelegate;
@interface BGPasscodeViewController : UIViewController
+ (instancetype)passcodeViewControllerWithAction:(BGPassCodeAction)passCodeAction delegate:(id<BGPasscodeViewControllerDelegate>)delegate;

@property (nonatomic, assign, readonly) BGPassCodeAction passCodeAction;

@property (nonatomic, weak) id<BGPasscodeViewControllerDelegate> delegate;

/**
 *  原始密码
 */
@property (nonatomic, copy) NSString *originalPasscode;

/**
 *  输入时的提醒
 */
@property (nonatomic, copy) NSString *enterPasscodePrompt;

/**
 *  确认时的提醒
 */
@property (nonatomic, copy) NSString *confirmPasscodePrompt;

/**
 *  输入新密码时提醒
 */
@property (nonatomic, copy) NSString *enterNewPasscodePrompt;

/**
 *  确认新密码时提醒
 */
@property (nonatomic, copy) NSString *confirmNewPasscodePrompt;

/**
 *  输入失败时提醒，输入密码和更改密码时使用
 */
@property (nonatomic, copy) NSString *enterFailPrompt;

/**
 *  再次确认失败时提醒，设置密码和更改密码时使用
 */
@property (nonatomic, copy) NSString *confirmFailPrompt;

/**
 *  上面的提醒文字颜色
 */
@property (nonatomic, strong) UIColor *promptColor;
/**
 *  失败提醒文字
 */
@property (nonatomic, strong) UIColor *failPromptColor;


/**
 *  取消的文字
 */
@property (nonatomic, strong) NSString *cancelButtonTitle;

/**
 *  取消按钮标题颜色，默认为灰色
 */
@property (nonatomic, strong) UIColor *cancelButtonTitleColor;

@end

@protocol BGPasscodeViewControllerDelegate <NSObject>
@optional

/**
 *  取消
 */
- (void)passcodeViewControllerDidCancel:(BGPasscodeViewController *)controller;

#pragma mark - BGPassCodeActionSet
/**
 *  设置新密码成功，只在BGPassCodeActionSet时回调
 */
- (void)passcodeViewController:(BGPasscodeViewController *)controller didSetNewPasscode:(NSString *)passCode;

#pragma mark - BGPassCodeActionChange
/**
 *  修改密码，已经修改密码，只在BGPassCodeActionChange时回调
 *
 *  @param controller     控制器
 *  @param changePasscode 修改以后的密码
 */
- (void)passcodeViewController:(BGPasscodeViewController *)controller didChangePasscode:(NSString *)changePasscode;


#pragma mark - BGPassCodeActionEnter
/**
 *  输入了正确的密码，只在BGPassCodeActionEnter时回调
 *
 *  @param controller          控制器
 *  @param passCode            原始密码
 */
- (void)passcodeViewController:(BGPasscodeViewController *)controller didEnterCorrectPasscode:(NSString *)passCode;

/**
 *  输入密码错误时调用的方法，只在BGPassCodeActionEnter时回调
 *
 *  @param controller 控制器
 *  @param attempts   错误的次数
 */
- (void)passcodeViewController:(BGPasscodeViewController *)controller didFailToEnterPasscode:(NSInteger)attempts;

@end
