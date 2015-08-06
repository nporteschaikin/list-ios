//
//  Event.m
//  List
//
//  Created by Noah Portes Chaikin on 8/3/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "Event.h"
#import "NSDateFormatter+ISO8601.h"

@implementation Event

- (NSDate *)startTime {
    if (!_startTime) {
        
        /*
         * Create date.
         */
        
        NSDate *now = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:(NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitYear|NSCalendarUnitHour|NSCalendarUnitMinute) fromDate:now];
        if (components.minute > 0) {
            components.hour += 1;
        }
        components.minute = 0;
        _startTime = [calendar dateFromComponents:components];

        
    }
    return _startTime;
}

- (void)applyDict:(NSDictionary *)dict {
    NSDateFormatter *dateFormatter = [NSDateFormatter ISO8601formatter];
    if (dict[@"startTime"]) {
        self.startTime = [dateFormatter dateFromString:dict[@"startTime"]];
    }
    if (dict[@"endTime"]) {
        self.endTime = [dateFormatter dateFromString:dict[@"endTime"]];
    }
    if (dict[@"place"]) {
        self.place = dict[@"place"];
    }
}

- (NSDictionary *)toDict {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSDateFormatter *dateFormatter = [NSDateFormatter ISO8601formatter];
    if (self.startTime) {
        dict[@"startTime"] = [dateFormatter stringFromDate:self.startTime];
    }
    if (self.endTime) {
        dict[@"endTime"] = [dateFormatter stringFromDate:self.endTime];
    }
    if (self.place) {
        dict[@"place"] = self.place;
    }
    return [NSDictionary dictionaryWithDictionary:dict];
}

@end
