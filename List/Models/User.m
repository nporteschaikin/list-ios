//
//  User.m
//  List
//
//  Created by Noah Portes Chaikin on 7/5/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "User.h"

@interface User ()

@property (copy, nonatomic) NSString *userID;

@end

@implementation User

- (void)applyJSON:(NSDictionary *)JSON {
    self.userID = JSON[@"_id"];
    self.displayName = JSON[@"displayName"];
    self.bio = JSON[@"bio"];
    if (JSON[@"profilePictureUrl"] != [NSNull null]) self.profilePictureURL = [NSURL URLWithString:JSON[@"profilePictureUrl"]];
    if (JSON[@"coverPhotoUrl"] != [NSNull null]) self.coverPhotoURL = [NSURL URLWithString:JSON[@"coverPhotoUrl"]];
    self.coverImage = nil;
    self.profileImage = nil;
}

- (NSDictionary *)propertiesJSON {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (self.bio) dict[@"bio"] = self.bio;
    if (self.coverImage) dict[@"coverPhoto"] = [UIImageJPEGRepresentation(self.coverImage, 0.6) base64EncodedStringWithOptions:0];
    if (self.profileImage) dict[@"profilePicture"] = [UIImageJPEGRepresentation(self.profileImage, 0.6) base64EncodedStringWithOptions:0];
    return [NSDictionary dictionaryWithDictionary:dict];
}

- (NSObject<NSCopying> *)equalityProperty {
    return self.userID;
}

@end
