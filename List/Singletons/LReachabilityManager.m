//
//  LReachabilityManager.m
//  List
//
//  Created by Noah Portes Chaikin on 7/15/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "LReachabilityManager.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>

@implementation LReachabilityManager

+ (LReachabilityManager *)sharedManager {
    static LReachabilityManager *sharedManager;
    if (!sharedManager) {
        sharedManager = [[self alloc] init];
    }
    return sharedManager;
}

- (BOOL)isReachable {
    SCNetworkReachabilityFlags flags;
    SCNetworkReachabilityRef address;
    address = SCNetworkReachabilityCreateWithName(NULL, "www.google.com");
    Boolean success = SCNetworkReachabilityGetFlags(address, &flags);
    CFRelease(address);
    
    return success
        && !(flags & kSCNetworkReachabilityFlagsConnectionRequired)
        && (flags & kSCNetworkReachabilityFlagsReachable);
}

@end
