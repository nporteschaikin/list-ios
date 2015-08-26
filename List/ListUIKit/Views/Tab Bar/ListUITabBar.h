//
//  ListUITabBar.h
//  List
//
//  Created by Noah Portes Chaikin on 8/14/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListUITabBarItem.h"

@class ListUITabBar;

@protocol ListUITabBarDelegate <NSObject>

@optional;
- (void)tabBar:(ListUITabBar *)tabBar didSelectItem:(ListUITabBarItem *)item;

@end

@interface ListUITabBar : UIView

@property (weak, nonatomic) id<ListUITabBarDelegate> delegate;
@property (strong, nonatomic) ListUITabBarItem *selectedItem;
@property (strong, nonatomic) NSArray *items;

@end
