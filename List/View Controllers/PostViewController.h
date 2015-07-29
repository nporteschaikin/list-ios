//
//  PostViewController.h
//  List
//
//  Created by Noah Portes Chaikin on 7/16/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "Session.h"

@interface PostViewController : UIViewController

- (id)initWithPost:(Post *)request
           session:(Session *)session NS_DESIGNATED_INITIALIZER;

@end
