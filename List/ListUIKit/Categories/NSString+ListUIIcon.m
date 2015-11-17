//
//  NSString+ListUIIcon.m
//  List
//
//  Created by Noah Portes Chaikin on 8/14/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "NSString+ListUIIcon.h"

@implementation NSString (ListUIIcon)

+ (NSString *)listStringForIcon:(ListUIIcon)icon {
    switch (icon) {
        case ListUIIconLocation: {
            return @"\ue835";
        }
        case ListUIIconPictures: {
            return @"\ue711";
        }
        case ListUIIconEvents: {
            return @"\ue789";
        }
        case ListUIIconUser: {
            return @"\ue71e";
        }
        case ListUIIconMenu: {
            return @"\ue92c";
        }
        case ListUIIconPlus: {
            return @"\ue936";
        }
        case ListUIIconUndo: {
            return @"\ue8e0";
        }
        case ListUIIconRedo: {
            return @"\ue8d9";
        }
        case ListUIIconCross: {
            return @"\ue92a";
        }
        case ListUIIconFlip: {
            return @"\ue705";
        }
        case ListUIIconCheck: {
            return @"\ue934";
        }
        case ListUIIconTag: {
            return @"\ue756";
        }
        case ListUIIconCamera: {
            return @"\ue708";
        }
    }
    return nil;
}

@end
