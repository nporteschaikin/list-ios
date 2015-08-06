//
//  ActivityIndicatorView.h
//  List
//
//  Created by Noah Portes Chaikin on 7/1/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ActivityIndicatorViewStyle) {
    ActivityIndicatorViewStyleBlue,
    ActivityIndicatorViewStyleWhite
};

@interface ActivityIndicatorView : UIView

@property (nonatomic, readonly) ActivityIndicatorViewStyle style;
@property (nonatomic, readonly) BOOL isAnimating;

- (id)initWithStyle:(ActivityIndicatorViewStyle)style NS_DESIGNATED_INITIALIZER;

@end
