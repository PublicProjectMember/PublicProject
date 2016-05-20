//
//  RatingViewController.h
//  RatingController
//
//  Created by Ajay on 2/28/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RatingViewDelegate
-(void)ratingChanged:(float)newRating view:(UIView *)view;
@end


@interface RatingEvaluateView : UIView {
	UIImageView *s1, *s2, *s3, *s4, *s5;
	UIImage *unselectedImage, *partlySelectedImage, *fullySelectedImage;
	__weak id<RatingViewDelegate> viewDelegate;

	float starRating, lastRating;
	float height, width; // of each image of the star!
}

@property (nonatomic, strong) UIImageView *s1;
@property (nonatomic, strong) UIImageView *s2;
@property (nonatomic, strong) UIImageView *s3;
@property (nonatomic, strong) UIImageView *s4;
@property (nonatomic, strong) UIImageView *s5;

-(void)setImagesDeselected:(NSString *)unselectedImage partlySelected:(NSString *)partlySelectedImage 
			  fullSelected:(NSString *)fullSelectedImage andDelegate:(id<RatingViewDelegate>)d;
-(void)displayRating:(float)rating;
- (void)showRatingWithOutCallBack:(float)rating;
-(float)rating;
/**
 *  @brief 星星的间距，默认为0
 *  @note 此方法必须在设置图片之前设置
 */
@property (nonatomic, assign) CGFloat ratingGap;

/**
 *  @brief 星星大小，默认根据图片大小而确定，若是设置了此值，则根据此值大小而确定
 *  @note  此方法必须在设置图片之前设置
 */
@property (nonatomic, assign) CGSize ratingSize;
@end
