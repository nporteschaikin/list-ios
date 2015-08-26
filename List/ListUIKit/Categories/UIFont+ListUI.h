//
//  UIFont+List.h
//  List
//
//  Created by Noah Portes Chaikin on 8/14/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (ListUI)

+ (UIFont *)listFontWithSize:(CGFloat)size;
+ (UIFont *)listSemiboldFontWithSize:(CGFloat)size;
+ (UIFont *)listBoldFontWithSize:(CGFloat)size;
+ (UIFont *)listLightFontWithSize:(CGFloat)size;

@end
