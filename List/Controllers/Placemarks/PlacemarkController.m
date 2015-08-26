//
//  PlacemarkController.m
//  List
//
//  Created by Noah Portes Chaikin on 8/23/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PlacemarkController.h"
#import "APIRequest.h"
#import "ListConstants.h"

@interface PlacemarkController ()

@property (strong, nonatomic) Placemark *placemark;

@end

@implementation PlacemarkController

- (void)requestPlacemark {
    
    /*
     * Create request.
     */
    
    APIRequest *request = [[APIRequest alloc] init];
    request.method = APIRequestMethodGET;
    request.endpoint = kAPIPlacemarkEndpoint;
    
    /*
     * Build query.
     */
    
    NSMutableDictionary *query = [NSMutableDictionary dictionary];
    if (self.location) {
        CLLocation *location = self.location;
        CLLocationCoordinate2D coordinate = location.coordinate;
        query[@"latitude"] = [[NSNumber numberWithDouble:coordinate.latitude] stringValue];
        query[@"longitude"] = [[NSNumber numberWithDouble:coordinate.longitude] stringValue];
    }
    
    /*
     * Set query.
     */
    
    request.query = query;
    
    /*
     * Perform request.
     */
    
    [request sendRequest:^(id<NSObject> body) {
        
        /*
         * Add pictures.
         */
        
        self.placemark = [Placemark fromJSONDict:(NSDictionary *)body[kAPIPlacemarkKey]];
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(placemarkControllerDidFetchPlacemark:)]) {
            [self.delegate placemarkControllerDidFetchPlacemark:self];
        }
        
    } onError:^(NSError *error) {
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(placemarkController:failedToFetchPlacemarkWithError:)]) {
            [self.delegate placemarkController:self failedToFetchPlacemarkWithError:error];
        }
        
    } onFail:^(id<NSObject> body) {
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(placemarkController:failedToFetchPlacemarkWithResponse:)]) {
            [self.delegate placemarkController:self failedToFetchPlacemarkWithResponse:body];
        }
        
    }];
    
}

@end
