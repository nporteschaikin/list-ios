//
//  ThreadDataSource.m
//  List
//
//  Created by Noah Portes Chaikin on 7/28/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ThreadDataSource.h"
#import "NSDate+TimeAgo.h"
#import "UIImageView+WebCache.h"

@interface ThreadDataSource ()

@property (strong, nonatomic) Thread *thread;

@end

@implementation ThreadDataSource

static NSString * const ThreadsTableViewCellReuseIdentifier = @"ThreadsTableViewCellReuseIdentifier";
static NSString * const MessagesTableViewCellReuseIdentifier = @"MessagesTableViewCellReuseIdentifier";

- (id)initWithThread:(Thread *)thread {
    if (self = [super init]) {
        self.thread = thread;
    }
    return self;
}

- (void)registerReuseIdentifiersForTableView:(UITableView *)tableView {
    [tableView registerClass:[ThreadsTableViewCell class]
      forCellReuseIdentifier:ThreadsTableViewCellReuseIdentifier];
    [tableView registerClass:[MessagesTableViewCell class]
      forCellReuseIdentifier:MessagesTableViewCellReuseIdentifier];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    switch (section) {
        case ThreadDataSourceSectionsThread: {
            ThreadsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ThreadsTableViewCellReuseIdentifier];
            Thread *thread = self.thread;
            User *user = thread.user;
            cell.userNameString = user.displayName;
            cell.contentString = thread.content;
            cell.repliesCounterView.hidden = YES;
            cell.dateLabel.text = [thread.createdAtDate timeAgo];
            if (user.profilePictureURL) {
                [cell.avatarImageView sd_setImageWithURL:user.profilePictureURL];
            }
            [cell setNeedsLayout];
            [cell layoutIfNeeded];
            return cell;
        }
        case ThreadDataSourceSectionsMessages: {
            MessagesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MessagesTableViewCellReuseIdentifier];
            Thread *thread = self.thread;
            Message *message = thread.messages[row];
            User *user = message.user;
            cell.userNameString = user.displayName;
            cell.contentString = message.content;
            cell.dateLabel.text = [message.createdAtDate timeAgo];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case ThreadDataSourceSectionsThread: {
            return 1;
        }
        case ThreadDataSourceSectionsMessages: {
            return self.thread.messages.count;
        }
    }
    return 0.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

@end
