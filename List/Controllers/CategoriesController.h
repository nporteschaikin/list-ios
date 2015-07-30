//
//  CategoriesController.h
//  List
//
//  Created by Noah Portes Chaikin on 7/23/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PostCategory.h"

@class CategoriesController;

@protocol CategoriesControllerDelegate <NSObject>

@optional
- (void)categoriesControllerDidRequestCategories:(CategoriesController *)categoriesController;
- (void)categoriesControllerDidFetchCategories:(CategoriesController *)categoriesController;
- (void)categoriesController:(CategoriesController *)categoriesController failedToFetchCategoriesWithError:(NSError *)error;
- (void)categoriesController:(CategoriesController *)categoriesController failedToFetchCategoriesWithResponse:(id<NSObject>)response;

@end;

@interface CategoriesController : NSObject

@property (weak, nonatomic) id<CategoriesControllerDelegate> delegate;
@property (copy, nonatomic, readonly) NSArray *categories;

- (void)requestCategories;

@end
