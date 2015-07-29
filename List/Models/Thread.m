//
//  Thread.m
//  List
//
//  Created by Noah Portes Chaikin on 7/16/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "Thread.h"
#import "NSDate+ISO8601.h"

@interface Thread ()

@property (copy, nonatomic) NSString *threadID;

@end

@implementation Thread

- (void)applyJSON:(NSDictionary *)JSON {
    self.threadID = JSON[@"_id"];
    self.content = JSON[@"content"];
    self.messages = [Message fromJSONArray:JSON[@"messages"]];
    self.createdAtDate = [NSDate dateWithISO8601:JSON[@"createdAt"]];
    self.isPrivate = [JSON[@"isPrivate"] boolValue];
    if ([JSON[@"user"] isKindOfClass:[NSDictionary class]]) self.user = [User fromJSONDict:JSON[@"user"]];
}

- (NSDictionary *)propertiesJSON {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (self.content) dict[@"content"] = self.content;
    if (self.isPrivate) dict[@"isPrivate"] = [NSNumber numberWithBool:self.isPrivate];
    return [NSDictionary dictionaryWithDictionary:dict];
}

- (NSObject<NSCopying> *)equalityProperty {
    return self.threadID;
}

@end
