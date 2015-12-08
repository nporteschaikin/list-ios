//
//  Paging.h
//  List
//
//  Created by Noah Portes Chaikin on 12/8/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListModel.h"

@interface Paging : ListModel

@property (nonatomic, readonly) NSInteger count;
@property (copy, nonatomic, readonly) NSDictionary *sortConditions;
@property (nonatomic) NSInteger limit;

@end
