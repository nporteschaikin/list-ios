//
//  Placemark.h
//  List
//
//  Created by Noah Portes Chaikin on 7/20/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LModel.h"

@interface Placemark : LModel

@property (copy, nonatomic) NSString *neighborhood;
@property (copy, nonatomic) NSString *locality;
@property (copy, nonatomic) NSString *sublocality;
@property (copy, nonatomic) NSString *country;
@property (copy, nonatomic, readonly) NSString *title;

@end
