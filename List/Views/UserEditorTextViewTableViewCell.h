//
//  UserEditorTextViewTableViewCell.h
//  List
//
//  Created by Noah Portes Chaikin on 7/28/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTextView.h"

@interface UserEditorTextViewTableViewCell : UITableViewCell

@property (strong, nonatomic, readonly) LTextView *textView;

@end
