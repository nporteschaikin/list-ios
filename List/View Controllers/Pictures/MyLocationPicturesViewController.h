//
//  MyLocationPicturesViewController.h
//  List
//
//  Created by Noah Portes Chaikin on 8/14/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PicturesViewController.h"
#import "LocationManager.h"

@interface MyLocationPicturesViewController : PicturesViewController <LocationManagerDelegate>

@property (strong, nonatomic, readonly) LocationManager *locationManager;

@end