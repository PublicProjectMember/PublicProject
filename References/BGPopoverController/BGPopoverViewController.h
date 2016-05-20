//
//  BGPopoverViewController.h
//  BYCloud
//
//  Created by user on 15/12/24.
//  Copyright © 2015年 bangying. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BGPopoverViewController : UINavigationController
/**
 *  内容大小，默认为(280, 400)
 */
@property (nonatomic, assign) CGSize contentSize;
- (void)show;
- (void)dismiss;
/**
 *  点击蒙层调用的block
 */
@property (nonatomic, copy) void (^touchLayerBlock)();
@end
