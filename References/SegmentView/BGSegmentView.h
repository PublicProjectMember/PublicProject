//
//  BGSegmentView.h
//  BGSegmentView
//
//  Created by user on 15/9/17.
//  Copyright (c) 2015年 lcg. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BGSegmentView;
@protocol BGSegmentViewDelegate <NSObject>
@required
- (void)segmentView:(BGSegmentView *)segmentView didSelectIndex:(NSInteger)selectIndex;
@end

@interface BGSegmentView : UIView
- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items;

@property (nonatomic, weak) id<BGSegmentViewDelegate> delegate;
/**
 *  宽度
 */
@property (nonatomic, assign) CGFloat itemWidth;
/**
 *  选择的索引
 */
@property (nonatomic, assign) NSInteger selectIndex;
/**
 *  底下标示的线，默认与itemWidth相等
 */
@property (nonatomic, assign) CGFloat bottomLineWidth;

/**
 *  选中的字体颜色，默认红色
 */
@property (nonatomic, strong) UIColor *selectTextColor;

/**
 *  正常文字颜色，默认黑色
 */
@property (nonatomic, strong) UIColor *normalTextColor;
/**
 *  底部滑动的线条颜色，默认红色
 */
@property (nonatomic, strong) UIColor *bottomLineColor;
@end
