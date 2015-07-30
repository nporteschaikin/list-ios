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

@interface PostEditorViewController : UIViewController

@property (strong, nonatomic, readonly) PostEditorView *postEditorView;

- (id)initWithPost:(Post *)post
           session:(Session *)session;

@end
