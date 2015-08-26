//
//  PlacemarkController.h
//  List
//
//  Created by Noah Portes Chaikin on 8/23/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "Placemark.h"

@class PlacemarkController;

@protocol PlacemarkControllerDelegate <NSObject>

@optional
- (void)placemarkControllerDidFetchPlacemark:(PlacemarkController *)controller;
- (void)placemarkController:(PlacemarkController *)controller failedToFetchPlacemarkWithError:(NSError *)error;
- (void)placemarkController:(PlacemarkController *)controller failedToFetchPlacemarkWithResponse:(id<NSObject>)response;

@end

@interface PlacemarkController : NSObject

@property (weak, nonatomic) id<PlacemarkControllerDelegate> delegate;
@property (strong, nonatomic, readonly) Placemark *placemark;
@property (strong, nonatomic) CLLocation *location;

- (void)requestPlacemark;

@end
