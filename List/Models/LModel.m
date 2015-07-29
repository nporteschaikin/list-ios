//
//  LModel.m
//  List
//
//  Created by Noah Portes Chaikin on 7/6/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "LModel.h"

@implementation LModel

+ (instancetype)fromJSONDict:(NSDictionary *)JSON {
    LModel *model = [[self alloc] init];
    if ([model respondsToSelector:@selector(applyJSON:)]) {
        [model applyJSON:(NSDictionary *)JSON];
    }
    return model;
}

+ (NSArray *)fromJSONArray:(NSArray *)JSON {
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *data in (NSArray *)JSON) {
        [array addObject:[self fromJSONDict:data]];
    }
    return array;
}

- (NSDictionary *)toJSON {
    if ([self respondsToSelector:@selector(propertiesJSON)]) {
        return [self propertiesJSON];
    }
    return @{};
}

- (BOOL)isEqual:(LModel *)object {
    if ([self equalityProperty]) {
        return [[self equalityProperty] isEqual:[object equalityProperty]] && [self isKindOfClass:[object class]];
    }
    return NO;
}

@end
