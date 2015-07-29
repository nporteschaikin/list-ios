//
//  CategoriesHeaderView.h
//  List
//
//  Created by Noah Portes Chaikin on 7/2/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIconControl.h"

@class CategoriesHeaderView;

@protocol CategoriesHeaderViewDataSource <NSObject>

- (NSInteger)numberOfButtonsInCategoriesHeaderView:(CategoriesHeaderView *)headerView;
- (NSString *)categoriesHeaderView:(CategoriesHeaderView *)headerView
                  textForButtonAtIndex:(NSInteger)index;

@end

@protocol CategoriesHeaderViewDelegate <NSObject>

@optional

- (void)categoriesHeaderView:(CategoriesHeaderView *)headerView
         buttonTappedAtIndex:(NSInteger)index;

@end

@interface CategoriesHeaderView : UIView

@property (weak, nonatomic) id<CategoriesHeaderViewDataSource> dataSource;
@property (weak, nonatomic) id<CategoriesHeaderViewDelegate> delegate;
@property (strong, nonatomic, readonly) LIconControl *menuControl;
@property (nonatomic, readonly) NSInteger selectedIndex;

- (void)reloadData;
- (void)selectButtonAtIndex:(NSInteger)index;

@end
