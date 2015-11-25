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
    
}

@end
