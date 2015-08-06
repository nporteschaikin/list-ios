//
//  UserDataSource.m
//  List
//
//  Created by Noah Portes Chaikin on 7/21/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "UserDataSource.h"
#import "UserController.h"
#import "NSDate+TimeAgo.h"
#import "UIImageView+WebCache.h"

@interface UserDataSource ()

@property (strong, nonatomic) UserController *userController;
@property (strong, nonatomic) PostsController *postsController;
@property (strong, nonatomic) PostsDataSource *postsDataSource;

@end

@implementation UserDataSource

static NSString * const UserViewCoverPhotoCellReuseIdentifier = @"UserViewCoverPhotoCellReuseIdentifier";
static NSString * const UserViewBioCellReuseIdentifier = @"UserViewBioCellReuseIdentifier";

- (instancetype)initWithUserController:(UserController *)userController
                       postsController:(PostsController *)postsController {
    if (self = [super init]) {
        self.userController = userController;
        self.postsController = postsController;
        self.postsDataSource = [[PostsDataSource alloc] initWithPostsController:postsController];
    }
    return self;
}

- (void)registerReuseIdentifiersForTableView:(UITableView *)tableView {
    [tableView registerClass:[UserViewCoverPhotoCell class]
      forCellReuseIdentifier:UserViewCoverPhotoCellReuseIdentifier];
    [tableView registerClass:[UserViewBioCell class]
      forCellReuseIdentifier:UserViewBioCellReuseIdentifier];
    [self.postsDataSource registerReuseIdentifiersForTableView:tableView];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    UserController *userController = self.userController;
    User *user = userController.user;
    switch (section) {
        case UserDataSourceSectionDetails: {
            switch (row) {
                case UserDataSourceRowCoverPhoto: {
                    
                    // cover photo
                    UserViewCoverPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:UserViewCoverPhotoCellReuseIdentifier];
                    cell.nameLabel.text = user.displayName;
                    [cell.photoView sd_setImageWithURL:user.coverPhotoURL];
                    [cell.avatarImageView sd_setImageWithURL:user.profilePictureURL];
                    return cell;
                    
                }
                case UserDataSourceRowBio: {
                    
                    // bio
                    UserViewBioCell *cell = [tableView dequeueReusableCellWithIdentifier:UserViewBioCellReuseIdentifier];
                    cell.contentLabel.text = user.bio;
                    return cell;
                    
                }
            }
        }
        case UserDataSourceSectionPosts: {
            // posts
            return [self.postsDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
        }
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    UserController *userController = self.userController;
    User *user = userController.user;
    switch (section) {
        case UserDataSourceSectionDetails: {
            return user.bio ? 2 : 1;
        }
        case UserDataSourceSectionPosts: {
            return [self.postsDataSource tableView:tableView numberOfRowsInSection:0];
        }
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

@end
