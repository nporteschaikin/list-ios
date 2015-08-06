//
//  UserController.h
//  List
//
//  Created by Noah Portes Chaikin on 7/23/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Session.h"

@class UserController;

@protocol UserControllerDelegate <NSObject>

@optional
- (void)userControllerDidFetchUser:(UserController *)userController;
- (void)userController:(UserController *)userController failedToFetchUserWithError:(NSError *)error;
- (void)userController:(UserController *)userController failedToFetchUserWithResponse:(id<NSObject>)response;
- (void)userControllerDidSaveUser:(UserController *)userController;
- (void)userController:(UserController *)userController failedToSaveUserWithError:(NSError *)error;
- (void)userController:(UserController *)userController failedToSaveUserWithResponse:(id<NSObject>)response;

@end

@interface UserController : NSObject

@property (weak, nonatomic) id<UserControllerDelegate> delegate;
@property (strong, nonatomic, readonly) User *user;
@property (strong, nonatomic, readonly) Session *session;

- (id)initWithUser:(User *)user
           session:(Session *)session NS_DESIGNATED_INITIALIZER;
- (void)requestUser;
- (void)saveUser;

@end
