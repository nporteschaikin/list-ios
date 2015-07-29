//
//  NSDate+ISO8601.m
//  List
//
//  Created by Noah Portes Chaikin on 7/9/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "NSDate+ISO8601.h"

@implementation NSDate (ISO8601)

+ (NSDate *)dateWithISO8601:(NSString *)ISO8601date {
    NSString *dateString = [ISO8601date substringToIndex:(ISO8601date.length - 5)];
    NSString *dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
    NSDateFormatter *gmtFormatter = [[NSDateFormatter alloc] init];
    gmtFormatter.dateFormat = dateFormat;
    gmtFormatter.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    return [gmtFormatter dateFromString:dateString];
}

@end
