//
//  Thread.m
//  List
//
//  Created by Noah Portes Chaikin on 7/16/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "Thread.h"

@interface Thread ()

@property (copy, nonatomic) NSString *threadID;

@end

@implementation Thread

- (NSDictionary *)toJSONDict {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (self.content) {
        dict[@"content"] = self.content;
    }
    if (self.isPrivate) {
        dict[@"isPrivate"] = [NSNumber numberWithBool:self.isPrivate];
    }
    return [NSDictionary dictionaryWithDictionary:dict];
}

- (void)applyDict:(NSDictionary *)dict {
    if (dict[@"_id"]) {
        self.threadID = dict[@"_id"];
    }
    if ([dict[@"user"] isKindOfClass:[NSDictionary class]]) {
        self.user = [User fromDict:dict[@"user"]];
    }
    if (dict[@"content"]) {
        self.content = dict[@"content"];
    }
    if (dict[@"isPrivate"]) {
        self.isPrivate = [dict[@"isPrivate"] boolValue];
    }
    if ([dict[@"messages"] isKindOfClass:[NSArray class]]) {
        self.messages = [Message fromArray:dict[@"threads"]];
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
    if (self.isPrivate) {
        dict[@"isPrivate"] = [NSNumber numberWithBool:self.isPrivate];
    }
    return [NSDictionary dictionaryWithDictionary:dict];
}

@end
