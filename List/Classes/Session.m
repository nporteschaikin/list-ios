//
//  Session.m
//  List
//
//  Created by Noah Portes Chaikin on 7/5/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "Session.h"
#import "APIRequest.h"
#import "Constants.h"

@interface Session ()

@property (copy, nonatomic) NSString *sessionToken;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSString *deviceToken;

@end

@implementation Session

- (void)authWithTokenKind:(SessionAuthTokenKind)tokenKind
               tokenValue:(NSString *)tokenValue
               onComplete:(void(^)(Session *session))onComplete
                  onError:(void(^)(NSError *error))onError
                   onFail:(void(^)(id<NSObject> body))onFail {
    
    /*
     * Create request object.
     */
    
    APIRequest *request = [[APIRequest alloc] init];
    request.endpoint = APIAuthEndpoint;
    request.method = APIRequestMethodPOST;
    
    /*
     * Tweak request based on token type and value.
     */
    
    switch (tokenKind) {
        case SessionAuthTokenKindSessionToken: {
            request.body = @{ @"sessionToken": tokenValue };
            break;
        }
        case SessionAuthTokenKindFacebookAccessToken: {
            request.body = @{ @"facebookAccessToken": tokenValue };
            break;
        }
    };
    
    /*
     * Send request.
     */
    
    [request sendRequest:^(NSDictionary *body) {
        
        /*
         * Save session token.
         */
        
        self.sessionToken = body[@"sessionToken"];
        
        /*
         * Save user.
         */
        
        User *user = [User fromJSONDict:body[@"user"]];
        self.user = user;
        
        /*
         * Run delegate.
         */
        
        if ([self.delegate respondsToSelector:@selector(sessionAuthenticated:)]) {
            [self.delegate sessionAuthenticated:self];
        }
        
        /*
         * Run callback.
         */
        
        if (onComplete) onComplete(self);
        
    } onError:^(NSError *error) {
        
        /*
         * Run delegate.
         */
        
        if ([self.delegate respondsToSelector:@selector(session:failedToAuthenticateWithError:)]) {
            [self.delegate session:self failedToAuthenticateWithError:error];
        }
        
        /*
         * Run callback.
         */
        
        if (onError) onError(error);
        
    } onFail:^(id<NSObject> body) {
        
        /*
         * Run delegate.
         */
        
        if ([self.delegate respondsToSelector:@selector(session:failedToAuthenticateWithResponse:)]) {
            [self.delegate session:self failedToAuthenticateWithResponse:body];
        }
        
        /*
         * Run callback.
         */
        
        if (onFail) onFail(body);
        
    }];
}

- (void)deauth:(void(^)(Session *session))onComplete
       onError:(void(^)(NSError *error))onError
        onFail:(void(^)(id<NSObject> body))onFail {
    
    /*
     * Create request object.
     */
    
    APIRequest *request = [[APIRequest alloc] init];
    request.endpoint = APIAuthEndpoint;
    request.method = APIRequestMethodDELETE;
    request.session = self;
    
    /*
     * Send request.
     */
    
    [request sendRequest:^(NSDictionary *body) {
        
        /*
         * Clear everything.
         */
        
        self.sessionToken = nil;
        self.user = nil;
        
        /*
         * Run delegate.
         */
        
        if ([self.delegate respondsToSelector:@selector(sessionDeauthenticated:)]) {
            [self.delegate sessionDeauthenticated:self];
        }
        
        /*
         * Run callback.
         */
        
        if (onComplete) onComplete(self);
        
    } onError:^(NSError *error) {
        
        /*
         * Run delegate.
         */
        
        if ([self.delegate respondsToSelector:@selector(session:failedToDeauthenticateWithError:)]) {
            [self.delegate session:self failedToDeauthenticateWithError:error];
        }
        
        /*
         * Run callback.
         */
        
        if (onError) onError(error);
        
    } onFail:^(id<NSObject> body) {
        
        /*
         * Run delegate.
         */
        
        if ([self.delegate respondsToSelector:@selector(session:failedToDeauthenticateWithResponse:)]) {
            [self.delegate session:self failedToDeauthenticateWithResponse:body];
        }
        
        /*
         * Run callback.
         */
        
        if (onFail) onFail(body);
        
    }];
}

- (void)saveDeviceToken:(NSString *)deviceToken
             onComplete:(void(^)(Session *session))onComplete
                onError:(void(^)(NSError *error))onError
                 onFail:(void(^)(id<NSObject> body))onFail {
    
    /*
     * Create request.
     */
    
    APIRequest *request = [[APIRequest alloc] init];
    request.endpoint = APIAuthAPSEndpoint;
    request.method = APIRequestMethodPOST;
    request.body = @{ @"deviceToken": deviceToken };
    request.session = self;
    
    /*
     * Send request.
     */
    
    [request sendRequest:^(id<NSObject> body) {
        
        /*
         * Set device token.
         */
        
        self.deviceToken = deviceToken;
        
        /*
         * Run callback.
         */
        
        if (onComplete) onComplete(self);
        
    } onError:^(NSError *error) {
        
        /*
         * Run delegate.
         */
        
        if ([self.delegate respondsToSelector:@selector(session:failedToSaveDeviceTokenWithError:)]) {
            [self.delegate session:self failedToSaveDeviceTokenWithError:error];
        }
        
        /*
         * Run callback.
         */
        
        if (onError) onError(error);
        
    } onFail:^(id<NSObject> body) {
        
        /*
         * Run delegate.
         */
        
        if ([self.delegate respondsToSelector:@selector(session:failedToSaveDeviceTokenWithResponse:)]) {
            [self.delegate session:self failedToSaveDeviceTokenWithResponse:body];
        }
        
        /*
         * Run callback.
         */
        
        if (onFail) onFail(body);
        
    }];
    
}

@end
