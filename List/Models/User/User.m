//
//  User.m
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "User.h"

@interface User ()

@property (copy, nonatomic) NSString *userID;

@end

@implementation User

- (void)applyJSONDict:(NSDictionary *)dict {
    
    /*
     * Set ID.
     */
    
    if (dict[@"_id"]) {
        self.userID = dict[@"_id"];
    }
    
    /*
     * Set name.
     */
    
    if (dict[@"displayName"]) {
        self.displayName = dict[@"displayName"];
    }
    
    /*
     * Set bio.
     */
    
    if (dict[@"bio"]) {
        self.bio = dict[@"bio"];
    }
    
    /*
     * Set profile picture.
     */
    
    if ([dict[@"profilePhoto"] isKindOfClass:[NSDictionary class]]) {
        self.profilePhoto = [Photo fromJSONDict:dict[@"profilePhoto"]];
    }
    
    /*
     * Set cover picture.
     */
    
    if (dict[@"coverPhoto"]) {
        self.coverPhoto = [Photo fromJSONDict:dict[@"profilePhoto"]];
    }
    
}

- (NSDictionary *)toJSON {
    
    /*
     * Create mutable dictionary.
     */
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    /*
     * Set display name.
     */
    
    if (self.displayName) {
        dict[@"displayName"] = self.displayName;
    }
    
    /*
     * Set bio.
     */
    
    if (self.bio) {
        dict[@"bio"] = self.bio;
    }
    
    /*
     * Set cover photo.
     */
    
    if (self.coverPhoto) {
        dict[@"coverPhoto"] = [self.coverPhoto toJSON];
    }
    
    /*
     * Set profile name.
     */
    
    if (self.profilePhoto) {
        dict[@"profilePicture"] = [self.profilePhoto toJSON];
    }
    
    /*
     * Return immutable dictionary.
     */
    
    return [NSDictionary dictionaryWithDictionary:dict];
    
}

- (BOOL)isEqual:(User *)user {
    
    /*
     * Compare IDs.
     */
    
    return [self.userID isEqualToString:user.userID];
    
}

@end
