//
//  ListUICameraController.h
//  List
//
//  Created by Noah Portes Chaikin on 8/17/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

@class ListUICameraController;

@protocol ListUICameraControllerDelegate <NSObject>

- (void)cameraController:(ListUICameraController *)controller didCaptureStillImage:(UIImage *)image;

@end

@interface ListUICameraController : NSObject

@property (weak, nonatomic) id<ListUICameraControllerDelegate> delegate;
@property (nonatomic, readonly) AVCaptureDevicePosition devicePosition;
@property (strong, nonatomic, readonly) AVCaptureSession *session;

- (void)initializeSession;
- (void)toggleDevice;
- (void)captureStillImage;

@end
