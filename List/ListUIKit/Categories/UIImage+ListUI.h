//
//  listImageWithColorUI.h
//  List
//
//  Created by Noah Portes Chaikin on 8/14/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+ListUIIcon.h"

@interface UIImage (ListUI)

+ (UIImage *)listLogoImageSize:(CGFloat)size;
+ (UIImage *)listIcon:(ListUIIcon)icon size:(CGFloat)size;
+ (UIImage *)listIcon:(ListUIIcon)icon size:(CGFloat)size color:(UIColor *)color;

@end
