//
//  TagsScrollView.m
//  List
//
//  Created by Noah Portes Chaikin on 8/23/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "TagsScrollView.h"

/*
 * @class TagsScrollViewButton
 */

@interface TagsScrollViewButton : UIButton

@end

@implementation TagsScrollViewButton

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Set defaults.
         */
        
        self.titleLabel.font = [UIFont listUI_fontWithSize:15.f];
        self.contentEdgeInsets = UIEdgeInsetsMake(6, 14, 6, 14);
        self.layer.borderWidth = 1.0f;
        self.layer.cornerRadius = 3.0f;
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    /*
     * Alter tint adjustment mode based on status.
     */
    
    self.tintAdjustmentMode = self.isSelected ? UIViewTintAdjustmentModeNormal : UIViewTintAdjustmentModeDimmed;
    
}

- (void)tintColorDidChange {
    
    /*
     * Set title color.
     */
    
    [self setTitleColor:self.tintColor forState:UIControlStateNormal];
    
    /*
     * Set border color.
     */
    
    self.layer.borderColor = self.tintColor.CGColor;
    
}

@end

/*
 * @class TagsScrollView
 */

@interface TagsScrollView ()

@property (copy, nonatomic) NSArray *buttons;

@end

@implementation TagsScrollView

@dynamic delegate;

static CGFloat const kTagsScrollViewDefaultHeight = 50.f;
static CGFloat const kTagsScrollViewSpacing = 12.f;

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Set defaults.
         */
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
    }
    return self;
}

- (void)selectTagAtIndex:(NSInteger)index {
    
}

- (void)deselectTagAtIndex:(NSInteger)index {
    
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    /*
     * Reload data.
     */
    
    [self reloadData];
    
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(size.width, kTagsScrollViewDefaultHeight);
}

- (void)reloadData {
    id<TagsScrollViewDataSource> dataSource = self.dataSource;
    
    /*
     * Remove all existing buttons.
     */
    
    NSArray *buttons = self.buttons;
    for (TagsScrollViewButton *button in buttons) {
        [button removeFromSuperview];
    }
    
    /*
     * Get number of tags.
     */
    
    NSInteger count = [dataSource numberOfTagsInTagsScrollView:self];
    
    /*
     * Create new buttons
     */
    
    NSMutableArray *newButtons = [NSMutableArray array];
    NSString *tag;
    TagsScrollViewButton *button;
    for (NSInteger i=0; i<count; i++) {
        
        /*
         * Create button.
         */
        
        tag = [dataSource tagsScrollView:self tagAtIndex:i];
        button = [[TagsScrollViewButton alloc] init];
        [button setTitle:tag forState:UIControlStateNormal];
        
        /*
         * Add target.
         */
        
        [button addTarget:self action:@selector(handleButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
        
        /*
         * Add to superview.
         */
        
        [self addSubview:button];
        
        /*
         * Add to array.
         */
        
        [newButtons addObject:button];
        
    }
    
    /*
     * Set buttons array.
     */
    
    self.buttons = [NSArray arrayWithArray:newButtons];
    
    /*
     * Layout buttons
     */
    
    [self layoutButtons];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    /*
     * Layout buttons.
     */
    
    [self layoutButtons];
    
}

#pragma mark - Private methods

- (void)layoutButtons {
    NSArray *buttons = self.buttons;
    TagsScrollViewButton *button;
    CGSize size;
    CGFloat x, y, w, h;
    
    /*
     * Layout buttons.
     */
    
    x = kTagsScrollViewSpacing;
    for (NSInteger i=0; i<buttons.count; i++) {
        button = buttons[i];
        size = [button sizeThatFits:CGSizeZero];
        y =  (CGRectGetHeight(self.bounds) - size.height) / 2;
        w = size.width;
        h = size.height;
        button.frame = CGRectMake(x, y, w, h);
        x += size.width + kTagsScrollViewSpacing;
    }
    
    /*
     * Set content size.
     */
    
    self.contentSize = CGSizeMake(x, CGRectGetHeight(self.bounds));
    
}

#pragma mark - Button handler

- (void)handleButtonTouchDown:(TagsScrollViewButton *)button {
    
    /*
     * Set state.
     */
    NSLog(@"%@", @"selected");
    button.selected = !button.isSelected;
    
}

@end
