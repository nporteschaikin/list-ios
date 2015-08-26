//
//  PictureController.m
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PictureController.h"
#import "APIRequest.h"
#import "ListConstants.h"
#import "ListConstants.h"

@interface PictureController ()

@property (strong, nonatomic) Picture *picture;
@property (strong, nonatomic) Session *session;

@end

@implementation PictureController

- (instancetype)initWithPicture:(Picture *)picture session:(Session *)session {
    if (self = [super init]) {
        self.picture = picture;
        self.session = session;
    }
    return self;
}

- (void)savePicture {
    
    /*
     * Create request.
     */
    
    APIRequest *request = [[APIRequest alloc] init];
    request.method = self.picture.pictureID ? APIRequestMethodPUT : APIRequestMethodPOST;
    request.endpoint = self.picture.pictureID ? [NSString stringWithFormat:kAPIPictureEndpoint, self.picture.pictureID] : kAPIPicturesEndpoint;
    request.session = self.session;
    request.body = [self.picture toJSON];
    
    /*
     * Send request.
     */
    
    [request sendRequest:^(id<NSObject> body) {
        
        /*
         * Update picture.
         */
        
        [self.picture applyJSONDict:(NSDictionary *)body[kAPIPictureKey]];
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(pictureControllerDidSavePicture:)]) {
            [self.delegate pictureControllerDidSavePicture:self];
        }
        
    } onError:^(NSError *error) {
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(pictureController:failedToSavePictureWithError:)]) {
            [self.delegate pictureController:self failedToSavePictureWithError:error];
        }
        
    } onFail:^(id<NSObject> body) {
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(pictureController:failedToSavePictureWithError:)]) {
            [self.delegate pictureController:self failedToSavePictureWithResponse:body];
        }
        
    }];
    
}

@end
