//
//  CreatePictureCameraViewController.h
//  List
//
//  Created by Noah Portes Chaikin on 8/18/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"
#import "Picture.h"
#import "Session.h"

@interface CreatePictureCameraViewController : ListUICameraViewController

@property (strong, nonatomic, readonly) LocationManager *locationManager;

- (instancetype)initWithPicture:(Picture *)picture;

@end
