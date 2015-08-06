//
//  NSDateFormatter+ISO8601.m
//  List
//
//  Created by Noah Portes Chaikin on 8/3/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "NSDateFormatter+ISO8601.h"

@implementation NSDateFormatter (ISO8601)

+ (NSDateFormatter *)ISO8601formatter {
    NSString *dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
    NSDateFormatter *gmtFormatter = [[NSDateFormatter alloc] init];
    gmtFormatter.dateFormat = dateFormat;
    gmtFormatter.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    return gmtFormatter;
}

@end
