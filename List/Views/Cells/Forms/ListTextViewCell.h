//
//  ListTextViewCell.h
//  List
//
//  Created by Noah Portes Chaikin on 8/2/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListTableViewCell.h"
#import "LTextView.h"

@interface ListTextViewCell : ListTableViewCell

@property (strong, nonatomic, readonly) LTextView *textView;

@end
