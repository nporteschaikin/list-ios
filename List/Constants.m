//
//  Constants.m
//  List
//
//  Created by Noah Portes Chaikin on 7/3/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "Constants.h"

NSString * const HockeyIdentifier = @"6286bdff06263bcc6844a5bc86b9bdd9";

NSString * const APIBaseURL = @"http://list-io.herokuapp.com/";
NSString * const APIAuthEndpoint = @"auth";
NSString * const APIAuthAPSEndpoint = @"auth/aps";
NSString * const APIPostsEndpoint = @"posts";
NSString * const APIPostEndpoint = @"posts/%@";
NSString * const APIPostThreadsEndpoint = @"posts/%@/threads";
NSString * const APIPostThreadMessagesEndpoint = @"posts/%@/threads/%@/messages";
NSString * const APIThreadsEndpoint = @"threads";
NSString * const APICategoriesEndpoint = @"categories";
NSString * const APIUserEndpoint = @"users/%@";
NSString * const APINotificationsEndpoint = @"notifications";
NSString * const APIGeocoderPlacemarkEndpoint = @"geocoder/placemark";

float const DiscoveryRadiusInMilesDefaultValue = 5.0;

NSString * const SessionTokenUserDefaultsKey = @"SessionTokenUserDefaultsKey";
NSString * const DiscoveryRadiusInMilesUserDefaultsKey = @"DiscoveryRadiusInMilesUserDefaultsKey";

float const ActivityIndicatorViewDefaultSize = 75.f;