//
//  EventsViewController.h
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"
#import "Session.h"

@interface EventsViewController : ListUIViewController

- (instancetype)initWithSession:(Session *)session NS_DESIGNATED_INITIALIZER;

@end