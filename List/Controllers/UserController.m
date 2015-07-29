//
//  UserController.m
//  List
//
//  Created by Noah Portes Chaikin on 7/23/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "UserController.h"
#import "APIRequest.h"
#import "Constants.h"

@interface UserController ()

@property (strong, nonatomic) User *user;
@property (strong, nonatomic) Session *session;

@end

@implementation UserController

- (id)initWithUser:(User *)user
           session:(Session *)session {
    if (self = [super init]) {
        self.user = user;
        self.session = session;
    }
    return self;
}


- (void)requestUser {
    APIRequest *request = [[APIRequest alloc] init];
    request.method = APIRequestMethodGET;
    request.endpoint = [NSString stringWithFormat:APIUserEndpoint, self.user.userID];
    request.session = self.session;
    [request sendRequest:^(id<NSObject> body) {
        
        /*
         * Update user.
         */
        
        [self.user applyJSON:(NSDictionary *)body];
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(userControllerDidFetchUser:)]) {
            [self.delegate userControllerDidFetchUser:self];
        }
        
    } onError:^(NSError *error) {
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(userController:failedToFetchUserWithError:)]) {
            [self.delegate userController:self
               failedToFetchUserWithError:error];
        }
        
    } onFail:^(id<NSObject> body) {
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(userController:failedToFetchUserWithResponse:)]) {
            [self.delegate userController:self failedToFetchUserWithResponse:body];
        }
        
    }];
}

- (void)saveUser {
    if ([self.session.user isEqual:self.user]) {
        APIRequest *request = [[APIRequest alloc] init];
        request.method = APIRequestMethodPUT;
        request.endpoint = [NSString stringWithFormat:APIUserEndpoint, self.user.userID];
        request.session = self.session;
        request.body = [self.user toJSON];
        [request sendRequest:^(id<NSObject> body) {
            
            /*
             * Update user.
             */
            
            [self.user applyJSON:(NSDictionary *)body];
            [self.session.user applyJSON:(NSDictionary *)body];
            
            /*
             * Send delegate message.
             */
            
            if ([self.delegate respondsToSelector:@selector(userControllerDidSaveUser:)]) {
                [self.delegate userControllerDidSaveUser:self];
            }
            
        } onError:^(NSError *error) {
            
            /*
             * Send delegate message.
             */
            
            if ([self.delegate respondsToSelector:@selector(userController:failedToSaveUserWithError:)]) {
                [self.delegate userController:self
                    failedToSaveUserWithError:error];
            }
            
        } onFail:^(id<NSObject> body) {
            
            /*
             * Send delegate message.
             */
            
            if ([self.delegate respondsToSelector:@selector(userController:failedToSaveUserWithResponse:)]) {
                [self.delegate userController:self failedToSaveUserWithResponse:body];
            }
            
        }];
    }
}

@end
