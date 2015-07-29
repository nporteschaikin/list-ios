//
//  PostsDataSource.m
//  List
//
//  Created by Noah Portes Chaikin on 7/1/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PostsDataSource.h"
#import "APIRequest.h"
#import "NSDate+TimeAgo.h"
#import "UIImageView+WebCache.h"

@interface PostsDataSource ()

@property (strong, nonatomic) PostsController *postsController;

@end

@implementation PostsDataSource

static NSString * const PostsTableViewCellWithoutCoverPhotoImageReuseIdentifier = @"PostsTableViewCellWithoutCoverPhotoImageReuseIdentifier";
static NSString * const PostsTableViewCellWithCoverPhotoImageReuseIdentifier = @"PostsTableViewCellWithCoverPhotoImageReuseIdentifier";

- (id)initWithPostsController:(PostsController *)postsController {
    if (self = [super init]) {
        self.postsController = postsController;
    }
    return self;
}

- (void)registerReuseIdentifiersForTableView:(UITableView *)tableView {
    [tableView registerClass:[PostsTableViewCell class]
      forCellReuseIdentifier:PostsTableViewCellWithoutCoverPhotoImageReuseIdentifier];
    [tableView registerClass:[PostsTableViewCell class]
      forCellReuseIdentifier:PostsTableViewCellWithCoverPhotoImageReuseIdentifier];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostsController *postsController = self.postsController;
    Post *post = postsController.posts[indexPath.row];
    PostsTableViewCell *cell;
    if (post.coverPhotoURL) {
        cell = [tableView dequeueReusableCellWithIdentifier:PostsTableViewCellWithCoverPhotoImageReuseIdentifier];
        cell.coverPhotoImageView.hidden = NO;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:PostsTableViewCellWithoutCoverPhotoImageReuseIdentifier];
        cell.coverPhotoImageView.hidden = YES;
    }
    
    User *user = post.user;
    cell.titleLabel.text = post.title;
    cell.userNameLabel.text = user.displayName;
    cell.contentLabel.text = post.content;
    cell.dateLabel.text = [post.createdAtDate timeAgo];
    if (!post.threads.count) {
        cell.threadsCounterView.numberLabel.text = @"No comments";
    } else if (post.threads.count == 1) {
        cell.threadsCounterView.numberLabel.text = @"One comment";
    } else {
        cell.threadsCounterView.numberLabel.text = [NSString stringWithFormat:@"%ld comments", (unsigned long)post.threads.count];
    }
    
    /*
     * Show avatar image.
     */
    
    cell.avatarImageView.image = nil;
    if (user.profilePictureURL) {
        [cell.avatarImageView sd_setImageWithURL:user.profilePictureURL];
    }
    
    /*
     * Show photo view image.
     */
    
    cell.coverPhotoImageView.image = nil;
    if (post.coverPhotoURL) {
        [cell.coverPhotoImageView sd_setImageWithURL:post.coverPhotoURL];
    }
    
    /*
     * Set location label.
     */
    
    Placemark *placemark = post.placemark;
    cell.postLocationView.locationLabel.text = placemark.title;
    
    /*
     * Update layout sizes.
     */
    
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    PostsController *postsController = self.postsController;
    return postsController.posts.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end
