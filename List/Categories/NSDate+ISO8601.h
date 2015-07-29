//
//  NSDate+ISO8601.h
//  List
//
//  Created by Noah Portes Chaikin on 7/9/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ISO8601)

+ (NSDate *)dateWithISO8601:(NSString *)ISO8601date;

@end
