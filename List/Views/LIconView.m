//
//  LIconView.m
//  List
//
//  Created by Noah Portes Chaikin on 8/5/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "LIconView.h"

@implementation LIconView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.iconColor = [UIColor blackColor];
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(self.iconSize, self.iconSize);
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    NSString *string = [IonIcons list_stringForIcon:self.icon];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentLeft;
    style.baseWritingDirection = NSWritingDirectionLeftToRight;
    UIFont *font = [IonIcons fontWithSize:self.iconSize];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:self.iconColor, NSParagraphStyleAttributeName:style}];
    CGRect boundingRect = [attributedString boundingRectWithSize:CGSizeMake(self.iconSize, self.iconSize) options:0 context:nil];
    [attributedString drawAtPoint:CGPointMake(((rect.size.width - boundingRect.size.width) / 2), (rect.size.height - boundingRect.size.height) / 2)];
}

- (void)setIconColor:(UIColor *)iconColor {
    _iconColor = iconColor;
    [self setNeedsDisplay];
}

- (void)setIconSize:(CGFloat)iconSize {
    _iconSize = iconSize;
    [self setNeedsDisplay];
}

- (void)setIcon:(LIcon)icon {
    _icon = icon;
    [self setNeedsDisplay];
}

@end
