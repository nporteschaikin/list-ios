//
//  UserDataSource.h
//  List
//
//  Created by Noah Portes Chaikin on 7/21/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Session.h"
#import "PostsDataSource.h"
#import "UserController.h"
#import "PostsController.h"
#import "UserViewCoverPhotoCell.h"
#import "UserViewBioCell.h"

typedef NS_ENUM(NSUInteger, UserDataSourceSection) {
    UserDataSourceSectionDetails = 0,
    UserDataSourceSectionPosts
};

typedef NS_ENUM(NSUInteger, UserDataSourceRow) {
    UserDataSourceRowCoverPhoto = 0,
    UserDataSourceRowBio
};

@interface UserDataSource : NSObject <UITableViewDataSource>

@property (strong, nonatomic, readonly) UserController *userController;
@property (strong, nonatomic, readonly) PostsController *postsController;

- (instancetype)initWithUserController:(UserController *)userController
                       postsController:(PostsController *)postsController;
- (void)registerReuseIdentifiersForTableView:(UITableView *)tableView;

@end
