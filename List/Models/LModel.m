//
//  LModel.m
//  List
//
//  Created by Noah Portes Chaikin on 8/3/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "LModel.h"

@implementation LModel

+ (instancetype)fromDict:(NSDictionary *)dict {
    LModel *object = [[self alloc] init];
    [object applyDict:dict];
    return object;
}

+ (NSArray *)fromArray:(NSArray *)array {
    NSMutableArray *objects = [NSMutableArray array];
    LModel *object;
    for (NSDictionary *dict in array) {
        object = [self fromDict:dict];
        [objects addObject:object];
    }
    return [NSArray arrayWithArray:objects];
}

- (id)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self applyDict:dict];
    }
    return self;
}

- (void)applyDict:(NSDictionary *)dict {
    return;
}

- (NSDictionary *)toDict {
    return nil;
}

@end
