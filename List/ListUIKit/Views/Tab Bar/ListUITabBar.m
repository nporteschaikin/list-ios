//
//  ListUITabBar.m
//  List
//
//  Created by Noah Portes Chaikin on 8/14/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUITabBar.h"
#import "UIColor+ListUI.h"

/*
 * @class ListUITabBarButton
 */

@interface ListUITabBarButton : UIButton

@end

@implementation ListUITabBarButton

- (void)layoutSubviews {
    
    /*
     * Set properties.
     */
    
    
    self.imageView.image = [self.currentImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.tintAdjustmentMode = self.isSelected ? UIViewTintAdjustmentModeNormal
        : UIViewTintAdjustmentModeDimmed;
    
    /*
     * Center image view.
     */
    
    CGSize size = [self.imageView sizeThatFits:CGSizeZero];
    CGFloat x = (CGRectGetWidth(self.frame) - size.width) / 2;
    CGFloat y = (CGRectGetHeight(self.frame) - size.height) / 2;
    CGFloat w = size.width;
    CGFloat h = size.height;
    self.imageView.frame = CGRectMake(x, y, w, h);
    
}

@end

/*
 * @class ListUITabBar
 */

@interface ListUITabBar ()

@property (copy, nonatomic) NSArray *buttons;

@end

@implementation ListUITabBar

static CGFloat const kListUITabBarDefaultHeight = 60.f;

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Set defaults.
         */
        
        self.tintColor = [UIColor listBlueColorAlpha:1];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    /*
     * Layout buttons.
     */
    
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat h = CGRectGetHeight(self.bounds);
    NSArray *buttons = self.buttons;
    CGFloat w = width / buttons.count;
    CGFloat x = 0;
    CGFloat y = 0;
    
    for (ListUITabBarButton *button in buttons) {
        button.frame = CGRectMake(x, y, w, h);
        x += w;
    }
    
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(size.width, kListUITabBarDefaultHeight);
}

#pragma mark - Buttons handler

- (void)handleButtonTouchDown:(UIButton *)button {
    
    /*
     * Only run if buttons contains button.
     */
    
    if ([self.buttons containsObject:button]) {
        NSInteger index = [self.buttons indexOfObject:button];
        ListUITabBarItem *item = self.items[index];
        
        /*
         * Set selected item.
         */
        
        self.selectedItem = item;
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(tabBar:didSelectItem:)]) {
            [self.delegate tabBar:self didSelectItem:item];
        }
    }
    
}

#pragma mark - Dynamic setters

- (void)setItems:(NSArray *)items {
    
    /*
     * Set items.
     */
    
    _items = items;
    
    /*
     * Remove old item buttons.
     */
    
    for (ListUITabBarButton *button in self.buttons) {
        [button removeFromSuperview];
    }
    
    /*
     * Create new item buttons.
     */
    
    NSMutableArray *buttons = [NSMutableArray array];
    ListUITabBarButton *button;
    for (ListUITabBarItem *item in items) {
        button = [[ListUITabBarButton alloc] init];
        button.adjustsImageWhenDisabled = YES;
        button.adjustsImageWhenHighlighted = NO;
        button.tintColor = self.tintColor;
        [button setTintAdjustmentMode:UIViewTintAdjustmentModeDimmed];
        [button setImage:item.image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(handleButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
        [buttons addObject:button];
        [self addSubview:button];
    }
    
    /*
     * Persist buttons in separate array.
     */
    
    self.buttons = [NSArray arrayWithArray:buttons];
    
}

- (void)setSelectedItem:(ListUITabBarItem *)selectedItem {
    
    /*
     * Only run if item exists.
     */
    
    if ([self.items containsObject:selectedItem]) {
        /*
         * Set selected item
         */
        
        _selectedItem = selectedItem;
        
        /*
         * Get button.
         */
        
        NSInteger index = [self.items indexOfObject:selectedItem];
        ListUITabBarButton *button;
        for (int i=0; i<self.buttons.count; i++) {
            button = self.buttons[i];
            if (i == index) {
                button.selected = YES;
                
                /*
                 * Set background.
                 */
                
                UIColor *backgroundColor = selectedItem.barBackgroundColor ?: [UIColor listLightGrayColorAlpha:0.9];
                self.backgroundColor = backgroundColor;
                
                continue;
            }
            button.selected = NO;
        }
        
    }
    
}

@end
