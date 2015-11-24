//
//  ListUICameraViewController.h
//  List
//
//  Created by Noah Portes Chaikin on 11/19/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIViewController.h"
#import "ListUICameraController.h"
#import "ListUICameraView.h"

@class ListUICameraViewController;

@protocol ListUICameraViewControllerDelegate <NSObject>

@optional;
- (void)cameraViewController:(ListUICameraViewController *)controller didCaptureStillImage:(UIImage *)image;

@end

@interface ListUICameraViewController : ListUIViewController

@property (weak, nonatomic) id<ListUICameraViewControllerDelegate> delegate;
@property (strong, nonatomic, readonly) ListUICameraView *cameraView;

@end
