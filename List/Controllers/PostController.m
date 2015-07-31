//
//  PostController.m
//  List
//
//  Created by Noah Portes Chaikin on 7/23/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PostController.h"
#import "Post.h"
#import "Thread.h"
#import "APIRequest.h"
#import "Constants.h"

@interface PostController ()

@property (strong, nonatomic) Post *post;
@property (strong, nonatomic) Session *session;

@end

@implementation PostController

- (id)initWithPost:(Post *)post
           session:(Session *)session {
    if (self = [super init]) {
        self.post = post;
        self.session = session;
    }
    return self;
}

- (void)requestPost {
    APIRequest *request = [[APIRequest alloc] init];
    request.method = APIRequestMethodGET;
    request.endpoint = [NSString stringWithFormat:APIPostEndpoint, self.post.postID];
    request.session = self.session;
    [request sendRequest:^(id<NSObject> body) {
        
        /*
         * Update post.
         */
        
        [self.post applyJSON:(NSDictionary *)body];
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(postControllerDidFetchPost:)]) {
            [self.delegate postControllerDidFetchPost:self];
        }
        
    } onError:^(NSError *error) {
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(postController:failedToFetchPostWithError:)]) {
            [self.delegate postController:self failedToFetchPostWithError:error];
        }
        
    } onFail:^(id<NSObject> body) {
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(postController:failedToFetchPostWithError:)]) {
            [self.delegate postController:self failedToFetchPostWithResponse:body];
        }
        
    }];
}

- (void)savePost {
    APIRequest *request = [[APIRequest alloc] init];
    request.method = self.post.postID ? APIRequestMethodPUT : APIRequestMethodPOST;
    request.endpoint = self.post.postID ? [NSString stringWithFormat:APIPostEndpoint, self.post.postID] : APIPostsEndpoint;
    request.session = self.session;
    request.body = [self.post toJSON];
    [request sendRequest:^(id<NSObject> body) {
        
        /*
         * Update post.
         */
        
        [self.post applyJSON:(NSDictionary *)body];
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(postControllerDidSavePost:)]) {
            [self.delegate postControllerDidSavePost:self];
        }
        
    } onError:^(NSError *error) {
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(postController:failedToSavePostWithError:)]) {
            [self.delegate postController:self failedToSavePostWithError:error];
        }
        
    } onFail:^(id<NSObject> body) {
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(postController:failedToSavePostWithError:)]) {
            [self.delegate postController:self failedToSavePostWithResponse:body];
        }
        
    }];
}

- (void)addThreadToPost:(Thread *)thread {
    APIRequest *request = [[APIRequest alloc] init];
    request.method = APIRequestMethodPOST;
    request.endpoint = [NSString stringWithFormat:APIPostThreadsEndpoint, self.post.postID];
    request.session = self.session;
    request.body = [thread toJSON];\
    [request sendRequest:^(id<NSObject> body) {
        
        /*
         * Update post.
         */
        
        Thread *thread = [Thread fromJSONDict:(NSDictionary *)body];
        NSMutableArray *threads = [NSMutableArray arrayWithArray:self.post.threads];
        [threads addObject:thread];
        self.post.threads = [NSArray arrayWithArray:threads];
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(postController:didAddThread:toPostAtIndex:)] && self.post.threads.count) {
            NSInteger index = self.post.threads.count - 1;
            [self.delegate postController:self
                             didAddThread:thread
                            toPostAtIndex:index];
        }
        
    } onError:^(NSError *error) {
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(postController:failedToAddThread:toPostWithError:)]) {
            [self.delegate postController:self failedToAddThread:thread toPostWithError:error];
        }
        
    } onFail:^(id<NSObject> body) {
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(postController:failedToAddThread:toPostWithResponse:)]) {
            [self.delegate postController:self failedToAddThread:thread toPostWithResponse:body];
        }
        
    }];
}

- (void)addMessage:(Message *)message toThread:(Thread *)thread {
    APIRequest *request = [[APIRequest alloc] init];
    request.method = APIRequestMethodPOST;
    request.endpoint = [NSString stringWithFormat:APIPostThreadMessagesEndpoint, self.post.postID, thread.threadID];
    request.session = self.session;
    request.body = [message toJSON];
    [request sendRequest:^(id<NSObject> body) {
        
        /*
         * Update thread.
         */
        
        Message *message = [Message fromJSONDict:(NSDictionary *)body];
        NSMutableArray *messages = [NSMutableArray arrayWithArray:thread.messages];
        [messages addObject:message];
        thread.messages = [NSArray arrayWithArray:messages];
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(postController:didAddMessage:toThread:atIndex:)] && thread.messages.count) {
            NSInteger index = thread.messages.count - 1;
            [self.delegate postController:self
                             didAddMessage:message
                                 toThread:thread
                                  atIndex:index];
        }
        
    } onError:^(NSError *error) {
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(postController:failedToAddMessage:toThread:withError:)]) {
            [self.delegate postController:self failedToAddMessage:message toThread:thread withError:error];
        }
        
    } onFail:^(id<NSObject> body) {
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(postController:failedToAddMessage:toThread:withResponse:)]) {
            [self.delegate postController:self failedToAddMessage:message toThread:thread withResponse:body];
        }
        
    }];
}

- (void)deletePost {
    APIRequest *request = [[APIRequest alloc] init];
    request.method = APIRequestMethodDELETE;
    request.endpoint = [NSString stringWithFormat:APIPostEndpoint, self.post.postID];
    request.session = self.session;
    [request sendRequest:^(id<NSObject> body) {
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(postControllerDidDeletePost:)]) {
            [self.delegate postControllerDidDeletePost:self];
        }
        
    } onError:^(NSError *error) {
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(postController:failedToDeletePostWithError:)]) {
            [self.delegate postController:self failedToDeletePostWithError:error];
        }
        
    } onFail:^(id<NSObject> body) {
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(postController:failedToDeletePostWithError:)]) {
            [self.delegate postController:self failedToDeletePostWithResponse:body];
        }
        
    }];
}

@end
