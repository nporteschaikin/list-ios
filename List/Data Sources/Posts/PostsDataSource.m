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
#import "NSDateFormatter+List.h"
#import "UIImage+List.h"

@interface PostsDataSource ()

@property (strong, nonatomic) PostsController *postsController;

@end

@implementation PostsDataSource

static NSString * const CoverPostsTableViewCellReuseIdentifier = @"CoverPostsTableViewCellReuseIdentifier";
static NSString * const TextPostsTableViewCellReuseIdentifier = @"TextPostsTableViewCellReuseIdentifier";

static NSString * const CoverEventsPostsTableViewCellReuseIdentifier = @"CoverEventsPostsTableViewCellReuseIdentifier";
static NSString * const TextEventsPostsTableViewCellReuseIdentifier = @"TextEventsPostsTableViewCellReuseIdentifier";

- (id)initWithPostsController:(PostsController *)postsController {
    if (self = [super init]) {
        self.postsController = postsController;
    }
    return self;
}

- (void)registerReuseIdentifiersForTableView:(UITableView *)tableView {
    
    [tableView registerClass:[CoverPostsTableViewCell class]
      forCellReuseIdentifier:CoverPostsTableViewCellReuseIdentifier];
    [tableView registerClass:[TextPostsTableViewCell class]
      forCellReuseIdentifier:TextPostsTableViewCellReuseIdentifier];
    
    [tableView registerClass:[CoverPostsTableViewCell class]
      forCellReuseIdentifier:CoverEventsPostsTableViewCellReuseIdentifier];
    [tableView registerClass:[TextPostsTableViewCell class]
      forCellReuseIdentifier:TextEventsPostsTableViewCellReuseIdentifier];

}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostsController *postsController = self.postsController;
    Post *post = postsController.posts[indexPath.row];
    User *user = post.user;
    Placemark *placemark = post.placemark;
    NSArray *threads = post.threads;
    
    // switch cell by type.
    PostsTableViewCell *cell;
    PostsTableViewCellDetailsView *detailsView;
    
    switch (post.type) {
        case PostTypeEvent: {
            Event *event = post.event;
            if (post.coverPhotoURL) {
                cell = [tableView dequeueReusableCellWithIdentifier:CoverEventsPostsTableViewCellReuseIdentifier];
            } else {
                cell = [tableView dequeueReusableCellWithIdentifier:TextEventsPostsTableViewCellReuseIdentifier];
            }
            PostsTableViewCellEventsView *eventsView = cell.detailsView ? (PostsTableViewCellEventsView *)cell.detailsView : [[PostsTableViewCellEventsView alloc] init];
            eventsView.startTimeLabel.text = [[NSDateFormatter list_defaultDateFormatter] stringFromDate:event.startTime];
            eventsView.placeLabel.text = event.place;
            detailsView = eventsView;
            break;
        }
        case PostTypePost: {
            if (post.coverPhotoURL) {
                cell = [tableView dequeueReusableCellWithIdentifier:CoverPostsTableViewCellReuseIdentifier];
            } else {
                cell = [tableView dequeueReusableCellWithIdentifier:TextPostsTableViewCellReuseIdentifier];
            }
            break;
        }
    }
    
    if (post.coverPhotoURL) {
        [((CoverPostsTableViewCell *)cell).photoView sd_setImageWithURL:post.coverPhotoURL];
    }
    
    cell.detailsView = detailsView;
    cell.headerView.userNameLabel.text = user.displayName;
    cell.headerView.dateLabel.text = [post.createdAtDate timeAgo];
    [cell.headerView.avatarImageView sd_setImageWithURL:user.profilePictureURL];
    
    cell.titleLabel.text = post.title;
    cell.contentLabel.text = post.content;
    cell.headerView.locationLabel.text = placemark.title;
    cell.threadsCounterView.text = [NSString stringWithFormat:@"%lu", (unsigned long)threads.count];
    
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
