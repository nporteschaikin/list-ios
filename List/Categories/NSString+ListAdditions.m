//
//  NSString+ListAdditions.m
//  List
//
//  Created by Noah Portes Chaikin on 11/25/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "NSString+ListAdditions.h"

@implementation NSString (ListAdditions)

- (NSString *)list_stringForISO8601Formatter {
    return [self substringToIndex:(self.length - 5)];
}

@end
