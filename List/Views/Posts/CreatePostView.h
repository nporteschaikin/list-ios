//
//  CreatePostView.h
//  List
//
//  Created by Noah Portes Chaikin on 8/4/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CreatePostViewButtons) {
    CreatePostViewButtonEvent = 0,
    CreatePostViewButtonText
};

@class CreatePostView;

@protocol CreatePostViewDelegate <NSObject>

@optional
- (void)createPostView:(CreatePostView *)view didTouchDownButton:(CreatePostViewButtons)button;

@end

@interface CreatePostView : UIView

@property (weak, nonatomic) id<CreatePostViewDelegate> delegate;

- (void)displayButtons:(BOOL)display animated:(BOOL)animated completion:(void(^)(void))onComplete;

@end
