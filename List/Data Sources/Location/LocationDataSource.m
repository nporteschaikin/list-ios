//
//  LocationDataSource.m
//  List
//
//  Created by Noah Portes Chaikin on 7/30/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "LocationDataSource.h"

@interface LocationDataSource ()

@property (strong, nonatomic) LocationController *locationController;
@property (strong, nonatomic) CategoriesController *categoriesController;

@end

@implementation LocationDataSource

- (instancetype)initWithLocationController:(LocationController *)locationController
                      categoriesController:(CategoriesController *)categoriesController {
    if (self = [super init]) {
        self.locationController = locationController;
        self.categoriesController = categoriesController;
    }
    return self;
}

#pragma mark - LocationHeaderViewDataSource

- (NSString *)locationHeaderView:(LocationHeaderView *)locationHeaderView controlTitleAtIndex:(NSInteger)index {
    CategoriesController *categoriesController = self.categoriesController;
    PostCategory *category = categoriesController.categories[index];
    return category.name;
}

- (NSInteger)numberOfControlsInLocationHeaderView:(LocationHeaderView *)locationHeaderView {
    CategoriesController *categoriesController = self.categoriesController;
    return categoriesController.categories.count;
}

- (NSString *)locationHeaderViewTitle:(LocationHeaderView *)locationHeaderView {
    LocationController *locationController = self.locationController;
    Placemark *placemark = locationController.placemark;
    return placemark.title;
}

@end
