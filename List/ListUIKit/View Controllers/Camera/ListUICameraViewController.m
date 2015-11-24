//
//  CreatePictureCameraViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 8/18/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUICameraViewController.h"
#import "ListUIConstants.h"

@interface ListUICameraViewController () <ListUICameraControllerDelegate>

@property (strong, nonatomic) ListUICameraView *cameraView;
@property (strong, nonatomic) ListUICameraController *cameraController;

@end

@implementation ListUICameraViewController

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Create camera controller.
         */
        
        self.cameraController = [[ListUICameraController alloc] init];
        self.cameraController.delegate = self;
        
        /*
         * Set defaults.
         */
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
    }
    return self;
}

- (void)loadView {
    
    /*
     * Create camera view
     */
    
    self.cameraView = [[ListUICameraView alloc] init];
    self.view = self.cameraView;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    /*
     * Set edges for extended layout.
     */
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * Set button handlers.
     */
    
    ListUICameraView *view = self.cameraView;
    ListUICameraShutterButton *shutterButton = view.shutterButton;
    UIButton *flipButton = view.flipButton;
    [shutterButton addTarget:self action:@selector(handleShutterButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
    [flipButton addTarget:self action:@selector(handleFlipButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
    
    /*
     * Start session.
     */
    
    ListUICameraController *cameraController = self.cameraController;
    [cameraController initializeSession];
    
    /*
     * If session started, create preview layer for view.
     */
    
    if (cameraController.session) {
        AVCaptureSession *session = cameraController.session;
        AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] init];
        previewLayer.session = session;
        view.previewLayer = previewLayer;
    }
    
}

#pragma mark - View button handlers

- (void)handleFlipButtonTouchDown:(UIButton *)button {
    
    /*
     * Toggle device.
     */
    
    ListUICameraController *cameraController = self.cameraController;
    [cameraController toggleDevice];
    
}

- (void)handleShutterButtonTouchDown:(ListUICameraView *)button {
    
    /*
     * Take photo.
     */
    
    ListUICameraController *cameraController = self.cameraController;
    [cameraController captureStillImage];
    
}

- (void)handleCloseButtonTouchDown:(UIButton *)button {
    
    /*
     * Close view.
     */
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - ListUICameraControllerDelegate

- (void)cameraController:(ListUICameraController *)controller didCaptureStillImage:(UIImage *)image {
    
    /*
     * If delegate has method, use it.
     */
    
    if ([self.delegate respondsToSelector:@selector(cameraViewController:didCaptureStillImage:)]) {
        [self.delegate cameraViewController:self didCaptureStillImage:image];
    }
    
}

@end
