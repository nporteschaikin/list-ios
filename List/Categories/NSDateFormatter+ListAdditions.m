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

@end
