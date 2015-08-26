//
//  Tag.m
//  List
//
//  Created by Noah Portes Chaikin on 8/23/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "Tag.h"

@interface Tag ()

@property (strong, nonatomic) NSString *tagID;

@end

@implementation Tag

- (void)applyJSONDict:(NSDictionary *)dict {
    
    /*
     * Apply tag ID.
     */
    
    if (dict[@"_id"]) {
        self.tagID = dict[@"_id"];
    }
    
}

@end
