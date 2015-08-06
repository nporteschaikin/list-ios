//
//  IonIcons+LIcon.h
//  List
//
//  Created by Noah Portes Chaikin on 8/5/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "IonIcons.h"

typedef NS_ENUM(NSUInteger, LIcon) {
    LIconThread,
    LIconLocation,
    LIconReply,
    LIconSearch,
    LIconMenu,
    LIconPeople,
    LIconPerson,
    LIconCamera,
    LIconEvent,
    LIconPlace
};

@interface IonIcons (LIcon)

+ (NSString *)list_stringForIcon:(LIcon)icon;

@end
