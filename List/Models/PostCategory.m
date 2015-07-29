//
//  PostCategory.m
//  List
//
//  Created by Noah Portes Chaikin on 7/3/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PostCategory.h"

@interface PostCategory ()

@property (copy, nonatomic) NSString *categoryID;

@end

@implementation PostCategory

- (void)applyJSON:(NSDictionary *)JSON {
    self.categoryID = JSON[@"_id"];
    self.name = JSON[@"name"];
}

- (NSObject<NSCopying> *)equalityProperty {
    return self.categoryID;
}

@end
