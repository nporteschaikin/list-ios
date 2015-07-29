//
//  MessagesFormView.h
//  List
//
//  Created by Noah Portes Chaikin on 7/20/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTextView.h"

@interface MessagesFormView : UIView

@property (strong, nonatomic, readonly) LTextView *textView;
@property (strong, nonatomic, readonly) UIButton *saveButton;

@end
