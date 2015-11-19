//
//  APIRequest.m
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "APIRequest.h"
#import "ListConstants.h"

@interface APIRequest () <NSURLConnectionDataDelegate>

@property (strong, nonatomic) NSURLConnection *connection;
@property (strong, nonatomic) NSMutableData *data;
@property (strong, nonatomic) NSHTTPURLResponse *response;
@property (strong, nonatomic) void (^onCompleteBlock)(id<NSObject>);
@property (strong, nonatomic) void (^onProgressBlock)(NSInteger, NSInteger);
@property (strong, nonatomic) void (^onErrorBlock)(NSError *);
@property (strong, nonatomic) void (^onFailBlock)(id<NSObject>);

@end

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
     * Use main method.
     */
    
    [self sendRequest:onComplete onProgress:nil onError:onError onFail:onFail];
    
}

- (void)sendRequest:(void(^)(id<NSObject> body))onComplete onProgress:(void (^)(NSInteger, NSInteger))onProgress onError:(void (^)(NSError *))onError onFail:(void (^)(id<NSObject>))onFail {
    
    /*
     * If connection exists here, cancel it.
     */
    
    if (self.connection) {
        [self.connection cancel];
        self.onCompleteBlock = nil;
        self.onErrorBlock = nil;
        self.onFailBlock = nil;
    }
    
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
    
    NSURLConnection *connection = self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    self.onCompleteBlock = onComplete;
    self.onErrorBlock = onError;
    self.onFailBlock = onFail;
    self.onProgressBlock = onProgress;
    NSOperationQueue *operationQueue = [[self class] operationQueue];
    [connection setDelegateQueue:operationQueue];
    [connection start];
    NSLog(@"[%@] %@", request.HTTPMethod, request.URL);
    
}

#pragma mark - NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response {
    self.response = response;
    self.data = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite {
    if (self.onProgressBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.onProgressBlock(totalBytesWritten, totalBytesExpectedToWrite);
        });
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if (self.onErrorBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.onErrorBlock(error);
        });
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    id body = [NSJSONSerialization JSONObjectWithData:self.data options:kNilOptions error:nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.response.statusCode != 200 && self.onFailBlock) {
            self.onFailBlock(body);
        } else if (self.onCompleteBlock) {
            self.onCompleteBlock(body);
        }
    });
}

@end