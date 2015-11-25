//
//  UIFont+List.m
//  List
//
//  Created by Noah Portes Chaikin on 8/14/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "UIFont+ListUI.h"
#import "ListUIConstants.h"

@implementation UIFont (ListUI)

+ (UIFont *)listUI_fontWithSize:(CGFloat)size {
    return [UIFont fontWithName:kListUIFontName size:size];
}

+ (UIFont *)listUI_semiboldFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:kListUIFontSemiboldName size:size];
}

+ (UIFont *)listUI_boldFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:kListUIFontBoldName size:size];
}

+ (UIFont *)listUI_lightFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:kListUIFontLightName size:size];
}

@end
