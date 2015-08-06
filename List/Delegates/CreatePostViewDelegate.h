//
//  CreatePostViewDelegate.h
//  List
//
//  Created by Noah Portes Chaikin on 8/4/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreatePostView.h"
#import "PostEditorViewController.h"
#import "Post.h"
#import "Session.h"

@interface CreatePostViewDelegate : NSObject <CreatePostViewDelegate>

@property (strong, nonatomic) UIViewController *viewController;
@property (strong, nonatomic) PostCategory *category;
@property (strong, nonatomic) Session *session;

@end
