//
//  RatingViewController.m
//  RatingController
//
//  Created by Ajay on 2/28/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "RatingEvaluateView.h"
#import "UIView+Additional.h"

@interface RatingEvaluateView (){
    /**
     *  是否设置过大小
     */
    BOOL _isCustomeSetSize;
}

@end
@implementation RatingEvaluateView

@synthesize s1, s2, s3, s4, s5;

- (void)dealloc {

}

- (void)setRatingSize:(CGSize)ratingSize{
    _isCustomeSetSize = YES;
    _ratingSize = ratingSize;
}

-(void)setImagesDeselected:(NSString *)deselectedImage
			partlySelected:(NSString *)halfSelectedImage
			  fullSelected:(NSString *)fullSelectedImage
			   andDelegate:(id<RatingViewDelegate>)d {
	unselectedImage = [UIImage imageNamed:deselectedImage];
	partlySelectedImage = halfSelectedImage == nil ? unselectedImage : [UIImage imageNamed:halfSelectedImage];
	fullySelectedImage = [UIImage imageNamed:fullSelectedImage];
	viewDelegate = d;
	
	height=15; width=15;
	if (height < [fullySelectedImage size].height) {
		height = [fullySelectedImage size].height;
	}
	if (height < [partlySelectedImage size].height) {
		height = [partlySelectedImage size].height;
	}
	if (height < [unselectedImage size].height) {
		height = [unselectedImage size].height;
	}
	if (width < [fullySelectedImage size].width) {
		width = [fullySelectedImage size].width;
	}
	if (width < [partlySelectedImage size].width) {
		width = [partlySelectedImage size].width;
	}
	if (width < [unselectedImage size].width) {
		width = [unselectedImage size].width;
	}
	
    if(_isCustomeSetSize){
        height = _ratingSize.height;
        width = _ratingSize.width;
    }
    
	starRating = 0;
	lastRating = 0;
	s1 = [[UIImageView alloc] initWithImage:unselectedImage];
	s2 = [[UIImageView alloc] initWithImage:unselectedImage];
	s3 = [[UIImageView alloc] initWithImage:unselectedImage];
	s4 = [[UIImageView alloc] initWithImage:unselectedImage];
	s5 = [[UIImageView alloc] initWithImage:unselectedImage];
	
    /**
     *  星星和间距总共的宽度
     */
    CGFloat allWidth = width + _ratingGap;
	[s1 setFrame:CGRectMake(_ratingGap/2.0,         0, width, height)];
	[s2 setFrame:CGRectMake(allWidth + _ratingGap/2.0,     0, width, height)];
	[s3 setFrame:CGRectMake(2 * allWidth + _ratingGap/2.0, 0, width, height)];
	[s4 setFrame:CGRectMake(3 * allWidth + _ratingGap/2.0, 0, width, height)];
	[s5 setFrame:CGRectMake(4 * allWidth + _ratingGap/2.0, 0, width, height)];
	
	[s1 setUserInteractionEnabled:NO];
	[s2 setUserInteractionEnabled:NO];
	[s3 setUserInteractionEnabled:NO];
	[s4 setUserInteractionEnabled:NO];
	[s5 setUserInteractionEnabled:NO];
	
	[self addSubview:s1];
	[self addSubview:s2];
	[self addSubview:s3];
	[self addSubview:s4];
	[self addSubview:s5];
    
	CGRect frame = [self frame];
    frame.size.width = 5*allWidth;
	frame.size.height = height;
	[self setFrame:frame];
}

- (void)showRatingWithOutCallBack:(float)rating {
    [s1 setImage:unselectedImage];
    [s2 setImage:unselectedImage];
    [s3 setImage:unselectedImage];
    [s4 setImage:unselectedImage];
    [s5 setImage:unselectedImage];
    
    [self setRightImageViewWithRating:rating];
    
//    if (rating >= 0.5) {
//        [s1 setImage:partlySelectedImage];
//    }
//    if (rating >= 1) {
//        [s1 setImage:fullySelectedImage];
//    }
//    if (rating >= 1.5) {
//        [s2 setImage:partlySelectedImage];
//    }
//    if (rating >= 2) {
//        [s2 setImage:fullySelectedImage];
//    }
//    if (rating >= 2.5) {
//        [s3 setImage:partlySelectedImage];
//    }
//    if (rating >= 3) {
//        [s3 setImage:fullySelectedImage];
//    }
//    if (rating >= 3.5) {
//        [s4 setImage:partlySelectedImage];
//    }
//    if (rating >= 4) {
//        [s4 setImage:fullySelectedImage];
//    }
//    if (rating >= 4.5) {
//        [s5 setImage:partlySelectedImage];
//    }
//    if (rating >= 5) {
//        [s5 setImage:fullySelectedImage];
//    }
}

