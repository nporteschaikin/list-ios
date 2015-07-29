//
//  NSDate+TimeAgo.m
//  List
//
//  Created by Noah Portes Chaikin on 7/9/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "NSDate+TimeAgo.h"

@implementation NSDate (TimeAgo)

- (NSString *)timeAgo {
    int secondsAgo = abs((int)[self timeIntervalSinceNow]);
    if (secondsAgo < 30) {
        return @"now";
    } else if (secondsAgo < 60) {
        return [NSString stringWithFormat:@"%ds", secondsAgo];
    } else if (secondsAgo < 60 * 60) {
        return [NSString stringWithFormat:@"%dm", secondsAgo / 60];
    } else if (secondsAgo < 60 * 60 * 24) {
        return [NSString stringWithFormat:@"%dh", secondsAgo / 60 / 60];
    } else if (secondsAgo < 60 * 60 * 24 * 7) {
        return [NSString stringWithFormat:@"%dd", secondsAgo / 60 / 60 / 24];
    }
    return [NSString stringWithFormat:@"%dw", secondsAgo / 60 / 60 / 24 / 7];
}

@end
