//
//  IonIcons+LIcon.m
//  List
//
//  Created by Noah Portes Chaikin on 8/5/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "IonIcons+LIcon.h"

@implementation IonIcons (LIcon)

+ (NSString *)list_stringForIcon:(LIcon)icon {
    switch (icon) {
        case LIconThread: {
            return ion_ios_chatbubble;
        }
        case LIconLocation: {
            return ion_ios_paperplane;
        }
        case LIconReply: {
            return ion_ios_redo;
        }
        case LIconSearch: {
            return ion_ios_search_strong;
        }
        case LIconMenu: {
            return ion_ios_list;
        }
        case LIconPeople: {
            return ion_ios_people;
        }
        case LIconPerson: {
            return ion_ios_person;
        }
        case LIconCamera: {
            return ion_ios_camera;
        }
        case LIconEvent: {
            return ion_ios_calendar;
        }
        case LIconPlace: {
            return ion_ios_location;
        }
    }
    return nil;
}

@end
