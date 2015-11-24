//
//  EventsLayout.m
//  List
//
//  Created by Noah Portes Chaikin on 11/18/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "EventsLayout.h"
#import "EventsCollectionViewCell.h"

@interface EventsLayout ()

@property (strong, nonatomic) EventsController *eventsController;

@end

@implementation EventsLayout

static CGFloat const kEventsLayoutSpace = 12.f;

- (instancetype)initWithEventsController:(EventsController *)eventsController {
    if (self = [super init]) {
        self.eventsController = eventsController;
    }
    return self;
}

- (CGRect)rectForItemAtIndex:(NSInteger)index {
    CGFloat x, y, w, h;
    EventsController *controller = self.eventsController;
    UICollectionView *collectionView = self.collectionView;
    NSArray *events = controller.events;
    NSInteger count = events.count;
    
    // get w
    w = CGRectGetWidth(collectionView.frame) - (kEventsLayoutSpace * 2);
    
    // get x
    x = kEventsLayoutSpace;
    
    // get y
    y = kEventsLayoutSpace;
    for (NSInteger i=0; i<count; i++) {
        if (i == index) break;
        y += [self heightForItemAtIndex:i];
        y += kEventsLayoutSpace;
    }
    
    // get h
    h = [self heightForItemAtIndex:index];
    
    return CGRectMake(x, y, w, h);
}

- (CGFloat)heightForItemAtIndex:(NSInteger)index {
    EventsController *controller = self.eventsController;
    NSArray *events = controller.events;
    if (index < events.count) {
        
        Event *event = events[index];
        UICollectionView *collectionView = self.collectionView;
        
        CGFloat width = CGRectGetWidth(collectionView.frame) - (kEventsLayoutSpace * 2);
        CGFloat height = 0.0f;
        CGRect rect;
        CGSize size;
        CGFloat w;
        
        // asset
        height += width * 0.5625f;
        height += kEventsCollectionViewCellMargin;
        
        // description
        w = width - (kEventsCollectionViewCellMargin * 2);
        rect = [event.text boundingRectWithSize:CGSizeMake(w, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont listFontWithSize:12.f]} context:nil];
        size = rect.size;
        height += size.height;
        height += kEventsCollectionViewCellMargin;
        
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
    EventsController *controller = self.eventsController;
    NSArray *events = controller.events;
    CGFloat width = CGRectGetWidth(collectionView.bounds);
    NSInteger count = events.count;
    CGFloat height = kEventsLayoutSpace;
    for (NSInteger i=0; i<count; i++) {
        height += [self heightForItemAtIndex:i];
        height += kEventsLayoutSpace;
    }
    return CGSizeMake(width, height);
}

@end
