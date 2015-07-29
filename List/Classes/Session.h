//
//  Session.h
//  List
//
//  Created by Noah Portes Chaikin on 7/5/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

typedef NS_ENUM(NSUInteger, SessionAuthTokenKind) {
    SessionAuthTokenKindSessionToken,
    SessionAuthTokenKindFacebookAccessToken
};

@class Session;

@protocol SessionDelegate <NSObject>

@optional
- (void)sessionAuthenticated:(Session *)session;
- (void)session:(Session *)session failedToAuthenticateWithError:(NSError *)error;
- (void)session:(Session *)session failedToAuthenticateWithResponse:(id<NSObject>)body;
- (void)sessionDeauthenticated:(Session *)session;
- (void)session:(Session *)session failedToDeauthenticateWithError:(NSError *)error;
- (void)session:(Session *)session failedToDeauthenticateWithResponse:(id<NSObject>)body;
- (void)sessionSavedDeviceToken:(Session *)session;
- (void)session:(Session *)session failedToSaveDeviceTokenWithError:(NSError *)error;
- (void)session:(Session *)session failedToSaveDeviceTokenWithResponse:(id<NSObject>)body;

@end

@interface Session : NSObject

@property (weak, nonatomic) id<SessionDelegate> delegate;
@property (copy, nonatomic, readonly) NSString *sessionToken;
@property (strong, nonatomic, readonly) User *user;
@property (strong, nonatomic, readonly) NSString *deviceToken;

- (void)authWithTokenKind:(SessionAuthTokenKind)tokenKind
               tokenValue:(NSString *)tokenValue
               onComplete:(void(^)(Session *session))onComplete
                  onError:(void(^)(NSError *error))onError
                   onFail:(void(^)(id<NSObject> body))onFail;

- (void)deauth:(void(^)(Session *session))onComplete
       onError:(void(^)(NSError *error))onError
        onFail:(void(^)(id<NSObject> body))onFail;

- (void)saveDeviceToken:(NSString *)deviceToken
             onComplete:(void(^)(Session *session))onComplete
                onError:(void(^)(NSError *error))onError
                 onFail:(void(^)(id<NSObject> body))onFail;

@end
