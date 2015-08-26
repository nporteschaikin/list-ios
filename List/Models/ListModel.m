//
//  ListModel.m
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListModel.h"

@implementation ListModel

+ (instancetype)fromJSONDict:(NSDictionary *)dict {
    ListModel *object = [[self alloc] init];
    [object applyJSONDict:dict];
    return object;
}

+ (NSArray *)fromJSONArray:(NSArray *)array {
    NSMutableArray *objects = [NSMutableArray array];
    ListModel *object;
    for (NSDictionary *dict in array) {
        object = [self fromJSONDict:dict];
        [objects addObject:object];
    }
    return [NSArray arrayWithArray:objects];
}

- (id)initWithJSONDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self applyJSONDict:dict];
    }
    return self;
}

- (void)applyJSONDict:(NSDictionary *)dict {
    return;
}

- (id<NSCopying>)toJSON {
    return nil;
}

@end
