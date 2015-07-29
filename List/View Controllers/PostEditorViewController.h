//
//  PostEditorViewController.h
//  List
//
//  Created by Noah Portes Chaikin on 7/7/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostEditorView.h"
#import "Post.h"
#import "Session.h"

@class PostEditorViewController;

@protocol PostEditorViewControllerDelegate <NSObject>

- (void)postEditorViewControllerDidSavePost:(PostEditorViewController *)viewController;
- (void)postEditorViewControllerDidAskToClose:(PostEditorViewController *)viewController;

@end

@interface PostEditorViewController : UIViewController

@property (weak, nonatomic) id<PostEditorViewControllerDelegate> delegate;
@property (strong, nonatomic, readonly) PostEditorView *postEditorView;

- (id)initWithPost:(Post *)post
           session:(Session *)session;

@end
