//
//  PostCategory.m
//  List
//
//  Created by Noah Portes Chaikin on 7/3/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PostCategory.h"

@interface PostCategory ()

@property (copy, nonatomic) NSString *categoryID;

@end

@implementation PostCategory

- (void)applyDict:(NSDictionary *)dict {
    if (dict[@"_id"]) {
        self.categoryID = dict[@"_id"];
    }
    if (dict[@"name"]) {
        self.name = dict[@"name"];
    }
}

- (NSDictionary *)toDict {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (self.name) {
        dict[@"name"] = self.name;
    }
    return [NSDictionary dictionaryWithDictionary:dict];
}

- (BOOL)isEqual:(PostCategory *)category {
    return [category.categoryID isEqualToString:self.categoryID];
}

@end
