//
//  BGDemoCell.h
//  BGSelectSectionViewDemo
//
//  Created by user on 15/9/15.
//  Copyright (c) 2015年 lcg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BGSegmentTextCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
+ (NSString*)cellIdentifier;
@end
