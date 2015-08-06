//
//  PostsTableViewDelegate.h
//  List
//
//  Created by Noah Portes Chaikin on 8/4/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoverPostsTableViewCell.h"
#import "PostsTableViewCellEventsView.h"
#import "PostsController.h"
#import "Session.h"

@interface PostsTableViewDelegate : NSObject <UITableViewDelegate, ListTableViewCellDelegate>

@property (strong, nonatomic) UIViewController *viewController;
@property (strong, nonatomic) Session *session;

- (instancetype)initWithPostsController:(PostsController *)postsController NS_DESIGNATED_INITIALIZER;

@end
