//
//  CreatePictureCameraView.h
//  List
//
//  Created by Noah Portes Chaikin on 8/18/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"

@class CreatePictureCameraView;

@protocol CreatePictureCameraViewDelegate <NSObject>

- (void)createPictureCameraView:(CreatePictureCameraView *)view flipButtonDidChangeState:(UIControlState)state;
- (void)didTouchDownShutterButtonCreatePictureCameraView:(CreatePictureCameraView *)view;

@end

@interface CreatePictureCameraView : UIView

@property (weak, nonatomic) id<CreatePictureCameraViewDelegate> delegate;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;

@end
