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
    
    [[UIBarButtonItem appearanceWhenContainedIn:[CreatePictureEditorView class], nil] setTitleTextAttributes:@{ NSFontAttributeName:[UIFont listSemiboldFontWithSize:15.f] } forState:UIControlStateNormal];
    
    /*
     * UINavigationBar
     */
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor listBlackColorAlpha:1]];
    [[UINavigationBar appearance] setTintColor:[UIColor listBlueColorAlpha:1]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{ NSFontAttributeName:[UIFont listFontWithSize:11.f] }];
    
}

@end
