//
//  Picture.h
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "LocationManager.h"
#import "ListModel.h"
#import "Photo.h"
#import "User.h"
#import "Placemark.h"

@interface Picture : ListModel

@property (copy, nonatomic, readonly) NSString *pictureID;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) Photo *asset;
@property (strong, nonatomic) Placemark *placemark;
@property (strong, nonatomic) CLLocation *location;
@property (copy, nonatomic) NSString *text;

@end
