//
//  Placemark.m
//  List
//
//  Created by Noah Portes Chaikin on 7/20/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "Placemark.h"

@implementation Placemark

- (void)applyJSON:(NSDictionary *)JSON {
    self.neighborhood = JSON[@"neighborhood"];
    self.locality = JSON[@"locality"];
    self.sublocality = JSON[@"sublocality"];
    self.country = JSON[@"country"];
}

- (NSString *)title {
    return self.neighborhood ? self.neighborhood
        : self.sublocality ? self.sublocality
        : self.locality ? self.locality
        : self.country ? self.country : nil;
}

@end
