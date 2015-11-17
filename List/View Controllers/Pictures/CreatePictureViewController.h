//
//  CreatePictureViewController.h
//  List
//
//  Created by Noah Portes Chaikin on 8/19/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"
#import "Picture.h"
#import "Session.h"

typedef NS_ENUM(NSUInteger, CreatePictureViewControllerAction) {
    CreatePictureViewControllerActionCamera,
    CreatePictureViewControllerActionEdit
};

@class CreatePictureViewController;

@protocol CreatePictureViewControllerDelegate <NSObject>

@optional
- (id<UIViewControllerAnimatedTransitioning>)createPictureViewController:(CreatePictureViewController *)controller animationControllerForTransitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController;

@end

@interface CreatePictureViewController : ListUIViewController

@property (weak, nonatomic) id<CreatePictureViewControllerDelegate> delegate;
- (instancetype)initWithPicture:(Picture *)picture session:(Session *)session;
- (void)transition:(CreatePictureViewControllerAction)action animated:(BOOL)animated;

@end
