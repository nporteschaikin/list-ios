//
//  PostCategory.h
//  List
//
//  Created by Noah Portes Chaikin on 7/3/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "LModel.h"

@interface PostCategory : LModel

@property (copy, nonatomic, readonly) NSString *categoryID;
@property (copy, nonatomic) NSString *name;

@end
