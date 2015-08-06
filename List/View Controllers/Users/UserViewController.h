//
//  UserViewController.h
//  List
//
//  Created by Noah Portes Chaikin on 7/21/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Session.h"

@interface UserViewController : UIViewController

- (id)initWithUser:(User *)user
           session:(Session *)session NS_DESIGNATED_INITIALIZER;

@end
