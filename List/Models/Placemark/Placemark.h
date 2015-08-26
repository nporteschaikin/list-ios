//
//  Placemark.h
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListModel.h"

@interface Placemark : ListModel

@property (copy, nonatomic, readonly) NSString *title;
@property (copy, nonatomic, readonly) NSString *placemarkID;
@property (copy, nonatomic) NSString *neighborhood;
@property (copy, nonatomic) NSString *locality;
@property (copy, nonatomic) NSString *sublocality;
@property (copy, nonatomic) NSString *country;

@end
