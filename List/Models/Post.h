//
//  Post.h
//  List
//
//  Created by Noah Portes Chaikin on 7/6/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "LModel.h"
#import "PostCategory.h"
#import "User.h"
#import "Thread.h"
#import "Placemark.h"
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface Post : LModel

@property (copy, nonatomic, readonly) NSString *postID;
@property (strong, nonatomic) PostCategory *category;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) Placemark *placemark;
@property (strong, nonatomic) CLLocation *location;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *content;
@property (strong, nonatomic) NSURL *coverPhotoURL;
@property (strong, nonatomic) UIImage *coverImage;
@property (strong, nonatomic) NSDate *createdAtDate;
@property (strong, nonatomic) NSArray *threads;

@end
