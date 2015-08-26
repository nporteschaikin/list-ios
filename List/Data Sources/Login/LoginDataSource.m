//
//  LoginDataSource.m
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "LoginDataSource.h"

@implementation LoginDataSource

#pragma mark - LoginViewDataSource

- (NSString *)loginView:(LoginView *)loginView textForPageAtIndex:(NSInteger)index {
    switch (index) {
        case 0: {
            return @"List helps you create connections with the people around you.";
        }
        case 1: {
            return @"Share photos, events, and more with everyone in your area.";
        }
        default: {
            return @"Interact with people in your area publicly or privately.";
        }
    }
}

- (NSURL *)loginView:(LoginView *)loginView imageURLForPageAtIndex:(NSInteger)index {
    switch (index) {
        case 0: {
            return [[NSBundle mainBundle] URLForResource:@"loginView1" withExtension:@"jpg"];
        }
        case 1: {
            return [[NSBundle mainBundle] URLForResource:@"loginView2" withExtension:@"jpg"];
        }
        default: {
            return [[NSBundle mainBundle] URLForResource:@"loginView3" withExtension:@"jpg"];
        }
    }
}

- (NSInteger)numberOfPagesInLoginView:(LoginView *)loginView {
    return 3;
}

@end
