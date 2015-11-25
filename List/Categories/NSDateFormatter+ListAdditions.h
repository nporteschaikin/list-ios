//
//  NSDateFormatter+ListAdditions.h
//  List
//
//  Created by Noah Portes Chaikin on 11/24/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (ListAdditions)

+ (NSDateFormatter *)list_longDateFormatter;
+ (NSDateFormatter *)list_ISO8601formatter;

@end
