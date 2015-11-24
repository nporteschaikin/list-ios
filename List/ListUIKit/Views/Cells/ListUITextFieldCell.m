//
//  ListUITextFieldCell.m
//  List
//
//  Created by Noah Portes Chaikin on 11/23/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUITextFieldCell.h"

@interface ListUITextFieldCell ()

@property (strong, nonatomic) ListUITextField *textField;

@end

@implementation ListUITextFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        /*
         * Create text field.
         */
        
        ListUITextField *textField = self.textField = [[ListUITextField alloc] init];
        [self.contentView addSubview:textField];
        
        /*
         * Set default inset.
         */
        
        UIEdgeInsets insets = UIEdgeInsetsMake(0.0f, 15.0f, 0.0f, 15.0f);
        textField.textInsets = insets;
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    /*
     * Lay out text field.
     */
    
    CGFloat x, y, w, h;
    x = 0.0f;
    y = 0.0f;
    w = CGRectGetWidth(self.contentView.bounds);
    h = CGRectGetHeight(self.contentView.bounds);
    self.textField.frame = CGRectMake(x, y, w, h);
    
}

@end
