//
//  MapCircle.h
//  List
//
//  Created by Noah Portes Chaikin on 8/15/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface MapCircle : NSObject

@property (strong, nonatomic) CLLocation *location;
@property (nonatomic) float radius;

@end
