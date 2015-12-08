//
//  PicturesController.m
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PicturesController.h"
#import "APIRequest.h"
#import "ListConstants.h"

@interface PicturesController ()

@property (strong, nonatomic) Session *session;
@property (copy, nonatomic) NSDictionary *conditions;
@property (copy, nonatomic) NSArray *pictures;
@property (copy, nonatomic) NSArray *tags;
@property (strong, nonatomic) Params *params;
@property (strong, nonatomic) Placemark *placemark;

@end

@implementation PicturesController

- (id)initWithSession:(Session *)session {
    if (self = [super init]) {
        self.session = session;
    }
    return self;
}

- (void)requestPictures {
    
    /*
     * Set link params.
     */
    
    Params *params = self.params = [[Params alloc] init];
    params.limit = 10;
    params.offset = 0;
    
    /*
     * Get request object.
     */
    
    APIRequest *request = [self request];
    
    /*
     * Perform request.
     */
    
    [request sendRequest:^(id<NSObject> body) {
        
        /*
         * Add pictures and tags.
         */
        
        self.pictures = [Picture fromJSONArray:(NSArray *)body[kAPIPicturesKey]];
        self.params = [Params fromJSONDict:(NSDictionary *)body[kAPIParamsKey]];
        self.tags = [Tag fromJSONArray:(NSArray *)body[kAPITagsKey]];
        self.placemark = [Placemark fromJSONDict:(NSDictionary *)body[kAPIPlacemarkKey]];

        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(picturesControllerDidFetchPictures:)]) {
            [self.delegate picturesControllerDidFetchPictures:self];
        }
        
    } onError:^(NSError *error) {
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(picturesController:failedToFetchPicturesWithError:)]) {
            [self.delegate picturesController:self failedToFetchPicturesWithError:error];
        }
        
    } onFail:^(id<NSObject> body) {
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(picturesController:failedToFetchPicturesWithError:)]) {
            [self.delegate picturesController:self failedToFetchPicturesWithResponse:body];
        }
        
    }];
    
}

- (void)requestNextPictures {
    
    /*
     * If no pictures set, skip.
     */
    
    if (!self.pictures) return;
    
    // TODO: finish
    
}

#pragma mark - Request builder

- (APIRequest *)request {
    
    /*
     * Create request.
     */
    
    APIRequest *request = [[APIRequest alloc] init];
    request.method = APIRequestMethodGET;
    request.endpoint = kAPIPicturesEndpoint;
    request.session = self.session;
    
    /*
     * Build query.
     */
    
    NSMutableDictionary *query = [NSMutableDictionary dictionary];
    
    // User
    if (self.user) {
        query[@"user"] = self.user.userID;
    }
    
    // Map circle
    if (self.mapCircle) {
        MapCircle *mapCircle = self.mapCircle;
        CLLocation *location = mapCircle.location;
        float radius = mapCircle.radius;
        if (location) {
            CLLocationCoordinate2D coordinate = location.coordinate;
            query[@"latitude"] = [[NSNumber numberWithDouble:coordinate.latitude] stringValue];
            query[@"longitude"] = [[NSNumber numberWithDouble:coordinate.longitude] stringValue];
        }
        if (radius) {
            query[@"radius"] = [NSString stringWithFormat:@"%f", radius];
        }
    }
    
    /*
     * Set link params.
     */
    
    if (self.params) {
        Params *params = self.params;
        query[@"offset"] = [NSString stringWithFormat:@"%ld", (long)params.offset];
        query[@"limit"] = [NSString stringWithFormat:@"%ld", (long)params.limit];
    }
    
    /*
     * Set query.
     */
    
    request.query = query;
    
    /*
     * Return request.
     */
    
    return request;
    
}

@end
