//
//  User.h
//  List
//
//  Created by Noah Portes Chaikin on 7/5/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LModel.h"

@interface User : LModel

@property (copy, nonatomic, readonly) NSString *userID;
@property (copy, nonatomic) NSString *displayName;
@property (copy, nonatomic) NSURL *profilePictureURL;
@property (copy, nonatomic) NSURL *coverPhotoURL;
@property (copy, nonatomic) NSString *bio;
@property (strong, nonatomic) UIImage *coverImage;
@property (strong, nonatomic) UIImage *profileImage;

@end
