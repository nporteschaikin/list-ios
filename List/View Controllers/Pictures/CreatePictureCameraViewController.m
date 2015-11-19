//
//  CreatePictureCameraViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 8/18/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "CreatePictureCameraViewController.h"
#import "CreatePictureViewController.h"
#import "ListConstants.h"
#import "LocationManager.h"

typedef NS_ENUM(NSUInteger, CreatePictureCameraViewControllerAction) {
    CreatePictureCameraViewControllerActionEdit,
    CreatePictureCameraViewControllerActionCreate
};

@interface CreatePictureCameraViewController () <LocationManagerDelegate>

@property (strong, nonatomic) Picture *picture;
@property (strong, nonatomic) LocationManager *locationManager;
@property (strong, nonatomic) CreatePictureCameraView *createPictureCameraView;
@property (strong, nonatomic) ListUICameraController *cameraController;

@end

@implementation CreatePictureCameraViewController

- (instancetype)initWithPicture:(Picture *)picture {
    if (self = [super init]) {
        self.picture = picture;
        
        /*
         * Create camera controller.
         */
        
        self.cameraController = [[ListUICameraController alloc] init];
        self.cameraController.delegate = self;
        
        /*
         * Create location manager.
         */
        
        self.locationManager = [[LocationManager alloc] init];
        self.locationManager.delegate = self;
        
    }
    return self;
}

- (void)loadView {
    
    /*
     * Create editor camera view.
     */
    
    self.createPictureCameraView = [[CreatePictureCameraView alloc] init];
    self.view = self.createPictureCameraView;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    /*
     * Set edges for extended layout.
     */
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * Set button handlers.
     */
    
    CreatePictureCameraView *view = self.createPictureCameraView;
    CameraShutterButton *shutterButton = view.shutterButton;
    UIButton *flipButton = view.flipButton;
    UIButton *closeButton = view.closeButton;
    [shutterButton addTarget:self action:@selector(handleShutterButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
    [flipButton addTarget:self action:@selector(handleFlipButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
    [closeButton addTarget:self action:@selector(handleCloseButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
    
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
        CreatePictureCameraView *createPictureCameraView = self.createPictureCameraView;
        AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] init];
        previewLayer.session = session;
        createPictureCameraView.previewLayer = previewLayer;
    }
    
    /*
     * Start updating location.
     */
    
    LocationManager *locationManager = self.locationManager;
    [locationManager startUpdatingLocation];
    
}

#pragma mark - View button handlers

- (void)handleShutterButtonTouchDown:(CameraShutterButton *)button {
    
    /*
     * Take photo.
     */
    
    ListUICameraController *cameraController = self.cameraController;
    [cameraController captureStillImage];
    
}

- (void)handleFlipButtonTouchDown:(UIButton *)button {
    
    /*
     * Toggle device.
     * TODO: make better.
     */
    
    ListUICameraController *cameraController = self.cameraController;
    [cameraController toggleDevice];
    
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
     * If we have a location, use it.
     */
    
    LocationManager *locationManager = self.locationManager;
    CLLocation *location = locationManager.location;
    if (locationManager.location) {
        
        /*
         * Create picture.
         */
        
        Picture *picture = self.picture;
        Photo *asset = [[Photo alloc] init];
        asset.image = image;
        picture.asset = asset;
        picture.location = location;
        
        /*
         * If the parent is correct, transition
         * to edit action.
         */
        
        UIViewController *parentViewController = self.parentViewController;
        if ([parentViewController isKindOfClass:[CreatePictureViewController class]]) {
            [((CreatePictureViewController *)parentViewController) transition:CreatePictureViewControllerActionEdit animated:YES];
        }
        
    }
    
}

@end
