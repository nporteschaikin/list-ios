//
//  EventEditorViewController.h
//  List
//
//  Created by Noah Portes Chaikin on 8/3/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventEditorViewController : UITableViewController

- (instancetype)initWithEvent:(Event *)event;

@end
