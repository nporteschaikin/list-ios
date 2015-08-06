//
//  PostsTableViewController.h
//  List
//
//  Created by Noah Portes Chaikin on 7/1/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostsController.h"
#import "PostsDataSource.h"
#import "Session.h"

@interface PostsTableViewController : UITableViewController

@property (strong, nonatomic, readonly) PostsController *postsController;

- (id)initWithPostsController:(PostsController *)postsController
                      session:(Session *)session;

@end