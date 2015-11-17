//
//  MainViewController.h
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"
#import "LocationManager.h"
#import "Session.h"

@interface MainViewController : ListUIViewController <SessionDelegate, LocationManagerDelegate>

- (instancetype)initWithSession:(Session *)session;

@end
