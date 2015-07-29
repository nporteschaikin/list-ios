//
//  UserEditorDataSource.m
//  List
//
//  Created by Noah Portes Chaikin on 7/28/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "UserEditorDataSource.h"
#import "UIImageView+WebCache.h"

@interface UserEditorDataSource ()

@property (strong, nonatomic) UserController *userController;

@end

@implementation UserEditorDataSource

static NSString * const UserEditorPhotoTableViewCellReuseIdentifier = @"UserEditorPhotoTableViewCellReuseIdentifier";
static NSString * const UserEditorTextViewTableViewCellReuseIdentifier = @"UserEditorTextViewTableViewCellReuseIdentifier";

- (instancetype)initWithUserController:(UserController *)userController {
    if (self = [super init]) {
        self.userController = userController;
    }
    return self;
}

- (void)registerReuseIdentifiersForTableView:(UITableView *)tableView {
    [tableView registerClass:[UserEditorPhotoTableViewCell class]
      forCellReuseIdentifier:UserEditorPhotoTableViewCellReuseIdentifier];
    [tableView registerClass:[UserEditorTextViewTableViewCell class]
      forCellReuseIdentifier:UserEditorTextViewTableViewCellReuseIdentifier];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    User *user = self.userController.user;
    switch (section) {
        case UserEditorDataSourceSectionsPhotos: {
            UserEditorPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UserEditorPhotoTableViewCellReuseIdentifier];
            switch (row) {
                case UserEditorDataSourceSectionsPhotosRowsAvatar: {
                    if (user.profileImage) {
                        cell.photoView.image = user.profileImage;
                    } else if (user.profilePictureURL) {
                        [cell.photoView sd_setImageWithURL:user.profilePictureURL];
                    }
                    cell.label.text = @"Photo";
                    return cell;
                }
                case UserEditorDataSourceSectionsPhotosRowsCoverPhoto: {
                    if (user.coverImage) {
                        cell.photoView.image = user.coverImage;
                    } else if (user.coverPhotoURL) {
                        [cell.photoView sd_setImageWithURL:user.coverPhotoURL];
                    }
                    cell.label.text = @"Header";
                    return cell;
                }
            }
            [cell setNeedsLayout];
            [cell layoutIfNeeded];
            return cell;
        }
        case UserEditorDataSourceSectionsDetails: {
            switch (row) {
                case UserEditorDataSourceSectionsDetailsRowsBio: {
                    UserEditorTextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UserEditorTextViewTableViewCellReuseIdentifier];
                    cell.textView.placeholder = @"Bio";
                    cell.textView.text = user.bio;
                    [cell setNeedsLayout];
                    [cell layoutIfNeeded];
                    return cell;
                }
            }
        }
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case UserEditorDataSourceSectionsPhotos: {
            return 2;
        }
        case UserEditorDataSourceSectionsDetails: {
            return 1;
        }
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

@end
