//
//  MenuViewController.h
//  List
//
//  Created by Noah Portes Chaikin on 7/21/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Session.h"
#import "LIconControl.h"

@interface MenuViewController : UIViewController

@property (strong, nonatomic, readonly) LIconControl *closeControl;

- (instancetype)initWithSession:(Session *)session NS_DESIGNATED_INITIALIZER;

@end
