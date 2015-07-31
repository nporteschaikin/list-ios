//
//  NotificationsViewController.h
//  List
//
//  Created by Noah Portes Chaikin on 7/24/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationsController.h"
#import "NotificationsDataSource.h"
#import "Session.h"

@interface NotificationsViewController : UIViewController

- (instancetype)initWithNotificationsController:(NotificationsController *)notificationsController
                                        session:(Session *)session;

@end
