//
//  Thread.h
//  List
//
//  Created by Noah Portes Chaikin on 7/16/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LModel.h"
#import "User.h"
#import "Post.h"
#import "Message.h"

@interface Thread : LModel

@property (copy, nonatomic, readonly) NSString *threadID;
@property (strong, nonatomic) User *user;
@property (nonatomic) BOOL isPrivate;
@property (copy, nonatomic) NSString *content;
@property (strong, nonatomic) NSDate *createdAtDate;
@property (copy, nonatomic) NSArray *messages;

@end
