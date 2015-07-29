//
//  LogoView.m
//  List
//
//  Created by Noah Portes Chaikin on 7/23/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "LogoView.h"

@implementation LogoView

static CGFloat const LogoViewLineWidth = 2.0f;

- (instancetype)init {
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.backgroundColor = [UIColor clearColor];
}

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGFloat x = CGRectGetMinX(rect) + (LogoViewLineWidth / 2);
    CGFloat y = CGRectGetMinY(rect) + (LogoViewLineWidth / 2);
    CGFloat w = CGRectGetWidth(rect) - LogoViewLineWidth;
    CGFloat h = CGRectGetHeight(rect) - LogoViewLineWidth;
    CGRect circleRect = CGRectMake(x, y, w, h);
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:circleRect];
    circlePath.lineWidth = LogoViewLineWidth;
    [[UIColor clearColor] setFill];
    [self.lineColor setStroke];
    [circlePath fill];
    [circlePath stroke];
    CGFloat menuSize = rect.size.width * .45;
    CGFloat firstLineStartX = ((rect.size.width - menuSize) / 2);
    CGFloat firstLineStartY = CGRectGetMidY(rect) - (LogoViewLineWidth * 2);
    CGFloat firstLineEndX = rect.size.width - ((rect.size.width - menuSize) / 2);
    CGFloat firstLineEndY = firstLineStartY;
    CGFloat secondLineStartX = firstLineStartX;
    CGFloat secondLineStartY = CGRectGetMidY(rect);
    CGFloat secondLineEndX = firstLineEndX;
    CGFloat secondLineEndY = secondLineStartY;
    CGFloat thirdLineStartX = firstLineStartX;
    CGFloat thirdLineStartY = CGRectGetMidY(rect) + (LogoViewLineWidth * 2);
    CGFloat thirdLineEndX = firstLineEndX;
    CGFloat thirdLineEndY = thirdLineStartY;
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    linePath.lineWidth = LogoViewLineWidth;
    [linePath moveToPoint:CGPointMake(firstLineStartX, firstLineStartY)];
    [linePath addLineToPoint:CGPointMake(firstLineEndX, firstLineEndY)];
    [linePath moveToPoint:CGPointMake(secondLineStartX, secondLineStartY)];
    [linePath addLineToPoint:CGPointMake(secondLineEndX, secondLineEndY)];
    [linePath moveToPoint:CGPointMake(thirdLineStartX, thirdLineStartY)];
    [linePath addLineToPoint:CGPointMake(thirdLineEndX, thirdLineEndY)];
    [self.lineColor setStroke];
    [linePath stroke];
}


@end
