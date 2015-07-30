//
//  LLocationManager.h
//  List
//
//  Created by Noah Portes Chaikin on 7/7/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef NS_ENUM(NSUInteger, LLocationManagerEvent) {
    LLocationManagerEventUpdateLocation,
    LLocationManagerEventFailed,
    LLocationManagerEventChangedAuthorizationStatus
};

@class LLocationManager;

@protocol LLocationManagerListener <NSObject>

- (void)locationManager:(LLocationManager *)manager
                  event:(LLocationManagerEvent)event;

@end

@interface LLocationManager : NSObject

+ (instancetype)sharedManager;

@property (strong, nonatomic, readonly) CLLocation *location;
@property (nonatomic, readonly) CLAuthorizationStatus authorizationStatus;

- (void)start;
- (void)stop;
- (void)addListener:(id<LLocationManagerListener>)listener;
- (void)removeListener:(id<LLocationManagerListener>)listener;

@end
