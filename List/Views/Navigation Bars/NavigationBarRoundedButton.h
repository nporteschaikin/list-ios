//
//  NavigationBarRoundedButton.h
//  List
//
//  Created by Noah Portes Chaikin on 11/25/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"

typedef NS_ENUM(NSInteger, NavigationBarRoundedButtonColor) {
    NavigationBarRoundedButtonBlueColor
};

@interface NavigationBarRoundedButton : UIButton

@property (nonatomic) NavigationBarRoundedButtonColor color;

@end
