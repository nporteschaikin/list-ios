//
//  APIRequest.m
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "APIRequest.h"
#import "ListConstants.h"

@implementation APIRequest

+ (NSOperationQueue *)operationQueue {
    static NSOperationQueue *operationQueue;
    if (!operationQueue) {
        operationQueue = [[NSOperationQueue alloc] init];
    }
    return operationQueue;
}

- (void)sendRequest:(void(^)(id<NSObject> body))onComplete onError:(void(^)(NSError *error))onError onFail:(void(^)(id<NSObject> body))onFail {
    
    /*
     * Create base URL
     */
    
    NSURL *baseURL = [NSURL URLWithString:kAPIBaseURL];
    NSURL *url = [NSURL URLWithString:self.endpoint relativeToURL:baseURL];
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:url resolvingAgainstBaseURL:YES];
    
    if (self.query) {
        
        /*
         * Add query parameters.
         */
        
        NSMutableArray *queryItems = [NSMutableArray array];
        NSURLQueryItem *queryItem;
        id queryValue;
        for (NSString *key in self.query) {
            queryValue = self.query[key];
            queryItem = [NSURLQueryItem queryItemWithName:key value:queryValue];
            [queryItems addObject:queryItem];
        }
        components.queryItems = queryItems;
        url = [components URL];
        
    }
    
    /*
     * Create NSURLRequest.
     */
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = url;
    
    switch (self.method) {
        case APIRequestMethodPOST: {
            request.HTTPMethod = @"POST";
            break;
        }
        case APIRequestMethodPATCH: {
            request.HTTPMethod = @"PATCH";
            break;
        }
        case APIRequestMethodPUT: {
            request.HTTPMethod = @"PUT";
            break;
        }
        case APIRequestMethodDELETE: {
            request.HTTPMethod = @"DELETE";
            break;
        }
        default:
            request.HTTPMethod = @"GET";
            break;
    }
    
    // Set content type to JSON.
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // If session exists, use it.
    Session *session = self.session;
    if (session) {
        NSString *token = session.sessionToken;
        [request setValue:token forHTTPHeaderField:kAPITokenHeaderKey];
    }
    
    // If body exists, set as JSON.
    if (self.body) {
        request.HTTPBody = [NSJSONSerialization dataWithJSONObject:self.body options:0 error:nil];
    }
    
    /*
     * Send request asynchronously.
     */
    
    NSOperationQueue *operationQueue = [[self class] operationQueue];
    [NSURLConnection sendAsynchronousRequest:request queue:operationQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (connectionError) {
                if (onError) onError(connectionError);
            } else {
                id body = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                if (httpResponse.statusCode != 200) {
                    if (onFail) onFail(body);
                } else {
                    if (onComplete) onComplete(body);
                }
            }
        });
    }];
    
}

@end