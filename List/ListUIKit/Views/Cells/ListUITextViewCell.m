//
//  ListUITextViewCell.m
//  List
//
//  Created by Noah Portes Chaikin on 11/23/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUITextViewCell.h"

@interface ListUITextViewCell ()

@property (strong, nonatomic) ListUITextView *textView;

@end

@implementation ListUITextViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        /*
         * Create text view.
         */
        
        ListUITextView *textView = self.textView = [[ListUITextView alloc] init];
        [self.contentView addSubview:textView];
        
        /*
         * Set default inset.
         */
        
        UIEdgeInsets insets = UIEdgeInsetsMake(6.0f, 10.0f, 6.0f, 10.0f);
        textView.textContainerInset = insets;
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    /*
     * Lay out text view.
     */
    
    CGFloat x, y, w, h;
    x = 0.0f;
    y = 0.0f;
    w = CGRectGetWidth(self.contentView.bounds);
    h = CGRectGetHeight(self.contentView.bounds);
    self.textView.frame = CGRectMake(x, y, w, h);
    
}

@end
