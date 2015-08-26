//
//  ListModel.h
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListModel : NSObject

+ (id)fromJSONDict:(NSDictionary *)dict;
+ (NSArray *)fromJSONArray:(NSArray *)array;
- (id)initWithJSONDict:(NSDictionary *)dict;
- (void)applyJSONDict:(NSDictionary *)dict;
- (id<NSCopying>)toJSON;

@end
