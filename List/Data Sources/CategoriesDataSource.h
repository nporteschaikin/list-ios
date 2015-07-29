//
//  CategoriesDataSource.h
//  List
//
//  Created by Noah Portes Chaikin on 7/7/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "CategoriesHeaderView.h"
#import "APIRequest.h"
#import "PostCategory.h"
#import "CategoriesController.h"

@interface CategoriesDataSource : NSObject <CategoriesHeaderViewDataSource>

- (id)initWithCategoriesController:(CategoriesController *)categoriesController NS_DESIGNATED_INITIALIZER;

@end
