//
//  ListLabelView.h
//  List
//
//  Created by Noah Portes Chaikin on 8/5/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIconView.h"

@interface ListLabelView : UIView

@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) UIColor *color;
@property (nonatomic) LIcon icon;

@end
