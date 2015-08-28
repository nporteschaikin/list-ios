//
//  User.h
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListModel.h"
#import "Photo.h"

@interface User : ListModel

@property (copy, nonatomic, readonly) NSString *userID;
@property (copy, nonatomic) NSString *displayName;
@property (strong, nonatomic) Photo *profilePhoto;
@property (strong, nonatomic) Photo *coverPhoto;
@property (copy, nonatomic) NSString *bio;

@end
