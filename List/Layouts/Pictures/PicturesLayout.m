//
//  PicturesLayout.m
//  List
//
//  Created by Noah Portes Chaikin on 11/18/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PicturesLayout.h"
#import "PicturesCollectionViewCell.h"

@interface PicturesLayout ()

@property (strong, nonatomic) PicturesController *picturesController;

@end

@implementation PicturesLayout

static CGFloat const kPicturesLayoutSpace = 12.f;

- (instancetype)initWithPicturesController:(PicturesController *)picturesController {
    if (self = [super init]) {
        self.picturesController = picturesController;
    }
    return self;
}

- (CGRect)rectForItemAtIndex:(NSInteger)index {
    CGFloat x, y, w, h;
    PicturesController *controller = self.picturesController;
    UICollectionView *collectionView = self.collectionView;
    NSArray *pictures = controller.pictures;
    NSInteger count = pictures.count;
    
    // get w
    w = (CGRectGetWidth(collectionView.frame) - (kPicturesLayoutSpace * 3)) / 2;
    
    // get x
    x = index % 2 == 1 ? (kPicturesLayoutSpace * 2) + w : kPicturesLayoutSpace;
    
    // get y
    y = kPicturesLayoutSpace;
    for (NSInteger i=0; i<count; i++) {
        if (i >= index) {
            break;
        }
        if (index % 2 == i % 2) {
            y += [self heightForItemAtIndex:i];
            y += kPicturesLayoutSpace;
        }
    }
    
    // get h
    h = [self heightForItemAtIndex:index];
    
    return CGRectMake(x, y, w, h);
}

- (CGFloat)heightForItemAtIndex:(NSInteger)index {
    PicturesController *controller = self.picturesController;
    NSArray *pictures = controller.pictures;
    if (index < pictures.count) {
        
        Picture *picture = pictures[index];
        UICollectionView *collectionView = self.collectionView;
        
        CGFloat width = (CGRectGetWidth(collectionView.frame) - (kPicturesLayoutSpace * 3)) / 2;
        CGFloat height = 0.0f;
        CGRect rect;
        CGSize size;
        CGFloat w;
        
        // asset
        height += width * 1.777777777;
        height += kPicturesCollectionViewCellMargin;
        
        // description
        w = width - (kPicturesCollectionViewCellMargin * 2);
        rect = [picture.text boundingRectWithSize:CGSizeMake(w, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont listFontWithSize:11.f]} context:nil];
        size = rect.size;
        height += size.height;
        height += kPicturesCollectionViewCellMargin;
        
        // spacer
        height += 1.0f;
        height += kPicturesCollectionViewCellMargin;
        
        // avatar
        height += kPicturesCollectionViewCellAvatarViewSize;
        height += kPicturesCollectionViewCellMargin;
        
        return height;
        
    }
    return 0.f;
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
            if (attributes) {
                [attributesArray addObject:attributes];
            }
        }
    }
    return [NSArray arrayWithArray:attributesArray];
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [[super layoutAttributesForItemAtIndexPath:indexPath] copy];
    NSInteger row = indexPath.row;
    attributes.frame = [self rectForItemAtIndex:row];
    return attributes;
}

- (CGSize)collectionViewContentSize {
    UICollectionView *collectionView = self.collectionView;
    CGFloat width = CGRectGetWidth(collectionView.bounds);
    PicturesController *controller = self.picturesController;
    NSArray *pictures = controller.pictures;
    NSInteger count = pictures.count;
    CGFloat leftColumnHeight = kPicturesLayoutSpace;
    CGFloat rightColumnHeight = kPicturesLayoutSpace;
    for (NSInteger i=0; i<count; i++) {
        if (i % 2 == 0) {
            leftColumnHeight += [self heightForItemAtIndex:i];
            leftColumnHeight += kPicturesLayoutSpace;
        } else {
            rightColumnHeight += [self heightForItemAtIndex:i];
            rightColumnHeight += kPicturesLayoutSpace;
        }
    }
    return CGSizeMake(width, fmaxf(leftColumnHeight, rightColumnHeight));
}

@end
