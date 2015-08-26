//
//  ListUIPhotosView.m
//  List
//
//  Created by Noah Portes Chaikin on 8/25/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIPhotosView.h"
#import "UIColor+ListUI.h"

@interface ListUIPhotosView () <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (copy, nonatomic) NSArray *cells;
@property (nonatomic) NSInteger selectedIndex;

@end

@implementation ListUIPhotosView

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Set up defaults
         */
        
        self.expandedHeight = 375.f;
        self.collapsedHeight = 125.f;
        self.mininumAlpha = 0.75f;
        self.maximumAlpha = 1.0f;
        self.selectedIndex = 0;
        self.backgroundColor = [UIColor blackColor];
        
        /*
         * Set up scroll view.
         */
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.delegate = self;
        self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
        [self addSubview:self.scrollView];
        
    }
    return self;
}

- (void)setDataSource:(id<ListUIPhotosViewDataSource>)dataSource {
    
    /*
     * Set variable.
     */
    
    _dataSource = dataSource;
    
    /*
     * Reload data.
     */
    
    [self reloadData];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    /*
     * Set cell frames.
     */
    
    
    NSArray *cells = self.cells;
    ListUIPhotosViewCell *cell;
    for (NSInteger i=0; i<cells.count; i++) {
        cell = cells[i];
        cell.frame = [self frameForCellAtIndex:i];
        cell.alpha = [self alphaForCellAtIndex:i];
    }
    
    /*
     * Set content size.
     */
    
    [self setScrollViewContentSize];
    
}

- (void)reloadData {
    id<ListUIPhotosViewDataSource> dataSource = self.dataSource;
    NSInteger num = [dataSource numberOfRowsInPhotosView:self];
    UIScrollView *scrollView = self.scrollView;
    NSMutableArray *cells = [NSMutableArray array];
    ListUIPhotosViewCell *cell;
    
    /*
     * Remove existing cells.
     */
    
    for (cell in self.cells) {
        [cell removeFromSuperview];
    }
    
    /*
     * Add all cells.
     */
    
    for (NSInteger i=0; i<num; i++) {
        cell = [dataSource photosView:self cellForRowAtIndex:i];
        cell.frame = [self frameForCellAtIndex:i];
        cell.alpha = [self alphaForCellAtIndex:i];
        [scrollView addSubview:cell];
        [cells addObject:cell];
    }
    
    /*
     * Set to array.
     */
    
    self.cells = [NSArray arrayWithArray:cells];
    
    /*
     * Set content size.
     */
    
    [self setScrollViewContentSize];
    
}

- (CGFloat)percentVisibleForCellAtIndex:(NSInteger)index {
    
    /*
     * Get base framing details.
     */
    
    CGFloat collapsedHeight = self.collapsedHeight;
    
    /*
     * Get Y-offset.
     */
    
    UIScrollView *scrollView = self.scrollView;
    CGPoint contentOffset = scrollView.contentOffset;
    CGFloat offsetY = contentOffset.y;
    
    /*
     * Get current "page", last page, and next page.
     */
    
    CGFloat cur = MAX(offsetY, 0) / collapsedHeight;
    CGFloat prev = floorf(cur);
    CGFloat next = ceilf(cur) ?: 1;
    
    /*
     * Figure out Y origin and height.
     */
    
    if (prev == (float)index) {
        return 1 - (cur - index);
    } else if (next == (float)index) {
        return 1 - (index - cur);
    }
    return 0;
    
}

- (CGRect)frameForCellAtIndex:(NSInteger)index {
    
    /*
     * Get base framing details.
     */
    
    CGFloat collapsedHeight = self.collapsedHeight;
    CGFloat expandedHeight = self.expandedHeight;
    
    /*
     * Get Y-offset.
     */
    
    UIScrollView *scrollView = self.scrollView;
    CGPoint contentOffset = scrollView.contentOffset;
    CGFloat offsetY = contentOffset.y;

    /*
     * Get current "page", last page, and next page.
     */
    
    CGFloat cur = MAX(offsetY, 0) / collapsedHeight;
    CGFloat prev = floorf(cur);
    CGFloat next = ceilf(cur) ?: 1;
    CGFloat pct = [self percentVisibleForCellAtIndex:index];
    CGFloat x, y, w, h;
    x = 0.0f;
    w = CGRectGetWidth(scrollView.bounds);
    
    /*
     * Figure out Y origin and height.
     */
    
    if (prev == (float)index) {
        y = collapsedHeight * index;
        h = collapsedHeight + ((expandedHeight - collapsedHeight) * pct);
    } else if (next == (float)index) {
        y = (collapsedHeight * (index - 1)) + (expandedHeight - ((expandedHeight - collapsedHeight) * pct));
        h = collapsedHeight + ((expandedHeight - collapsedHeight) * pct);
    } else if (prev < index) {
        y = (collapsedHeight * (index - 1)) + expandedHeight;
        h = collapsedHeight;
    } else {
        y = (collapsedHeight * index);
        h = collapsedHeight;
    }
    
    id<ListUIPhotosViewDataSource> dataSource = self.dataSource;
    NSInteger num = [dataSource numberOfRowsInPhotosView:self];
    
    /*
     * If we're at the bottom and there's room left,
     * adjust the height.
     */
    
    if (index == (num - 1) && offsetY > (y + h) - CGRectGetHeight(scrollView.bounds)) {
        h += CGRectGetHeight(scrollView.bounds) - ((y + h) - offsetY);
    }
    
    /*
     * If we're at the bottom and there's room left,
     * adjust the height.
     */
    
    if (index == 0 && offsetY < 0) {
        y += offsetY;
        h -= offsetY;
    }
    
    /*
     * Apply.
     */
    
    return CGRectMake(x, y, w, h);
    
}

- (CGFloat)alphaForCellAtIndex:(NSInteger)index {
    
    /*
     * Get base alpha details.
     */
    
    CGFloat minimumAlpha = self.mininumAlpha;
    CGFloat maximumAlpha = self.maximumAlpha;
    
    /*
     * Get percent visible.
     */
    
    CGFloat pct = [self percentVisibleForCellAtIndex:index];
    
    /*
     * Return percentage.
     */
    
    return minimumAlpha + ((maximumAlpha - minimumAlpha) * pct);
    
}

- (void)setScrollViewContentSize {
    
    /*
     * Set content size.
     */
    
    UIScrollView *scrollView = self.scrollView;
    id<ListUIPhotosViewDataSource> dataSource = self.dataSource;
    NSInteger num = [dataSource numberOfRowsInPhotosView:self];
    NSInteger collapsedHeight = self.collapsedHeight;
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(scrollView.bounds), ((num - 1) * collapsedHeight) + CGRectGetHeight(scrollView.bounds));
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    /*
     * Set cell frames.
     */
    
    NSArray *cells = self.cells;
    ListUIPhotosViewCell *cell;
    for (NSInteger i=0; i<cells.count; i++) {
        cell = cells[i];
        cell.frame = [self frameForCellAtIndex:i];
        cell.alpha = [self alphaForCellAtIndex:i];
    }
    
}

//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
//    CGFloat height = self.collapsedHeight;
//    NSInteger current = self.selectedIndex;
//    NSInteger next;
//    if (velocity.y == 0) {
//        next = floor((targetContentOffset->y - height / 2) / height) + 1;
//    } else {
//        next = velocity.y > 0 ? current + 1 : current - 1;
//    }
//
//    *targetContentOffset = CGPointMake(targetContentOffset->x, next * height);
//    self.selectedIndex = next;
//}

@end
