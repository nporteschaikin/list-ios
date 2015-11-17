//
//  MyLocationPicturesViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 8/14/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "MyLocationPicturesViewController.h"
#import "CreatePictureButton.h"
#import "CreatePictureViewController.h"
#import "ListConstants.h"

@interface MyLocationPicturesViewController ()

@property (strong, nonatomic) LocationManager *locationManager;
@property (strong, nonatomic) CreatePictureButton *createPictureButton;

@end

@implementation MyLocationPicturesViewController

static CGFloat const kCreatePictureButtonIconWidth = 60.0f;

- (instancetype)initWithSession:(Session *)session {
    if (self = [super initWithSession:session]) {
        
        /*
         * Create location manager.
         */
        
        self.locationManager = [[LocationManager alloc] init];
        self.locationManager.delegate = self;
        
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    /*
     * Add create picture button.
     */
    
    self.createPictureButton = [[CreatePictureButton alloc] init];
    self.createPictureButton.iconColor = [UIColor colorWithWhite:1.0f alpha:0.95f];
    self.createPictureButton.iconWidth = kCreatePictureButtonIconWidth;
    self.createPictureButton.layer.shadowColor = [UIColor listBlackColorAlpha:1.0f].CGColor;
    self.createPictureButton.layer.shadowOffset = CGSizeMake(0.0f, 3.0f);
    self.createPictureButton.layer.shadowOpacity = 0.25f;
    self.createPictureButton.layer.shadowRadius = 3.0f;
    [self.createPictureButton addTarget:self action:@selector(handleCreatePictureButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.createPictureButton];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    /*
     * Create map circle.
     */
    
    LocationManager *locationManager = self.locationManager;
    CLLocation *location = locationManager.location;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    CGFloat radius = [[userDefaults objectForKey:kDiscoveryRadiusInMilesUserDefaultsKey] floatValue];
    MapCircle *mapCircle = [[MapCircle alloc] init];
    mapCircle.location = location;
    mapCircle.radius = radius;
    
    /*
     * Set map circle to latest we've got.
     */
    
    PicturesController *picturesController = self.picturesController;
    picturesController.mapCircle = mapCircle;
    
    /*
     * `super`!!!
     */
    
    [super viewWillAppear:animated];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat x, y, w, h;
    CGSize size;
    
    /*
     * Layout create picture button.
     */
    
    size = [self.createPictureButton sizeThatFits:CGSizeZero];
    x = (CGRectGetWidth(self.view.bounds) - (size.width)) / 2;
    y = CGRectGetHeight(self.view.bounds) - (size.height + 12.f);
    w = size.width;
    h = size.height;
    self.createPictureButton.frame = CGRectMake(x, y, w, h);
    
}

#pragma mark - LocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    /*
     * Get location.
     */
    
    CLLocation *location = locations[0];
    
    /*
     * Create map circle.
     */
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    CGFloat radius = [[userDefaults objectForKey:kDiscoveryRadiusInMilesUserDefaultsKey] floatValue];
    MapCircle *mapCircle = [[MapCircle alloc] init];
    mapCircle.location = location;
    mapCircle.radius = radius;
    
    /*
     * Set map circle to latest we've got.
     */
    
    PicturesController *picturesController = self.picturesController;
    picturesController.mapCircle = mapCircle;
    
    /*
     * Reload.
     */
    
    [picturesController requestPictures];
    
}

#pragma mark - Button handler

- (void)handleCreatePictureButtonTouchDown:(CreatePictureButton *)button {
    
    /*
     * Create picture view controller.
     */
    
    Picture *picture = [[Picture alloc] init];
    Session *session = self.session;
    CreatePictureViewController *viewController = [[CreatePictureViewController alloc] initWithPicture:picture session:session];
    
    /*
     * Present.
     */
    
    [self presentViewController:viewController animated:YES completion:nil];
    
}

@end