//
//  CreatePictureCameraView.h
//  List
//
//  Created by Noah Portes Chaikin on 8/18/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"
#import "CameraShutterButton.h"

@interface CreatePictureCameraView : UIView

@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;
@property (strong, nonatomic, readonly) CameraShutterButton *shutterButton;
@property (strong, nonatomic, readonly) UIButton *flipButton;
@property (strong, nonatomic, readonly) UIButton *closeButton;

@end
