//
//  LocationDataSource.h
//  List
//
//  Created by Noah Portes Chaikin on 7/30/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "LocationHeaderView.h"
#import "LocationController.h"
#import "CategoriesController.h"

@interface LocationDataSource : NSObject <LocationHeaderViewDataSource>

- (instancetype)initWithLocationController:(LocationController *)locationController
                      categoriesController:(CategoriesController *)categoriesController NS_DESIGNATED_INITIALIZER;

@end
