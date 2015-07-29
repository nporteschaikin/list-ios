//
//  LModel.h
//  List
//
//  Created by Noah Portes Chaikin on 7/6/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LModel;

@protocol LModelConversion <NSObject>

+ (NSArray *)fromJSONArray:(NSArray *)JSON;
+ (instancetype)fromJSONDict:(NSDictionary *)JSON;
- (NSDictionary *)toJSON;

@optional
- (NSDictionary *)propertiesJSON;
- (void)applyJSON:(NSDictionary *)JSON;
- (NSObject<NSCopying> *)equalityProperty;

@end

@interface LModel : NSObject <LModelConversion>

@end
