//
//  Placemark.m
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "Placemark.h"

@implementation Placemark

- (void)applyJSONDict:(NSDictionary *)dict {
    
    /*
     * Handle neighborhood.
     */
    
    if (dict[@"neighborhood"]) {
        self.neighborhood = dict[@"neighborhood"];
    }
    
    /*
     * Handle locality.
     */
    
    if (dict[@"locality"]) {
        self.locality = dict[@"locality"];
    }
    
    /*
     * Handle sublocality.
     */
    
    if (dict[@"sublocality"]) {
        self.sublocality = dict[@"sublocality"];
    }
    
    /*
     * Handle country.
     */
    
    if (dict[@"country"]) {
        self.country = dict[@"country"];
    }
    
}

- (NSString *)title {
    
    /*
     * Return the most specific attribute
     * available.
     */
    
    return self.neighborhood ? self.neighborhood
        : self.sublocality ? self.sublocality
        : self.locality ? self.locality
        : self.country ? self.country
        : nil;
    
}

@end
