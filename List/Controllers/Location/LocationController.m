//
//  LocationController.m
//  List
//
//  Created by Noah Portes Chaikin on 7/30/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "LocationController.h"
#import "APIRequest.h"
#import "Constants.h"

@implementation LocationController

- (instancetype)initWithLocation:(CLLocation *)location {
    if (self = [super init]) {
        
        /*
         * Silently set location.
         */
        
        _location = location;
        
    }
    return self;
}

- (void)setLocation:(CLLocation *)location {
    _location = location;
    if ([self.delegate respondsToSelector:@selector(locationControllerDidSetLocation:)]) {
        [self.delegate locationControllerDidSetLocation:self];
    }
}

- (void)requestPlacemark {
    CLLocation *location = self.location;
    if (location) {
        APIRequest *request = [[APIRequest alloc] init];
        request.endpoint = APIGeocoderPlacemarkEndpoint;
        request.query = @{@"latitude": [[NSNumber numberWithDouble:location.coordinate.latitude] stringValue],
                          @"longitude": [[NSNumber numberWithDouble:location.coordinate.longitude] stringValue]};
        if ([self.delegate respondsToSelector:@selector(locationControllerDidRequestPlacemark:)]) {
            [self.delegate locationControllerDidRequestPlacemark:self];
        }
        [request sendRequest:^(id<NSObject> body) {
            
            /*
             * Set placemark.
             */
            
            self.placemark = [Placemark fromDict:(NSDictionary *)body];
            
            if ([self.delegate respondsToSelector:@selector(locationControllerDidFetchPlacemark:)]) {
                [self.delegate locationControllerDidFetchPlacemark:self];
            }
            
        } onError:^(NSError *error) {
            
            /*
             * Could not find placemark.
             */
            
            if ([self.delegate respondsToSelector:@selector(locationController:failedToFetchPlacemarkWithError:)]) {
                [self.delegate locationController:self failedToFetchPlacemarkWithError:error];
            }
            
        } onFail:^(id<NSObject> body) {
            
            /*
             * Could not find placemark.
             */
            
            if ([self.delegate respondsToSelector:@selector(locationController:failedToFetchPlacemarkWithResponse:)]) {
                [self.delegate locationController:self failedToFetchPlacemarkWithResponse:body];
            }
            
        }];
    }
}

@end
