//
//  AppearanceHelper.m
//  List
//
//  Created by Noah Portes Chaikin on 7/24/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "AppearanceHelper.h"
#import "UIFont+List.h"
#import "UIColor+List.h"
#import "UIImage+List.h"

@implementation AppearanceHelper

+ (void)customizeAppearance {
    [[UINavigationBar appearance] setBarTintColor:[UIColor list_blueColorAlpha:1]];
    [[UINavigationBar appearance] setBackgroundColor:[UIColor list_blueColorAlpha:1]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage list_imageWithColor:[UIColor list_blueColorAlpha:1]] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                           NSFontAttributeName:[UIFont list_navigationBarTitleFont]}];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                           NSFontAttributeName:[UIFont list_navigationBarTitleFont]}
                                                forState:UIControlStateNormal];
}

@end
