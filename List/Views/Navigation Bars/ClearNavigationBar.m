//
//  ClearNavigationBar.m
//  List
//
//  Created by Noah Portes Chaikin on 11/23/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ClearNavigationBar.h"

@implementation ClearNavigationBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        /*
         * Remove background and shadow images.
         */
        
        UIImage *image = [[UIImage alloc] init];
        self.shadowImage = image;
        [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        
    }
    return self;
}

@end
