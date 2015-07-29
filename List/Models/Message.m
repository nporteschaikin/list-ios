//
//  Message.m
//  List
//
//  Created by Noah Portes Chaikin on 7/28/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "Message.h"
#import "NSDate+ISO8601.h"

@implementation Message

- (void)applyJSON:(NSDictionary *)JSON {
    self.content = JSON[@"content"];
    self.createdAtDate = [NSDate dateWithISO8601:JSON[@"createdAt"]];
    if ([JSON[@"user"] isKindOfClass:[NSDictionary class]]) self.user = [User fromJSONDict:JSON[@"user"]];
}

- (NSDictionary *)propertiesJSON {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (self.content) dict[@"content"] = self.content;
    return [NSDictionary dictionaryWithDictionary:dict];
}

@end
