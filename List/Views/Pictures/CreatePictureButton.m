//
//  CreatePictureButton.m
//  List
//
//  Created by Noah Portes Chaikin on 8/15/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "CreatePictureButton.h"

@interface CreatePictureButton ()

@property (strong, nonatomic) CAShapeLayer *circleLayer;

@end

@implementation CreatePictureButton

static CGFloat const kCreatePictureButtonWidth = 60.f;
static CGFloat const kCreatePictureButtonHeight = 40.f;
static CGFloat const kCreatePictureButtonCircleSize = 20.f;
static CGFloat const kCreatePictureButtonCornerRadius = 3.f;
static CGFloat const kCreatePictureButtonCircleStrokeSize = 3.f;

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Set defaults.
         */
        
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = kCreatePictureButtonCornerRadius;
        self.layer.masksToBounds = YES;
        
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(kCreatePictureButtonWidth, kCreatePictureButtonHeight);
}

- (void)drawRect:(CGRect)rect {
    CGRect circleRect = CGRectMake((rect.size.width - kCreatePictureButtonCircleSize) / 2, (rect.size.height - kCreatePictureButtonCircleSize) / 2, kCreatePictureButtonCircleSize, kCreatePictureButtonCircleSize);
    CGRect innerCircleRect = CGRectInset(circleRect, kCreatePictureButtonCircleStrokeSize, kCreatePictureButtonCircleStrokeSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextClearRect(context, rect);
    CGContextAddRect(context, rect);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    
    CGContextAddEllipseInRect(context, circleRect);
    CGContextClip(context);
    CGContextClearRect(context, circleRect);
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, circleRect);
    
    CGContextAddEllipseInRect(context, innerCircleRect);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextClip(context);
    CGContextFillRect(context, innerCircleRect);
}

@end
