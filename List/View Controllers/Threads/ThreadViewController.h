//
//  ThreadViewController.h
//  List
//
//  Created by Noah Portes Chaikin on 7/28/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Thread.h"
#import "Post.h"
#import "Session.h"

@interface ThreadViewController : UIViewController

- (instancetype)initWithThread:(Thread *)thread
                        inPost:(Post *)post
                       session:(Session *)session NS_DESIGNATED_INITIALIZER;

@end
