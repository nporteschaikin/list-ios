//
//  CreatePostViewDelegate.m
//  List
//
//  Created by Noah Portes Chaikin on 8/4/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "CreatePostViewDelegate.h"
#import "ListNavigationController.h"

@implementation CreatePostViewDelegate

#pragma mark - CreatePostViewDelegate

- (void)createPostView:(CreatePostView *)view didTouchDownButton:(CreatePostViewButtons)button {
    
    /*
     * Create post.
     */
    
    Post *post = [[Post alloc] init];
    post.category = self.category;
    switch (button) {
        case CreatePostViewButtonEvent: {
            post.type = PostTypeEvent;
            break;
        }
        default: {
            post.type = PostTypePost;
            break;
        }
    }
    
    /*
     * Push view controller.
     */
    
    PostEditorViewController *viewController = [[PostEditorViewController alloc] initWithPost:post session:self.session];
    ListNavigationController *navigationController = [[ListNavigationController alloc] initWithRootViewController:viewController];
    [self.viewController presentViewController:navigationController animated:YES completion:nil];

}

@end
