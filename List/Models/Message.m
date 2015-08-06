//
//  Message.m
//  List
//
//  Created by Noah Portes Chaikin on 7/28/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "Message.h"

@implementation Message

- (NSDictionary *)toJSONDict {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (self.content) {
        dict[@"content"] = self.content;
    }
    return [NSDictionary dictionaryWithDictionary:dict];
}

- (void)applyDict:(NSDictionary *)dict {
    if ([dict[@"user"] isKindOfClass:[NSDictionary class]]) {
        self.user = [User fromDict:dict[@"user"]];
    }
    if (dict[@"content"]) {
        self.content = dict[@"content"];
    }
    if (dict[@"createdAt"]) {
        NSDateFormatter *dateFormatter = [NSDateFormatter ISO8601formatter];
        NSDate *createdAtDate = [dateFormatter dateFromString:[dict[@"createdAt"] ISO8601FormattedString]];
        self.createdAtDate = createdAtDate;
    }
}

- (NSDictionary *)toDict {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (self.content) {
        dict[@"content"] = self.content;
    }
    return [NSDictionary dictionaryWithDictionary:dict];
}

@end
