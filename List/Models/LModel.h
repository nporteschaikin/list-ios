//
//  LModel.h
//  List
//
//  Created by Noah Portes Chaikin on 8/3/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+ISO8601.h"
#import "NSDateFormatter+ISO8601.h"

@interface LModel : NSObject

+ (id)fromDict:(NSDictionary *)dict;
+ (NSArray *)fromArray:(NSArray *)array;
- (id)initWithDict:(NSDictionary *)dict;
- (void)applyDict:(NSDictionary *)dict;
- (NSDictionary *)toDict;

@end
