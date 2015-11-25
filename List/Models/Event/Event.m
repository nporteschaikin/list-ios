//
//  Event.m
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "Event.h"
#import "NSDateFormatter+ListAdditions.h"

@implementation Event

- (id<NSCopying>)toJSON {
    
    /*
     * Return mutable dictionary.
     */
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    /*
     * Handle title.
     */
    
    if (self.title) {
        dict[@"title"] = self.title;
    }
    
    /*
     * Handle text.
     */
    
    if (self.text) {
        dict[@"text"] = self.text;
    }
    
    /*
     * Handle place name.
     */
    
    if (self.placeName) {
        dict[@"placeName"] = self.placeName;
    }
    
    /*
     * Handle place address.
     */
    
    if (self.placeName) {
        dict[@"placeAddress"] = self.placeAddress;
    }
    
    /*
     * Set start time
     */
    
    NSDateFormatter *dateFormatter = [NSDateFormatter list_ISO8601formatter];
    if (self.startTime) {
        dict[@"startTime"] = [dateFormatter stringFromDate:self.startTime];
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
     * Set title.
     */
    
    if (dict[@"title"]) {
        self.title = dict[@"title"];
    }
    
    /*
     * Set place name.
     */
    
    if (dict[@"placeName"]) {
        self.placeName = dict[@"placeName"];
    }
    
    /*
     * Set place address.
     */
    
    if (dict[@"placeAddress"]) {
        self.placeAddress = dict[@"placeAddress"];
    }
    
    /*
     * Set start time
     */
    
    NSDateFormatter *dateFormatter = [NSDateFormatter list_ISO8601formatter];
    if (dict[@"startTime"]) {
        self.startTime = [dateFormatter dateFromString:dict[@"startTime"]];
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
    
}

@end
