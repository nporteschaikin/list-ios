//
//  LReachabilityManager.h
//  List
//
//  Created by Noah Portes Chaikin on 7/15/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LReachabilityManager : NSObject

@property (nonatomic, readonly) BOOL isReachable;

+ (LReachabilityManager *)sharedManager;

@end
