//
//  Paging.m
//  List
//
//  Created by Noah Portes Chaikin on 12/8/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "Paging.h"

@interface Paging ()

@property (nonatomic) NSInteger count;
@property (copy, nonatomic) NSDictionary *sortConditions;

@end

@implementation Paging

- (void)applyJSONDict:(NSDictionary *)dict {
    
    /*
     * Set count.
     */
    
    self.count = [(NSNumber *)dict[@"count"] integerValue];
    
    /*
     * Set limit.
     */
    
    self.limit = [(NSNumber *)dict[@"limit"] integerValue];
    
    /*
     * Set sort conditions.
     */
    
    self.sortConditions = (NSDictionary *)dict[@"sort"];
    
}

@end
