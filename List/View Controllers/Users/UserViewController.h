//
//  UserViewController.h
//  List
//
//  Created by Noah Portes Chaikin on 8/14/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"
#import "Session.h"

@interface UserViewController : ListUIViewController

- (instancetype)initWithUser:(User *)user
                     session:(Session *)session NS_DESIGNATED_INITIALIZER;

@end
