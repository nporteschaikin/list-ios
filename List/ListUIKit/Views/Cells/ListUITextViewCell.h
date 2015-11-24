//
//  ListUITextViewCell.h
//  List
//
//  Created by Noah Portes Chaikin on 11/23/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUITableViewCell.h"
#import "ListUITextView.h"

@interface ListUITextViewCell : ListUITableViewCell

@property (strong, nonatomic, readonly) ListUITextView *textView;

@end
