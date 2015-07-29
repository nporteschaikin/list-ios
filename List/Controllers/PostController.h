//
//  PostController.h
//  List
//
//  Created by Noah Portes Chaikin on 7/23/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"
#import "Thread.h"
#import "Session.h"

@class PostController;

@protocol PostControllerDelegate <NSObject>

@optional

- (void)postControllerDidFetchPost:(PostController *)postController;
- (void)postController:(PostController *)postController failedToFetchPostWithError:(NSError *)error;
- (void)postController:(PostController *)postController failedToFetchPostWithResponse:(id<NSObject>)response;
- (void)postControllerDidSavePost:(PostController *)postController;
- (void)postController:(PostController *)postController failedToSavePostWithError:(NSError *)error;
- (void)postController:(PostController *)postController failedToSavePostWithResponse:(id<NSObject>)response;
- (void)postController:(PostController *)postController didAddThread:(Thread *)thread toPostAtIndex:(NSInteger)index;
- (void)postController:(PostController *)postController failedToAddThread:(Thread *)thread toPostWithError:(NSError *)error;
- (void)postController:(PostController *)postController failedToAddThread:(Thread *)thread toPostWithResponse:(id<NSObject>)response;
- (void)postController:(PostController *)postController didAddMessage:(Message *)message toThread:(Thread *)thread atIndex:(NSInteger)index;
- (void)postController:(PostController *)postController failedToAddMessage:(Message *)message toThread:(Thread *)thread withError:(NSError *)error;
- (void)postController:(PostController *)postController failedToAddMessage:(Message *)message toThread:(Thread *)thread withResponse:(id<NSObject>)response;

@end

@interface PostController : NSObject

@property (weak, nonatomic) id<PostControllerDelegate> delegate;
@property (strong, nonatomic, readonly) Post *post;
@property (strong, nonatomic, readonly) Session *session;

- (id)initWithPost:(Post *)post
           session:(Session *)session NS_DESIGNATED_INITIALIZER;
- (void)requestPost;
- (void)savePost;
- (void)addThreadToPost:(Thread *)thread;
- (void)addMessage:(Message *)message
          toThread:(Thread *)thread;

@end
