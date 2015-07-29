//
//  PostDataSource.m
//  List
//
//  Created by Noah Portes Chaikin on 7/16/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PostDataSource.h"
#import "NSDate+TimeAgo.h"
#import "UIImageView+WebCache.h"
#import "UIColor+List.h"

@interface PostDataSource ()

@property (strong, nonatomic) PostController *postController;

@end

@implementation PostDataSource

static NSString * const PostViewDetailsCellReuseIdentifier = @"PostViewDetailsCellReuseIdentifier";
static NSString * const ThreadsTableViewCellReuseIdentifier = @"ThreadsTableViewCellReuseIdentifier";

- (instancetype)initWithPostController:(PostController *)postController {
    if (self = [super init]) {
        self.postController = postController;
    }
    return self;
}

- (void)registerReuseIdentifiersForTableView:(UITableView *)tableView {
    [tableView registerClass:[PostViewDetailsCell class]
      forCellReuseIdentifier:PostViewDetailsCellReuseIdentifier];
    [tableView registerClass:[ThreadsTableViewCell class]
      forCellReuseIdentifier:ThreadsTableViewCellReuseIdentifier];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    switch (section) {
            
        case PostDataSourceSectionDetails: {
            PostViewDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:PostViewDetailsCellReuseIdentifier];
            Post *post = self.postController.post;
            User *user = post.user;
            cell.titleLabel.text = post.title;
            cell.dateLabel.text = [post.createdAtDate timeAgo];
            cell.userNameLabel.text = user.displayName;
            cell.contentLabel.text = post.content;
            if (user.profilePictureURL) {
                [cell.avatarImageView sd_setImageWithURL:user.profilePictureURL];
            }
            if (post.coverPhotoURL) {
                cell.hasCoverPhoto = YES;
                [cell.coverPhotoView sd_setImageWithURL:post.coverPhotoURL];
            }
            Placemark *placemark = post.placemark;
            cell.postLocationView.locationLabel.text = placemark.neighborhood ? placemark.neighborhood
                : placemark.sublocality ? placemark.sublocality
                : placemark.country ? placemark.country : nil;
            [cell setNeedsLayout];
            [cell layoutIfNeeded];
            return cell;
        }
            
        case PostDataSourceSectionThreads: {
            ThreadsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ThreadsTableViewCellReuseIdentifier];
            Thread *thread = self.postController.post.threads[indexPath.row];
            User *user = thread.user;
            cell.userNameString = user.displayName;
            cell.contentString = thread.content;
            if (!thread.messages.count) {
                cell.repliesCounterView.numberLabel.text = @"No replies";
            } else if (thread.messages.count == 1) {
                cell.repliesCounterView.numberLabel.text = @"One reply";
            } else {
                cell.repliesCounterView.numberLabel.text = [NSString stringWithFormat:@"%ld replies", (unsigned long)thread.messages.count];
            }
            cell.dateLabel.text = [thread.createdAtDate timeAgo];
            if (thread.isPrivate) {
                cell.backgroundColor = thread.isPrivate ? [UIColor list_lightGrayColorAlpha:1.f]
                    : [UIColor whiteColor];
            }
            if (user.profilePictureURL) {
                [cell.avatarImageView sd_setImageWithURL:user.profilePictureURL];
            }
            [cell setNeedsLayout];
            [cell layoutIfNeeded];
            return cell;
        }
            
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case PostDataSourceSectionDetails: {
            return 1;
        }
        case PostDataSourceSectionThreads: {
            return self.postController.post.threads.count;
        }
    }
    return 0;
}

@end
