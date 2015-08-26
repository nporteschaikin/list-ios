//
//  EventsViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "EventsViewController.h"
#import "ListConstants.h"

@interface EventsViewController ()

@property (strong, nonatomic) Session *session;

@end

@implementation EventsViewController

- (instancetype)initWithSession:(Session *)session {
    if (self = [super init]) {
        self.session = session;
    }
    return self;
}

- (void)viewDidLoad {
    
    /*
     * Set location bar item.
     */
    
    self.locationBarItem.image = [UIImage listIcon:ListUIIconEvents size:kListUILocationBarDefaultImageSize];
    self.locationBarItem.barTintColor = [UIColor listBlueColorAlpha:1];
    self.locationBarItem.tintColor = [UIColor whiteColor];
    
}

@end
