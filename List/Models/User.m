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

- (void)applyDict:(NSDictionary *)dict {
    if (dict[@"_id"]) {
        self.userID = dict[@"_id"];
    }
    if (dict[@"displayName"]) {
        self.displayName = dict[@"displayName"];
    }
    if (dict[@"bio"]) {
        self.bio = dict[@"bio"];
    }
    if (dict[@"profilePictureUrl"]) {
        self.profilePictureURL = [NSURL URLWithString:dict[@"profilePictureUrl"]];
    }
    if (dict[@"coverPhotoUrl"]) {
        self.coverPhotoURL = [NSURL URLWithString:dict[@"coverPhotoUrl"]];
    }
    self.coverImage = nil;
    self.profileImage = nil;
}

- (NSDictionary *)toDict {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (self.displayName) {
        dict[@"displayName"] = self.displayName;
    }
    if (self.bio) {
        dict[@"bio"] = self.bio;
    }
    if (self.coverImage) {
        dict[@"coverPhoto"] = [UIImageJPEGRepresentation(self.coverImage, 0.6) base64EncodedStringWithOptions:0];
    }
    if (self.profileImage) {
        dict[@"profilePicture"] = [UIImageJPEGRepresentation(self.profileImage, 0.6) base64EncodedStringWithOptions:0];
    }
    return [NSDictionary dictionaryWithDictionary:dict];
}

- (BOOL)isEqual:(User *)user {
    return [self.userID isEqualToString:user.userID];
}

@end
