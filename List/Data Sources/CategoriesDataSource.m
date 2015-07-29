//
//  CategoriesDataSource.m
//  List
//
//  Created by Noah Portes Chaikin on 7/7/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "CategoriesDataSource.h"

@interface CategoriesDataSource ()

@property (strong, nonatomic) CategoriesController *categoriesController;

@end

@implementation CategoriesDataSource

- (id)initWithCategoriesController:(CategoriesController *)categoriesController {
    if (self = [super init]) {
        self.categoriesController = categoriesController;
    }
    return self;
}

#pragma mark - CategoriesHeaderViewDataSource

- (NSInteger)numberOfButtonsInCategoriesHeaderView:(CategoriesHeaderView *)headerView {
    return self.categoriesController.categories.count;
}

- (NSString *)categoriesHeaderView:(CategoriesHeaderView *)headerView
              textForButtonAtIndex:(NSInteger)index {
    PostCategory *category = [self.categoriesController.categories objectAtIndex:index];
    return category.name;
}

@end
