//
//  APIRequest.h
//  List
//
//  Created by Noah Portes Chaikin on 7/3/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Session.h"

typedef NS_ENUM(NSUInteger, APIRequestMethod) {
    APIRequestMethodGET,
    APIRequestMethodPOST,
    APIRequestMethodPUT,
    APIRequestMethodPATCH,
    APIRequestMethodDELETE
};

@interface APIRequest : NSObject

@property (nonatomic) APIRequestMethod method;
@property (copy, nonatomic) NSString *endpoint;
@property (copy, nonatomic) NSDictionary *query;
@property (nonatomic) id body;
@property (strong, nonatomic) Session *session;

- (void)sendRequest:(void(^)(id<NSObject> body))onComplete
            onError:(void(^)(NSError *error))onError
             onFail:(void(^)(id<NSObject> body))onFail;

@end
