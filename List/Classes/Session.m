//
//  Session.m
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "Session.h"
#import "APIRequest.h"
#import "ListConstants.h"

@interface Session ()

@property (copy, nonatomic) NSString *sessionToken;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSString *deviceToken;

@end

@implementation Session

- (void)authWithTokenKind:(SessionAuthTokenKind)tokenKind tokenValue:(NSString *)tokenValue {
    
    /*
     * Create request object.
     */
    
    APIRequest *request = [[APIRequest alloc] init];
    request.endpoint = kAPIAuthEndpoint;
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
        
    } onError:^(NSError *error) {
        
        /*
         * Run delegate.
         */
        
        if ([self.delegate respondsToSelector:@selector(session:failedToAuthenticateWithError:)]) {
            [self.delegate session:self failedToAuthenticateWithError:error];
        }
        
    } onFail:^(id<NSObject> body) {
        
        /*
         * Run delegate.
         */
        
        if ([self.delegate respondsToSelector:@selector(session:failedToAuthenticateWithResponse:)]) {
            [self.delegate session:self failedToAuthenticateWithResponse:body];
        }
        
    }];
}

- (void)deauth {
    
    /*
     * Create request object.
     */
    
    APIRequest *request = [[APIRequest alloc] init];
    request.endpoint = kAPIAuthEndpoint;
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
        
    } onError:^(NSError *error) {
        
        /*
         * Run delegate.
         */
        
        if ([self.delegate respondsToSelector:@selector(session:failedToDeauthenticateWithError:)]) {
            [self.delegate session:self failedToDeauthenticateWithError:error];
        }
    } onFail:^(id<NSObject> body) {
        
        /*
         * Run delegate.
         */
        
        if ([self.delegate respondsToSelector:@selector(session:failedToDeauthenticateWithResponse:)]) {
            [self.delegate session:self failedToDeauthenticateWithResponse:body];
        }
        
    }];
}

- (void)saveDeviceToken:(NSString *)deviceToken {
    
    /*
     * Create request.
     */
    
    APIRequest *request = [[APIRequest alloc] init];
    request.endpoint = kAPIAPSEndpoint;
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
        
    } onError:^(NSError *error) {
        
        /*
         * Run delegate.
         */
        
        if ([self.delegate respondsToSelector:@selector(session:failedToSaveDeviceTokenWithError:)]) {
            [self.delegate session:self failedToSaveDeviceTokenWithError:error];
        }
        
    } onFail:^(id<NSObject> body) {
        
        /*
         * Run delegate.
         */
        
        if ([self.delegate respondsToSelector:@selector(session:failedToSaveDeviceTokenWithResponse:)]) {
            [self.delegate session:self failedToSaveDeviceTokenWithResponse:body];
        }
        
    }];
    
}

@end
