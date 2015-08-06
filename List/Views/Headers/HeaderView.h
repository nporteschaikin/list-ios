//
//  HeaderView.h
//  List
//
//  Created by Noah Portes Chaikin on 7/30/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIconControl.h"

typedef NS_ENUM(NSUInteger, HeaderViewIconControlPosition) {
    HeaderViewIconControlPositionLeft,
    HeaderViewIconControlPositionRight
};

@interface HeaderView : UIView

@property (nonatomic) HeaderViewIconControlPosition iconControlPosition;
@property (strong, nonatomic, readonly) LIconControl *iconControl;
@property (strong, nonatomic, readonly) UILabel *textLabel;
@property (nonatomic) CGFloat xMargin;

@end
