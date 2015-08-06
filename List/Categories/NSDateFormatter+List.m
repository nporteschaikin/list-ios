//
//  NSDateFormatter+List.m
//  List
//
//  Created by Noah Portes Chaikin on 8/5/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "NSDateFormatter+List.h"

@implementation NSDateFormatter (List)

+ (NSDateFormatter *)list_defaultDateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    return dateFormatter;
}

@end
