//
//  BGSegmentView.m
//  BGSegmentView
//
//  Created by user on 15/9/17.
//  Copyright (c) 2015年 lcg. All rights reserved.
//

#import "BGSegmentView.h"
#import "BGSegmentTextCell.h"

static const CGFloat kBottomLineHeight = 2.0f;
@interface BGSegmentView ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UIImageView *scrollLineImageView;
@property (nonatomic, strong) UICollectionView *collectionView;
@end
@implementation BGSegmentView
- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items{
    if(self = [super initWithFrame:frame]){
        self.items = items;
        CGFloat itemWidth = frame.size.width/items.count;
        if(itemWidth < 100){
            itemWidth = 100;
        }
        self.itemWidth = itemWidth;
        self.bottomLineWidth = self.itemWidth;
        self.selectTextColor = [UIColor redColor];
        self.normalTextColor = [UIColor blackColor];
        self.bottomLineColor = kMainColor;
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(self.itemWidth, self.bounds.size.height);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = UIColorFromRGB(0xf1f1f1);
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    
    [collectionView registerNib:[UINib nibWithNibName:[BGSegmentTextCell cellIdentifier] bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:[BGSegmentTextCell cellIdentifier]];
    
    UIImageView *scrollLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.itemWidth-self.bottomLineWidth)/2.0, self.bounds.size.height-kBottomLineHeight, self.bottomLineWidth, kBottomLineHeight)];
    scrollLineImageView.userInteractionEnabled = YES;
    scrollLineImageView.backgroundColor = self.bottomLineColor;
    [collectionView addSubview:scrollLineImageView];
    
    self.scrollLineImageView = scrollLineImageView;
}

- (void)updateScrollLineImageView{
    self.scrollLineImageView.frame = CGRectMake(self.itemWidth * self.selectIndex + (self.itemWidth - self.bottomLineWidth) / 2.0, self.bounds.size.height - kBottomLineHeight, self.bottomLineWidth, kBottomLineHeight-0.5);
}

- (void)updateCellLabelTextWith:(NSIndexPath *)indexPath{
    BGSegmentTextCell *lastCell = (BGSegmentTextCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:self.selectIndex]];
    lastCell.titleLabel.textColor = self.normalTextColor;
    BGSegmentTextCell *selectCell = (BGSegmentTextCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    selectCell.titleLabel.textColor = self.selectTextColor;
}
- (void)scrollToSelectIndexPath:(NSIndexPath *)indexPath{
    //滑动
    CGFloat left = self.itemWidth * indexPath.section + (self.itemWidth - self.bottomLineWidth) / 2.0;
    [UIView animateWithDuration:.2 animations:^{
        CGRect frame = self.scrollLineImageView.frame;
        frame.origin.x = left;
        self.scrollLineImageView.frame = frame;
    }];
    
    //cell滑动到对应的位置
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

#pragma mark - UICollectionViewDataSource method
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.items.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BGSegmentTextCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[BGSegmentTextCell cellIdentifier] forIndexPath:indexPath];
    cell.titleLabel.text = self.items[indexPath.section];
    if(indexPath.section == self.selectIndex){
        cell.titleLabel.textColor = self.selectTextColor;
    }
    else{
        cell.titleLabel.textColor = [UIColor blackColor];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    BGSegmentTextCell *lastCell = (BGSegmentTextCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:self.selectIndex]];
    lastCell.titleLabel.textColor = self.normalTextColor;
    BGSegmentTextCell *selectCell = (BGSegmentTextCell *)[collectionView cellForItemAtIndexPath:indexPath];
    selectCell.titleLabel.textColor = self.selectTextColor;
    //滑动到对应位置
    [self scrollToSelectIndexPath:indexPath];
    self.selectIndex = indexPath.section;
    
}

#pragma mark - set method
- (void)setSelectIndex:(NSInteger)selectIndex{
    if(_selectIndex == selectIndex){
        return;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:selectIndex];
    [self updateCellLabelTextWith:indexPath];
    _selectIndex = selectIndex;
    [self updateScrollLineImageView];
    //调用代理
    [_delegate segmentView:self didSelectIndex:_selectIndex];
}


- (void)setBottomLineWidth:(CGFloat)bottomLineWidth{
    if(bottomLineWidth > self.itemWidth){
        bottomLineWidth = self.itemWidth;
    }
    _bottomLineWidth = bottomLineWidth;
    [self updateScrollLineImageView];
}

- (void)setItemWidth:(CGFloat)itemWidth{
    if(_itemWidth == itemWidth){
        return;
    }
    [self.scrollLineImageView removeFromSuperview];
    [self.collectionView removeFromSuperview];
    _itemWidth = itemWidth;
    [self setupViews];
}

- (void)setBottomLineColor:(UIColor *)bottomLineColor{
    _bottomLineColor = bottomLineColor;
    self.scrollLineImageView.backgroundColor = bottomLineColor;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
