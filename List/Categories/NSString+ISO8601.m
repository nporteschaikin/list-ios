//
//  NSString+ISO8601.m
//  List
//
//  Created by Noah Portes Chaikin on 8/3/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "NSString+ISO8601.h"

@implementation NSString (ISO8601)

- (NSString *)ISO8601FormattedString {
    return [self substringToIndex:(self.length - 5)];
}

@end
