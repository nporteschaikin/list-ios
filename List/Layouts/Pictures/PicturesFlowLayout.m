//
//  PicturesFlowLayout.m
//  List
//
//  Created by Noah Portes Chaikin on 9/9/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PicturesFlowLayout.h"

@implementation PicturesFlowLayout

static CGFloat const kPicturesFlowLayoutSizeMultiplier = 0.75f;

- (instancetype)init {
    if (self = [super init]) {
        NSLog(@"%@", @"pictures flow layout initialized.");
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

- (CGRect)rectForItemAtIndex:(NSInteger)row {
    UICollectionView *collectionView = self.collectionView;
    CGFloat x, y, w, h;
    y = -1.f;
    w = CGRectGetWidth(collectionView.bounds) * kPicturesFlowLayoutSizeMultiplier;
    h = w;
    x = row * (w + 12.f);
    return CGRectMake(x, y, w, h);
}

#pragma mark - Overrides

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    UICollectionView *collectionView = self.collectionView;
    NSMutableArray *attributesArray = [NSMutableArray array];
    UICollectionViewLayoutAttributes *attributes;
    NSInteger count = [collectionView numberOfItemsInSection:0];
    CGRect frame;
    NSIndexPath *indexPath;
    for (int i=0; i<count; i++) {
        frame = [self rectForItemAtIndex:i];
        if (CGRectIntersectsRect(rect, frame)) {
            indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            [attributesArray addObject:attributes];
        }
    }
    return [NSArray arrayWithArray:attributesArray];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    NSInteger row = indexPath.row;
    attributes.frame = [self rectForItemAtIndex:row];
    return attributes;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(1000000, 500);
}

@end