-(void)displayRating:(float)rating {
	[s1 setImage:unselectedImage];
	[s2 setImage:unselectedImage];
	[s3 setImage:unselectedImage];
	[s4 setImage:unselectedImage];
	[s5 setImage:unselectedImage];
	
//	if (rating >= 0.5) {
//		[s1 setImage:partlySelectedImage];
//	}
//	if (rating >= 1) {
//		[s1 setImage:fullySelectedImage];
//	}
//	if (rating >= 1.5) {
//		[s2 setImage:partlySelectedImage];
//	}
//	if (rating >= 2) {
//		[s2 setImage:fullySelectedImage];
//	}
//	if (rating >= 2.5) {
//		[s3 setImage:partlySelectedImage];
//	}
//	if (rating >= 3) {
//		[s3 setImage:fullySelectedImage];
//	}
//	if (rating >= 3.5) {
//		[s4 setImage:partlySelectedImage];
//	}
//	if (rating >= 4) {
//		[s4 setImage:fullySelectedImage];
//	}
//	if (rating >= 4.5) {
//		[s5 setImage:partlySelectedImage];
//	}
//	if (rating >= 5) {
//		[s5 setImage:fullySelectedImage];
//	}
    
    [self setRightImageViewWithRating:rating];
	
	starRating = rating;
	lastRating = rating;
	[viewDelegate ratingChanged:rating view:self];
}

- (void)setRightImageViewWithRating:(CGFloat)rating {
    if ( 0 < rating && rating < 1) {
        [s1 setImage:[self createPartImageWithScale:rating imageView:s1]];
    } else if (rating == 1) {
        [s1 setImage:fullySelectedImage];
    } else if (1 < rating && rating < 2) {
        [s1 setImage:fullySelectedImage];
        [s2 setImage:[self createPartImageWithScale:rating-1 imageView:s2]];
    } else if (rating == 2) {
        [s1 setImage:fullySelectedImage];
        [s2 setImage:fullySelectedImage];
    } else if (2 < rating && rating < 3) {
        [s1 setImage:fullySelectedImage];
        [s2 setImage:fullySelectedImage];
        [s3 setImage:[self createPartImageWithScale:rating - 2 imageView:s3]];
    } else if (rating == 3) {
        [s1 setImage:fullySelectedImage];
        [s2 setImage:fullySelectedImage];
        [s3 setImage:fullySelectedImage];
    } else if (3 < rating && rating < 4) {
        [s1 setImage:fullySelectedImage];
        [s2 setImage:fullySelectedImage];
        [s3 setImage:fullySelectedImage];
        [s4 setImage:[self createPartImageWithScale:rating - 3 imageView:s4]];
    } else if (rating == 4) {
        [s1 setImage:fullySelectedImage];
        [s2 setImage:fullySelectedImage];
        [s3 setImage:fullySelectedImage];
        [s4 setImage:fullySelectedImage];
    } else if (4 < rating && rating < 5) {
        [s1 setImage:fullySelectedImage];
        [s2 setImage:fullySelectedImage];
        [s3 setImage:fullySelectedImage];
        [s4 setImage:fullySelectedImage];
        [s5 setImage:[self createPartImageWithScale:rating - 4 imageView:s5]];
    } else if (rating >= 5) {
        [s1 setImage:fullySelectedImage];
        [s2 setImage:fullySelectedImage];
        [s3 setImage:fullySelectedImage];
        [s4 setImage:fullySelectedImage];
        [s5 setImage:fullySelectedImage];
    }
}

- (UIImage *)createPartImageWithScale:(CGFloat)scale imageView:(UIImageView *)imageView {
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y, imageView.width, imageView.height)];
    
    UIImageView *bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, contentView.width, contentView.height)];
    [bottomImageView setImage:unselectedImage];
    [contentView addSubview:bottomImageView];
    
    UIImageView *tmpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, contentView.width, contentView.height)];
    [tmpImageView setImage:fullySelectedImage];
    
    UIImage *image = [self screenView:tmpImageView scale:scale];
    
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, contentView.width * scale, contentView.height)];
    [topImageView setImage:image];
    [contentView addSubview:topImageView];
    
    return [self screenView:contentView scale:1];
}

- (UIImage*)screenView:(UIView *)view scale:(CGFloat)scale {
    CGRect rect = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width * scale, view.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

-(void) touchesBegan: (NSSet *)touches withEvent: (UIEvent *)event
{
	[self touchesMoved:touches withEvent:event];
}

-(void) touchesMoved: (NSSet *)touches withEvent: (UIEvent *)event
{
	CGPoint pt = [[touches anyObject] locationInView:self];
	int newRating = (int) (pt.x / (width+_ratingGap)) + 1;
	if (newRating < 1 || newRating > 5)
		return;
	
	if (newRating != lastRating)
		[self displayRating:newRating];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	[self touchesMoved:touches withEvent:event];
}

-(float)rating {
	return starRating;
}

@end
