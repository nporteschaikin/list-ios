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

@end

@implementation CreatePictureCameraViewController

- (instancetype)initWithPicture:(Picture *)picture {
    if (self = [super init]) {
        self.picture = picture;
        
        /*
         * Create location manager.
         */
        
        self.locationManager = [[LocationManager alloc] init];
        self.locationManager.delegate = self;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * Start updating location.
     */
    
    LocationManager *locationManager = self.locationManager;
    [locationManager startUpdatingLocation];
    
}

@end
