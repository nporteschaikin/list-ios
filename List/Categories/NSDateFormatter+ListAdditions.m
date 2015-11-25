//
//  NSDateFormatter+ListAdditions.m
//  List
//
//  Created by Noah Portes Chaikin on 11/24/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "NSDateFormatter+ListAdditions.h"

@implementation NSDateFormatter (ListAdditions)

+ (NSDateFormatter *)list_longDateFormatter {
    static NSDateFormatter *list_longDateFormatter;
    if (!list_longDateFormatter) {
        list_longDateFormatter = [[NSDateFormatter alloc] init];
        list_longDateFormatter.dateStyle = NSDateFormatterMediumStyle;
        list_longDateFormatter.timeStyle = NSDateFormatterShortStyle;
    }
    return list_longDateFormatter;
}

+ (NSDateFormatter *)list_ISO8601formatter {
    static NSDateFormatter *list_ISO8601formatter;
    if (!list_ISO8601formatter) {
        list_ISO8601formatter = [[NSDateFormatter alloc] init];
        list_ISO8601formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
        list_ISO8601formatter.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    }
    return list_ISO8601formatter;
}

@end
