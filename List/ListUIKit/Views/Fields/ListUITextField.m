//
//  ListUITextField.m
//  List
//
//  Created by Noah Portes Chaikin on 8/19/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUITextField.h"
#import "UIFont+ListUI.h"
#import "UIColor+ListUI.h"

@implementation ListUITextField

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Set defaults
         */
        
        self.font = [UIFont listFontWithSize:15.f];
        
    }
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder {
    
    /*
     * Set placeholder.
     */
    
    [super setPlaceholder:placeholder];
    
    /*
     * Update attributed placeholder.
     */
    
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
    
}

#pragma mark - Rects

- (CGRect)textRectForBounds:(CGRect)bounds {
    
    /*
     * Use text inset.
     */
    
    return UIEdgeInsetsInsetRect([super textRectForBounds:bounds], self.textInsets);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    
    /*
     * Use text inset.
     */
    
    return UIEdgeInsetsInsetRect([super editingRectForBounds:bounds], self.textInsets);
    
}

@end
