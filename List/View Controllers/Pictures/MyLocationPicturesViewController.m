//
//  MyLocationPicturesViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 8/14/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "MyLocationPicturesViewController.h"
#import "LocationManager.h"
#import "CreatePictureViewController.h"
#import "LocationTitleView.h"
#import "ClearNavigationBar.h"
#import "ListConstants.h"

@implementation MyLocationPicturesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * Add button navigation item.
     */
    
    UINavigationItem *navigationItem = self.navigationItem;
    UIImage *buttonImage = [UIImage listUI_icon:ListUIIconFlare size:20.f];
    navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:buttonImage style:UIBarButtonItemStylePlain target:self action:@selector(handleBarButtonItem:)];
    
}

- (void)requestPictures {
    
    /*
     * Create map circle.
     */
    
    LocationManager *locationManager = [[LocationManager alloc] init];
    CLLocation *location = locationManager.location;
    
    if (location) {
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        CGFloat radius = [[userDefaults objectForKey:kUserDefaultsDiscoveryRadiusInMilesKey] floatValue];
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
        
        [super requestPictures];
        
    }
    
}

#pragma mark - PicturesControllerDelegate

- (void)picturesControllerDidFetchPictures:(PicturesController *)picturesController {
    [super picturesControllerDidFetchPictures:picturesController];
    
    /*
     * Create title view.
     */
    
    LocationTitleView *titleView = [[LocationTitleView alloc] init];
    Placemark *placemark = picturesController.placemark;
    titleView.title = placemark.title;
    titleView.image = [UIImage listUI_icon:ListUIIconPictures size:kUINavigationBarDefaultImageSize];
    self.navigationItem.titleView = titleView;
    
}

#pragma mark - Button handler

- (void)handleBarButtonItem:(UIBarButtonItem *)item {
    
    /*
     * Create picture view controller.
     */
    
    Picture *picture = [[Picture alloc] init];
    Session *session = self.session;
    CreatePictureViewController *viewController = [[CreatePictureViewController alloc] initWithPicture:picture session:session];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithNavigationBarClass:[ClearNavigationBar class] toolbarClass:nil];
    navigationController.viewControllers = @[ viewController ];
    
    /*
     * Present.
     */
    
    [self presentViewController:navigationController animated:YES completion:nil];
    
}

@end