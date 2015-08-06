//
//  LIconControl.m
//  List
//
//  Created by Noah Portes Chaikin on 7/14/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "LIconControl.h"

@implementation LIconControl

static CGFloat const LIconControlLineWidth = 2.0f;

- (instancetype)init {
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithStyle:(LIconControlStyle)style {
    if (self = [self init]) {
        self.style = style;
    }
    return self;
}

- (void)setupView {
    self.backgroundColor = [UIColor clearColor];
}

- (void)setStyle:(LIconControlStyle)style {
    _style = style;
    [self setNeedsDisplay];
}

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGFloat x = CGRectGetMinX(rect) + (LIconControlLineWidth / 2);
    CGFloat y = CGRectGetMinY(rect) + (LIconControlLineWidth / 2);
    CGFloat w = CGRectGetWidth(rect) - LIconControlLineWidth;
    CGFloat h = CGRectGetHeight(rect) - LIconControlLineWidth;
    CGRect circleRect = CGRectMake(x, y, w, h);
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:circleRect];
    circlePath.lineWidth = LIconControlLineWidth;
    [[UIColor clearColor] setFill];
    [self.lineColor setStroke];
    [circlePath fill];
    [circlePath stroke];
    
    switch (self.style) {
        case LIconControlStyleAdd: {
            
            /*
             * LIconControlStyleAdd
             */
            
            CGFloat plusSize = rect.size.width * .45;
            CGFloat xStartX = rect.origin.x + ((rect.size.width - plusSize) / 2);
            CGFloat xStartY = rect.origin.y + (rect.size.height / 2);
            CGFloat xEndX = xStartX + plusSize;
            CGFloat xEndY = xStartY;
            CGFloat yStartX = rect.origin.x + (rect.size.width / 2);
            CGFloat yStartY = rect.origin.y + ((rect.size.height - plusSize) / 2);
            CGFloat yEndX = yStartX;
            CGFloat yEndY = yStartY + plusSize;
            UIBezierPath *plusPath = [UIBezierPath bezierPath];
            plusPath.lineWidth = LIconControlLineWidth;
            [plusPath moveToPoint:CGPointMake(xStartX, xStartY)];
            [plusPath addLineToPoint:CGPointMake(xEndX, xEndY)];
            [plusPath moveToPoint:CGPointMake(yStartX, yStartY)];
            [plusPath addLineToPoint:CGPointMake(yEndX, yEndY)];
            
            [self.lineColor setStroke];
            [plusPath stroke];
            
            break;
        }
        case LIconControlStyleRemove: {
            
            /*
             * LIconControlStyleRemove
             */
            
            CGFloat closeSize = rect.size.width * .35;
            CGFloat xStartX = rect.origin.x + ((rect.size.width - closeSize) / 2);
            CGFloat xStartY = rect.origin.y + ((rect.size.height - closeSize) / 2);
            CGFloat xEndX = xStartX + closeSize;
            CGFloat xEndY = xStartY + closeSize;
            CGFloat yStartX = (rect.origin.x + rect.size.width) - ((rect.size.width - closeSize) / 2);
            CGFloat yStartY = (rect.size.width - closeSize) / 2;
            CGFloat yEndX = yStartX - closeSize;
            CGFloat yEndY = yStartY + closeSize;
            UIBezierPath *closePath = [UIBezierPath bezierPath];
            closePath.lineWidth = LIconControlLineWidth;
            [closePath moveToPoint:CGPointMake(xStartX, xStartY)];
            [closePath addLineToPoint:CGPointMake(xEndX, xEndY)];
            [closePath moveToPoint:CGPointMake(yStartX, yStartY)];
            [closePath addLineToPoint:CGPointMake(yEndX, yEndY)];
            [self.lineColor setStroke];
            [closePath stroke];
            
            break;
        }
        case LIconControlStyleMenu: {
            
            /*
             * LIconControlStyleMenu
             */
            
            CGFloat menuSize = rect.size.width * .45;
            CGFloat firstLineStartX = ((rect.size.width - menuSize) / 2);
            CGFloat firstLineStartY = CGRectGetMidY(rect) - (LIconControlLineWidth * 2);
            CGFloat firstLineEndX = rect.size.width - ((rect.size.width - menuSize) / 2);
            CGFloat firstLineEndY = firstLineStartY;
            CGFloat secondLineStartX = firstLineStartX;
            CGFloat secondLineStartY = CGRectGetMidY(rect);
            CGFloat secondLineEndX = firstLineEndX;
            CGFloat secondLineEndY = secondLineStartY;
            CGFloat thirdLineStartX = firstLineStartX;
            CGFloat thirdLineStartY = CGRectGetMidY(rect) + (LIconControlLineWidth * 2);
            CGFloat thirdLineEndX = firstLineEndX;
            CGFloat thirdLineEndY = thirdLineStartY;
            UIBezierPath *linePath = [UIBezierPath bezierPath];
            linePath.lineWidth = LIconControlLineWidth;
            [linePath moveToPoint:CGPointMake(firstLineStartX, firstLineStartY)];
            [linePath addLineToPoint:CGPointMake(firstLineEndX, firstLineEndY)];
            [linePath moveToPoint:CGPointMake(secondLineStartX, secondLineStartY)];
            [linePath addLineToPoint:CGPointMake(secondLineEndX, secondLineEndY)];
            [linePath moveToPoint:CGPointMake(thirdLineStartX, thirdLineStartY)];
            [linePath addLineToPoint:CGPointMake(thirdLineEndX, thirdLineEndY)];
            [self.lineColor setStroke];
            [linePath stroke];
            
            break;
        }
        default: {
            break;
        }
    }
}

@end
