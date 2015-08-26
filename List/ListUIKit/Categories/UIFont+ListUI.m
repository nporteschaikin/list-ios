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

+ (UIFont *)listFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:kListUIFontName size:size];
}

+ (UIFont *)listSemiboldFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:kListUIFontSemiboldName size:size];
}

+ (UIFont *)listBoldFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:kListUIFontBoldName size:size];
}

+ (UIFont *)listLightFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:kListUIFontLightName size:size];
}

@end
