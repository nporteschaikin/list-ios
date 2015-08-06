//
//  PostDataSource.h
//  List
//
//  Created by Noah Portes Chaikin on 7/16/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"
#import "Thread.h"
#import "PostController.h"
#import "ListCoverPhotoCell.h"
#import "PostViewHeaderCell.h"
#import "PostViewContentCell.h"
#import "ListIconTableViewCell.h"
#import "ThreadsTableViewCell.h"

typedef NS_ENUM(NSUInteger, PostDataSourceSection) {
    PostDataSourceSectionDetails = 0,
    PostDataSourceSectionContent,
    PostDataSourceSectionThreads
};

typedef NS_ENUM(NSUInteger, PostDataSourceRow) {
    PostDataSourceRowCoverPhoto = 0,
    PostDataSourceRowHeader,
    
    PostDataSourceRowEventTime = 2,
    PostDataSourceRowEventPlace,
    PostDataSourceRowEventContent,
    PostDataSourceRowEventLocation
};

@interface PostDataSource : NSObject <UITableViewDataSource>

@property (strong, nonatomic, readonly) PostController *postController;

- (instancetype)initWithPostController:(PostController *)postController NS_DESIGNATED_INITIALIZER;
- (void)registerReuseIdentifiersForTableView:(UITableView *)tableView;

@end
