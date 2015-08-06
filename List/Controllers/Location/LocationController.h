//
//  LocationController.h
//  List
//
//  Created by Noah Portes Chaikin on 7/30/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Placemark.h"

@class LocationController;

@protocol LocationControllerDelegate <NSObject>

@optional
- (void)locationControllerDidSetLocation:(LocationController *)locationController;
- (void)locationControllerDidRequestPlacemark:(LocationController *)locationController;
- (void)locationControllerDidFetchPlacemark:(LocationController *)locationController;
- (void)locationController:(LocationController *)locationController failedToFetchPlacemarkWithError:(NSError *)error;
- (void)locationController:(LocationController *)locationController failedToFetchPlacemarkWithResponse:(id<NSObject>)response;

@end

@interface LocationController : NSObject

@property (weak, nonatomic) id<LocationControllerDelegate> delegate;
@property (strong, nonatomic) CLLocation *location;
@property (strong, nonatomic) Placemark *placemark;

- (instancetype)initWithLocation:(CLLocation *)location;
- (void)requestPlacemark;

@end
