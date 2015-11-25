//
//  AppearanceHelper.m
//  List
//
//  Created by Noah Portes Chaikin on 8/15/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "AppearanceHelper.h"
#import "CreatePictureEditorView.h"

@implementation AppearanceHelper

+ (void)customizeAppearance {
    
    /*
     * UINavigationBar
     */
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor listUI_blueColorAlpha:1]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{ NSFontAttributeName:[UIFont listUI_semiboldFontWithSize:15.f], NSForegroundColorAttributeName: [UIColor whiteColor] }];
    
    /*
     * UISearchBar
     */
    
    [[UISearchBar appearance] setTranslucent:YES];
    [[UISearchBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UISearchBar appearance] setBackgroundColor:[UIColor listUI_lightGrayColorAlpha:1.0f]];
    [[UISearchBar appearance] setBarTintColor:[UIColor listUI_lightGrayColorAlpha:1.0f]];
    [[UISearchBar appearance] setScopeBarButtonTitleTextAttributes:@{ NSFontAttributeName:[UIFont listUI_semiboldFontWithSize:15.f], NSForegroundColorAttributeName: [UIColor whiteColor] } forState:UIControlStateNormal];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSFontAttributeName: [UIFont listUI_fontWithSize:13.f]}];
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:@{NSFontAttributeName: [UIFont listUI_fontWithSize:13.f], NSForegroundColorAttributeName: [UIColor listUI_blueColorAlpha:1.0f]} forState:UIControlStateNormal];
    
}

@end
