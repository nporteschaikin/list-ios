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

static NSString * const UserViewDetailsCellReuseIdentifier = @"UserViewDetailsCellReuseIdentifier";

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
    [tableView registerClass:[UserViewDetailsCell class]
      forCellReuseIdentifier:UserViewDetailsCellReuseIdentifier];
    [self.postsDataSource registerReuseIdentifiersForTableView:tableView];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    switch (section) {
            
        case UserDataSourceSectionDetails: {
            UserViewDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:UserViewDetailsCellReuseIdentifier];
            UserController *userController = self.userController;
            User *user = userController.user;
            cell.nameLabel.text = user.displayName;
            cell.bioLabel.text = user.bio;
            if (user.profilePictureURL) {
                [cell.avatarImageView sd_setImageWithURL:user.profilePictureURL];
            }
            if (user.coverPhotoURL) {
                [cell.coverPhotoView sd_setImageWithURL:user.coverPhotoURL];
            }
            if ([userController.user isEqual:userController.session.user]) {
                [cell.button setTitle:@"Edit"
                             forState:UIControlStateNormal];
            } else {
                cell.button.hidden = YES;
            }
            [cell setNeedsLayout];
            [cell layoutIfNeeded];
            
            return cell;
        }
            
        case UserDataSourceSectionPosts: {
            return [self.postsDataSource tableView:tableView
                             cellForRowAtIndexPath:indexPath];
        }
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case UserDataSourceSectionDetails: {
            return 1;
        }
        case UserDataSourceSectionPosts: {
            return [self.postsDataSource tableView:tableView
                             numberOfRowsInSection:0];
        }
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

@end
