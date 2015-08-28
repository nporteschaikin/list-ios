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

@property (copy, nonatomic) NSArray *cells;
@property (nonatomic) NSInteger selectedIndex;

@end

@implementation ListUIPhotosView

@dynamic delegate;

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Set up defaults
         */
        
        self.expandedHeight = 375.f;
        self.collapsedHeight = 40.f;
        self.mininumAlpha = 0.5f;
        self.maximumAlpha = 1.0f;
        self.selectedIndex = 0;
        self.backgroundColor = [UIColor listBlackColorAlpha:1];
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        
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
    
    [self updateContentSize];
    
}

- (void)reloadData {
    id<ListUIPhotosViewDataSource> dataSource = self.dataSource;
    NSInteger num = [dataSource numberOfRowsInPhotosView:self];
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
        [self addSubview:cell];
        [cells addObject:cell];
    }
    
    /*
     * Set to array.
     */
    
    self.cells = [NSArray arrayWithArray:cells];
    
    /*
     * Set content size.
     */
    
    [self updateContentSize];
    
}

- (CGFloat)percentVisibleForCellAtIndex:(NSInteger)index {
    
    /*
     * Get base framing details.
     */
    
    CGFloat collapsedHeight = self.collapsedHeight;
    
    /*
     * Get Y-offset.
     */
    
    CGPoint contentOffset = self.contentOffset;
    CGFloat offsetY = contentOffset.y;
    
    /*
     * Get top inset.
     */
    
    UIEdgeInsets contentInset = self.contentInset;
    CGFloat insetTop = contentInset.top;
    
    /*
     * Get current "page", last page, and next page.
     */
    
    CGFloat cur = MAX((offsetY + insetTop), 0) / collapsedHeight;
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
    
    CGPoint contentOffset = self.contentOffset;
    CGFloat offsetY = contentOffset.y;
    
    /*
     * Get top inset.
     */
    
    UIEdgeInsets contentInset = self.contentInset;
    CGFloat insetTop = contentInset.top;

    /*
     * Get current "page", last page, and next page.
     */
    
    CGFloat cur = offsetY > -insetTop ? (MAX((offsetY + insetTop), 0) / collapsedHeight) : 0;
    CGFloat prev = floorf(cur);
    CGFloat next = prev + 1.0f;
    CGFloat pct = [self percentVisibleForCellAtIndex:index];
    CGFloat x, y, w, h;
    x = 0.0f;
    w = CGRectGetWidth(self.bounds);
    
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
    
    if (index == (num - 1) && offsetY > (y + h) - CGRectGetHeight(self.bounds)) {
        h += (CGRectGetHeight(self.bounds) - ((y + h) - offsetY));
    }
    
    /*
     * If we're at the bottom and there's room left,
     * adjust the height.
     */
    
    if (index == 0 && offsetY < -insetTop) {
        y += offsetY + insetTop;
        h -= offsetY + insetTop;
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

- (void)updateCells {
    
    /*
     * Set cell frames and alpha.
     */
    
    NSArray *cells = self.cells;
    ListUIPhotosViewCell *cell;
    for (NSInteger i=0; i<cells.count; i++) {
        cell = cells[i];
        cell.frame = [self frameForCellAtIndex:i];
        cell.alpha = [self alphaForCellAtIndex:i];
    }
    
}

- (void)updateContentSize {
    
    /*
     * Set content size.
     */
    
    id<ListUIPhotosViewDataSource> dataSource = self.dataSource;
    NSInteger num = [dataSource numberOfRowsInPhotosView:self];
    NSInteger collapsedHeight = self.collapsedHeight;
    UIEdgeInsets contentInset = self.contentInset;
    CGFloat insetTop = contentInset.top;
    self.contentSize = CGSizeMake(CGRectGetWidth(self.bounds), (CGRectGetHeight(self.bounds) - insetTop) + ((num - 1) * collapsedHeight));
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    /*
     * Setup cells
     */
    
    [self updateCells];
    
}

- (void)setCollapsedHeight:(CGFloat)collapsedHeight {
    
    /*
     * Set variable.
     */
    
    _collapsedHeight = collapsedHeight;
    
    /*
     * Setup cells
     */
    
    [self updateCells];
    
}

- (void)setExpandedHeight:(CGFloat)expandedHeight {
    
    /*
     * Set variable.
     */
    
    _expandedHeight = expandedHeight;
    
    /*
     * Setup cells
     */
    
    [self updateCells];
    
}

- (void)setContentOffset:(CGPoint)contentOffset {
    [super setContentOffset:contentOffset];
    
    /*
     * Setup cells.
     */
    
    [self updateCells];
    
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
    [super setContentInset:contentInset];
    
    /*
     * Set content size.
     */
    
    [self updateContentSize];
    
}

@end
