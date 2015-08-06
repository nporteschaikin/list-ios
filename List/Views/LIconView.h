//
//  LIconView.h
//  List
//
//  Created by Noah Portes Chaikin on 8/5/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IonIcons+LIcon.h"

@interface LIconView : UIView

@property (nonatomic) CGFloat iconSize;
@property (strong, nonatomic) UIColor *iconColor;
@property (nonatomic) LIcon icon;

@end
