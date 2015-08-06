//
//  LTextField.m
//  List
//
//  Created by Noah Portes Chaikin on 7/8/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "LTextField.h"
#import "UIFont+List.h"
#import "UIColor+List.h"

@interface LTextField ()

@property (strong, nonatomic) UILabel *label;

@end

@implementation LTextField

- (instancetype)init {
    if (self = [super init]) {
        /*
         * Default font size.
         */
        
        self.font = [UIFont list_lTextFieldFont];
        
    }
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder {
    [super setPlaceholder:placeholder];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:[UIColor list_darkGrayColorAlpha:1]}];
}

#pragma mark - Rects

- (CGRect)textRectForBounds:(CGRect)bounds {
    return UIEdgeInsetsInsetRect([super textRectForBounds:bounds], self.textInsets);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return UIEdgeInsetsInsetRect([super editingRectForBounds:bounds], self.textInsets);
}


@end
