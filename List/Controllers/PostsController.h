//
//  PostsController.h
//  List
//
//  Created by Noah Portes Chaikin on 7/23/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Post.h"
#import "User.h"
#import "PostCategory.h"
#import "Session.h"

@class PostsController;

@protocol PostsControllerDelegate <NSObject>

@optional
- (void)postsControllerDidFetchPosts:(PostsController *)postController;
- (void)postsController:(PostsController *)postController failedToFetchPostsWithError:(NSError *)error;
- (void)postsController:(PostsController *)postController failedToFetchPostsWithResponse:(id<NSObject>)response;

@end;

@interface PostsController : NSObject

@property (weak, nonatomic) id<PostsControllerDelegate> delegate;
@property (copy, nonatomic, readonly) NSArray *posts;
@property (strong, nonatomic, readonly) Session *session;
@property (strong, nonatomic) PostCategory *category;
@property (strong, nonatomic) CLLocation *location;
@property (nonatomic) float radius;
@property (strong, nonatomic) User *user;
@property (copy, nonatomic) NSString *query;

- (id)initWithSession:(Session *)session NS_DESIGNATED_INITIALIZER;
- (void)requestPosts;

@end
