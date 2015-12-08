//
//  Params.m
//  List
//
//  Created by Noah Portes Chaikin on 12/7/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "Params.h"

@implementation Params

- (void)applyJSONDict:(NSDictionary *)dict {
    
    /*
     * Set offset
     */
    
    if (dict[@"offset"]) {
        self.offset = [(NSNumber *)dict[@"offset"] integerValue];
    }
    
    /*
     * Set max
     */
    
    if (dict[@"limit"]) {
        self.limit = [(NSNumber *)dict[@"limit"] integerValue];
    }
    
    /*
     * Set count
     */
    
    if (dict[@"count"]) {
        self.count = [(NSNumber *)dict[@"count"] integerValue];
    }
    
}

@end
