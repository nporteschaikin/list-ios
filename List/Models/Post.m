//
//  Post.m
//  List
//
//  Created by Noah Portes Chaikin on 7/6/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "Post.h"
#import "Constants.h"

@interface Post ()

@property (copy, nonatomic) NSString *postID;
@property (strong, nonatomic) Event *event;

@end

@implementation Post

- (void)applyDict:(NSDictionary *)dict {
    if (dict[@"_id"]) {
        self.postID = dict[@"_id"];
    }
    if ([dict[@"category"] isKindOfClass:[NSDictionary class]]) {
        self.category = [PostCategory fromDict:dict[@"category"]];
    }
    if ([dict[@"location"] isKindOfClass:[NSArray class]]) {
        self.location = [[CLLocation alloc] initWithLatitude:[dict[@"location"][1] doubleValue]
                                                   longitude:[dict[@"location"][0] doubleValue]];
    }
    if ([dict[@"user"] isKindOfClass:[NSDictionary class]]) {
        self.user = [User fromDict:dict[@"user"]];
    }
    if (dict[@"title"]) {
        self.title = dict[@"title"];
    }
    if (dict[@"content"]) {
        self.content = dict[@"content"];
    }
    if ([dict[@"threads"] isKindOfClass:[NSArray class]]) {
        self.threads = [Thread fromArray:dict[@"threads"]];
    }
    if ([dict[@"placemark"] isKindOfClass:[NSDictionary class]]) {
        self.placemark = [Placemark fromDict:dict[@"placemark"]];
    }
    if (dict[@"coverPhotoUrl"]) {
        self.coverPhotoURL = [NSURL URLWithString:dict[@"coverPhotoUrl"]];
    }
    if (dict[@"createdAt"]) {
        NSDateFormatter *dateFormatter = [NSDateFormatter ISO8601formatter];
        NSDate *createdAtDate = [dateFormatter dateFromString:[dict[@"createdAt"] ISO8601FormattedString]];
        self.createdAtDate = createdAtDate;
    }
    
    /*
     * Type switcher.
     */
    
    if ( [dict[@"__t"] isEqualToString:APIPostDiscriminatorEvent] ) {
        self.event = [Event fromDict:dict];
        self.type = PostTypeEvent;
    } else {
        self.type = PostTypePost;
    }
    
    self.coverImage = nil;
}

- (NSDictionary *)toDict {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (self.category.categoryID) {
        dict[@"category"] = self.category.categoryID;
    }
    if (self.title) {
        dict[@"title"] = self.title;
    }
    if (self.content) {
        dict[@"content"] = self.content;
    }
    if (self.location) {
        dict[@"latitude"] = [[NSNumber numberWithDouble:self.location.coordinate.latitude] stringValue];
        dict[@"longitude"] = [[NSNumber numberWithDouble:self.location.coordinate.longitude] stringValue];
    }
    if (self.coverImage) {
        dict[@"coverPhoto"] = [UIImageJPEGRepresentation(self.coverImage, 0.6) base64EncodedStringWithOptions:0];
    }
    
    /*
     * Type switcher.
     */
    
    switch (self.type) {
        case PostTypeEvent: {
            dict[@"event"] = [self.event toDict];
            break;
        }
        default: {
            break;
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:dict];
}

- (BOOL)isEqual:(Post *)post {
    return [post.postID isEqualToString:self.postID];
}

#pragma mark - Dynamic getters for different types.

- (Event *)event {
    if (!_event) {
        _event = [[Event alloc] init];
    }
    return _event;
}

@end
