//
//  UserViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 8/14/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "UserViewController.h"

@interface UserViewController ()

@property (strong, nonatomic) Session *session;

@end

@implementation UserViewController

- (instancetype)initWithUser:(User *)user session:(Session *)session {
    if (self = [super init]) {
        self.session = session;
    }
    return self;
}

@end
