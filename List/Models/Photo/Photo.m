//
//  Photo.m
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (id<NSCopying>)toJSON {
    
    /*
     * Encode image.
     */
    
    NSString *base64EncodedImage = [UIImageJPEGRepresentation(self.image, 0.6) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    /*
     * Return encoded image with 
     * header declaring type.
     */
    
    return [@"data:image/jpg;base64," stringByAppendingString:base64EncodedImage];
}

- (void)applyJSONDict:(NSDictionary *)dict {
    
    /*
     * Set URL
     */
    
    if (dict[@"url"]) {
        self.URL = [NSURL URLWithString:dict[@"url"]];
    }
    
}

@end
