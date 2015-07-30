//
//  PostsController.m
//  List
//
//  Created by Noah Portes Chaikin on 7/23/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PostsController.h"
#import "APIRequest.h"
#import "Constants.h"

@interface PostsController ()

@property (strong, nonatomic) Session *session;
@property (copy, nonatomic) NSArray *posts;

@end

@implementation PostsController

- (id)initWithSession:(Session *)session {
    if (self = [super init]) {
        self.session = session;
    }
    return self;
}

- (void)requestPosts {
    APIRequest *request = [[APIRequest alloc] init];
    request.method = APIRequestMethodGET;
    request.endpoint = APIPostsEndpoint;
    request.session = self.session;
    
    /*
     * Build query.
     */
    
    NSMutableDictionary *query = [NSMutableDictionary dictionary];
    
    if (self.category) {
        query[@"category"] = self.category.categoryID;
    }
    
    if (self.user) {
        query[@"user"] = self.user.userID;
    }
    
    if (self.location) {
        query[@"latitude"] = [[NSNumber numberWithDouble:self.location.coordinate.latitude] stringValue];
        query[@"longitude"] = [[NSNumber numberWithDouble:self.location.coordinate.longitude] stringValue];
    }
    
    if (self.radius) {
        query[@"radius"] = [NSString stringWithFormat:@"%f", self.radius];
    }
    
    if (self.query) {
        query[@"search"] = self.query;
    }
    
    request.query = query;
    
    /*
     * Send request.
     */
    
    if ([self.delegate respondsToSelector:@selector(postsControllerDidRequestPosts:)]) {
        [self.delegate postsControllerDidRequestPosts:self];
    }
    
    [request sendRequest:^(id<NSObject> body) {
        
        /*
         * Update post.
         */
        
        self.posts = [Post fromJSONArray:(NSArray *)body];
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(postsControllerDidFetchPosts:)]) {
            [self.delegate postsControllerDidFetchPosts:self];
        }
        
    } onError:^(NSError *error) {
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(postsController:failedToFetchPostsWithError:)]) {
            [self.delegate postsController:self failedToFetchPostsWithError:error];
        }
        
    } onFail:^(id<NSObject> body) {
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(postsController:failedToFetchPostsWithError:)]) {
            [self.delegate postsController:self failedToFetchPostsWithResponse:body];
        }
        
    }];
}

@end
