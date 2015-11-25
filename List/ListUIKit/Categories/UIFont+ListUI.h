//
//  UIFont+List.h
//  List
//
//  Created by Noah Portes Chaikin on 8/14/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (ListUI)

+ (UIFont *)listUI_fontWithSize:(CGFloat)size;
+ (UIFont *)listUI_semiboldFontWithSize:(CGFloat)size;
+ (UIFont *)listUI_boldFontWithSize:(CGFloat)size;
+ (UIFont *)listUI_lightFontWithSize:(CGFloat)size;

@end
