//
//  ListUICameraView.h
//  List
//
//  Created by Noah Portes Chaikin on 8/18/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "ListUICameraShutterButton.h"

@interface ListUICameraView : UIView

@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;
@property (strong, nonatomic, readonly) ListUICameraShutterButton *shutterButton;
@property (strong, nonatomic, readonly) UIButton *flipButton;

@end
