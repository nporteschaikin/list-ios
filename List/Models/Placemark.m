//
//  Placemark.m
//  List
//
//  Created by Noah Portes Chaikin on 7/20/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "Placemark.h"

@implementation Placemark

- (void)applyDict:(NSDictionary *)dict {
    if (dict[@"neighborhood"]) {
        self.neighborhood = dict[@"neighborhood"];
    }
    if (dict[@"locality"]) {
        self.locality = dict[@"locality"];
    }
    if (dict[@"sublocaity"]) {
        self.sublocality = dict[@"sublocality"];
    }
    if (dict[@"country"]) {
        self.country = dict[@"country"];
    }
}

- (NSString *)title {
    return self.neighborhood ? self.neighborhood
        : self.sublocality ? self.sublocality
        : self.locality ? self.locality
        : self.country ? self.country : nil;
}

@end
