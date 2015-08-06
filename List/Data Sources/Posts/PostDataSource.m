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
#import "NSDateFormatter+List.h"

@interface PostDataSource ()

@property (strong, nonatomic) PostController *postController;

@end

@implementation PostDataSource

static NSString * const ListCoverPhotoCellReuseIdentifier = @"ListCoverPhotoCellReuseIdentifier";
static NSString * const PostViewHeaderCellReuseIdentifier = @"PostViewHeaderCellReuseIdentifier";
static NSString * const PostViewContentCellReuseIdentifier = @"PostViewContentCellReuseIdentifier";
static NSString * const ThreadsTableViewCellReuseIdentifier = @"ThreadsTableViewCellReuseIdentifier";
static NSString * const ListIconTableViewCellReuseIdentifier = @"ListIconTableViewCellReuseIdentifier";

- (instancetype)initWithPostController:(PostController *)postController {
    if (self = [super init]) {
        self.postController = postController;
    }
    return self;
}

- (void)registerReuseIdentifiersForTableView:(UITableView *)tableView {
    [tableView registerClass:[ListCoverPhotoCell class]
      forCellReuseIdentifier:ListCoverPhotoCellReuseIdentifier];
    [tableView registerClass:[PostViewHeaderCell class]
      forCellReuseIdentifier:PostViewHeaderCellReuseIdentifier];
    [tableView registerClass:[PostViewContentCell class]
      forCellReuseIdentifier:PostViewContentCellReuseIdentifier];
    [tableView registerClass:[ThreadsTableViewCell class]
      forCellReuseIdentifier:ThreadsTableViewCellReuseIdentifier];
    [tableView registerClass:[ListIconTableViewCell class]
      forCellReuseIdentifier:ListIconTableViewCellReuseIdentifier];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    Post *post = self.postController.post;
    PostType type = post.type;
    NSArray *threads = post.threads;
    switch (section) {
        case PostDataSourceSectionDetails: {
            switch (row) {
                case PostDataSourceRowCoverPhoto: {
                    
                    // cover photo
                    ListCoverPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:ListCoverPhotoCellReuseIdentifier];
                    [cell.photoView sd_setImageWithURL:post.coverPhotoURL];
                    return cell;
                    
                }
                case PostDataSourceRowHeader: {
                
                    // header
                    PostViewHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:PostViewHeaderCellReuseIdentifier];
                    User *user = post.user;
                    cell.headerView.locationLabel.text = post.placemark.title;
                    cell.headerView.userNameLabel.text = user.displayName;
                    cell.headerView.dateLabel.text = [post.createdAtDate timeAgo];
                    [cell.headerView.avatarImageView sd_setImageWithURL:user.profilePictureURL];
                    return cell;
                    
                }
            }
            switch (type) {
                case PostTypeEvent: {
                    
                    /*
                     * Events.
                     */
                    
                    Event *event = post.event;
                    switch (row) {
                        case PostDataSourceRowEventTime: {
                            
                            // time
                            ListIconTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ListIconTableViewCellReuseIdentifier];
                            cell.label.text = [[NSDateFormatter list_defaultDateFormatter] stringFromDate:event.startTime];
                            cell.iconView.icon = LIconEvent;
                            return cell;
                            
                        }
                        case PostDataSourceRowEventPlace: {
                            
                            // place
                            ListIconTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ListIconTableViewCellReuseIdentifier];
                            cell.label.text = event.place;
                            cell.iconView.icon = LIconPlace;
                            return cell;
                            
                        }
                    }
                    break;
                }
                default: {
                    break;
                }
            }
            break;
        }
        case PostDataSourceSectionContent: {
            
            // content
            PostViewContentCell *cell = [tableView dequeueReusableCellWithIdentifier:PostViewContentCellReuseIdentifier];
            cell.contentLabel.text = post.content;
            return cell;
            
        }
        case PostDataSourceSectionThreads: {
            
            // threads
            ThreadsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ThreadsTableViewCellReuseIdentifier];
            Thread *thread = threads[row];
            User *user = thread.user;
            cell.userNameString = user.displayName;
            cell.contentString = thread.content;
            cell.dateLabel.text = [thread.createdAtDate timeAgo];
            cell.backgroundColor = thread.isPrivate ? [UIColor list_lightGrayColorAlpha:1.f] : [UIColor whiteColor];
            [cell.avatarImageView sd_setImageWithURL:user.profilePictureURL];
            return cell;
            
        }
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Post *post = self.postController.post;
    PostType type = post.type;
    NSArray *threads = post.threads;
    switch (section) {
        case PostDataSourceSectionDetails: {
            switch (type) {
                case PostTypeEvent: {
                    return 4;
                }
                case PostTypePost: {
                    return 2;
                }
            }
        }
        case PostDataSourceSectionContent: {
            return 1;
        }
        case PostDataSourceSectionThreads: {
            return threads.count;
        }
    }
    return 0;
}

@end
