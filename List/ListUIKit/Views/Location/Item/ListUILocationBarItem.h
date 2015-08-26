//
//  ListUILocationBarItem.h
//  List
//
//  Created by Noah Portes Chaikin on 8/15/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListUILocationBarItem : NSObject

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIColor *tintColor;
@property (strong, nonatomic) UIColor *barTintColor;
@property (strong, nonatomic) NSString *locationName;
@property (nonatomic) double *locationRadius;

@end
