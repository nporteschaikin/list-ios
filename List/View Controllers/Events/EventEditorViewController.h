//
//  EventEditorViewController.h
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"
#import "Event.h"
#import "Session.h"

@interface EventEditorViewController : ListUIViewController <UITableViewDelegate>

@property (strong, nonatomic, readonly) UITableView *tableView;

- (instancetype)initWithEvent:(Event *)event session:(Session *)session;

@end
