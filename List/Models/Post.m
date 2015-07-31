//
//  Post.m
//  List
//
//  Created by Noah Portes Chaikin on 7/6/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "Post.h"
#import "NSDate+ISO8601.h"

@interface Post ()

@property (copy, nonatomic) NSString *postID;

@end

@implementation Post

- (void)applyJSON:(NSDictionary *)JSON {
    self.postID = JSON[@"_id"];
    self.title = JSON[@"title"];
    self.content = JSON[@"content"];
    self.createdAtDate = [NSDate dateWithISO8601:JSON[@"createdAt"]];
    self.coverImage = nil;
    if (JSON[@"coverPhotoUrl"] != [NSNull null]) self.coverPhotoURL = [NSURL URLWithString:JSON[@"coverPhotoUrl"]];
    if ([JSON[@"user"] isKindOfClass:[NSDictionary class]]) self.user = [User fromJSONDict:JSON[@"user"]];
    if ([JSON[@"category"] isKindOfClass:[NSDictionary class]]) self.category = [PostCategory fromJSONDict:JSON[@"category"]];
    if ([JSON[@"threads"] isKindOfClass:[NSArray class]]) self.threads = [Thread fromJSONArray:JSON[@"threads"]];
    if ([JSON[@"placemark"] isKindOfClass:[NSDictionary class]]) self.placemark = [Placemark fromJSONDict:JSON[@"placemark"]];
    
    NSArray *location = JSON[@"location"];
    if (location) {
        self.location = [[CLLocation alloc] initWithLatitude:[location[1] doubleValue]
                                                   longitude:[location[0] doubleValue]];
    }
}

- (NSDictionary *)propertiesJSON {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (self.category) dict[@"category"] = self.category.categoryID;
    if (self.title) dict[@"title"] = self.title;
    if (self.content) dict[@"content"] = self.content;
    if (self.coverImage) dict[@"coverPhoto"] = [UIImageJPEGRepresentation(self.coverImage, 0.6) base64EncodedStringWithOptions:0];
    if (self.location) {
        dict[@"latitude"] = [[NSNumber numberWithDouble:self.location.coordinate.latitude] stringValue];
        dict[@"longitude"] = [[NSNumber numberWithDouble:self.location.coordinate.longitude] stringValue];
    }
    return [NSDictionary dictionaryWithDictionary:dict];
}

- (NSObject<NSCopying> *)equalityProperty {
    return self.postID;
}

@end
