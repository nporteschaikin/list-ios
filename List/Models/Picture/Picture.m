//
//  Picture.m
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "Picture.h"
#import "NSDateFormatter+ListAdditions.h"
#import "NSString+ListAdditions.h"

@implementation Picture

- (id<NSCopying>)toJSON {
    
    /*
     * Return mutable dictionary.
     */
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    /*
     * Handle text.
     */
    
    if (self.text) {
        dict[@"text"] = self.text;
    }
    
    /*
     * Handle asset.
     */
    
    if (self.asset) {
        dict[@"asset"] = [self.asset toJSON];
    }
    
    /*
     * Handle location.
     */
    
    if (self.location) {
        CLLocation *location = self.location;
        CLLocationCoordinate2D coordinate = location.coordinate;
        dict[@"latitude"] = [[NSNumber numberWithDouble:coordinate.latitude] stringValue];
        dict[@"longitude"] = [[NSNumber numberWithDouble:coordinate.longitude] stringValue];
    }
    
    /*
     * Return immutable dictionary.
     */
    
    return [NSDictionary dictionaryWithDictionary:dict];
    
}

- (void)applyJSONDict:(NSDictionary *)dict {
    
    /*
     * Set asset.
     */
    
    if ([dict[@"asset"] isKindOfClass:[NSDictionary class]]) {
        self.asset = [Photo fromJSONDict:dict[@"asset"]];
    }
    
    /*
     * Set text.
     */
    
    if (dict[@"text"]) {
        self.text = dict[@"text"];
    }
    
    /*
     * Set user.
     */
    
    if ([dict[@"user"] isKindOfClass:[NSDictionary class]]) {
        self.user = [User fromJSONDict:dict[@"user"]];
    }
    
    /*
     * Set placemark.
     */
    
    if ([dict[@"placemark"] isKindOfClass:[NSDictionary class]]) {
        self.placemark = [Placemark fromJSONDict:dict[@"placemark"]];
    }
    
    /*
     * Set placemark.
     */
    
    NSDateFormatter *dateFormatter = [NSDateFormatter list_ISO8601formatter];
    if (dict[@"createdAt"]) {
        self.createdAt = [dateFormatter dateFromString:[dict[@"createdAt"] list_stringForISO8601Formatter]];
    }
    
}

@end
