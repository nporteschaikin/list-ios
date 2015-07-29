//
//  PostsDataSource.h
//  List
//
//  Created by Noah Portes Chaikin on 7/1/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIRequest.h"
#import "PostsController.h"
#import "PostsTableViewCell.h"

@interface PostsDataSource : NSObject <UITableViewDataSource>

@property (strong, nonatomic, readonly) PostsController *postsController;

- (id)initWithPostsController:(PostsController *)postsController NS_DESIGNATED_INITIALIZER;
- (void)registerReuseIdentifiersForTableView:(UITableView *)tableView;

@end
