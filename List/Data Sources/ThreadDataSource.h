//
//  ThreadDataSource.h
//  List
//
//  Created by Noah Portes Chaikin on 7/28/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Thread.h"
#import "ThreadsTableViewCell.h"
#import "MessagesTableViewCell.h"

typedef NS_ENUM(NSUInteger, ThreadDataSourceSections) {
    ThreadDataSourceSectionsThread = 0,
    ThreadDataSourceSectionsMessages
};

@interface ThreadDataSource : NSObject <UITableViewDataSource>

- (id)initWithThread:(Thread *)thread NS_DESIGNATED_INITIALIZER;
- (void)registerReuseIdentifiersForTableView:(UITableView *)tableView;

@end
