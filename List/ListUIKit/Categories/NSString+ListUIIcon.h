//
//  NSString+ListUIIcon.h
//  List
//
//  Created by Noah Portes Chaikin on 8/14/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ListUIIcon) {
    ListUIIconLocation,
    ListUIIconPictures,
    ListUIIconEvents,
    ListUIIconUser,
    ListUIIconMenu,
    ListUIIconPlus,
    ListUIIconUndo,
    ListUIIconRedo,
    ListUIIconCross,
    ListUIIconFlip,
    ListUIIconCheck,
    ListUIIconTag,
    ListUIIconCamera,
    ListUIIconReturn
};

@interface NSString (ListUIIcon)

+ (NSString *)listStringForIcon:(ListUIIcon)icon;

@end
