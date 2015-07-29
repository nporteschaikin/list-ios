//
//  Message.h
//  List
//
//  Created by Noah Portes Chaikin on 7/28/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "LModel.h"
#import "User.h"

@interface Message : LModel

@property (strong, nonatomic) User *user;
@property (copy, nonatomic) NSString *content;
@property (strong, nonatomic) NSDate *createdAtDate;

@end
