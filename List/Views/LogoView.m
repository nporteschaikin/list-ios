//
//  LogoView.m
//  List
//
//  Created by Noah Portes Chaikin on 7/23/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "LogoView.h"

@implementation LogoView

static NSString * const LogoViewLogoURL = @"logo";

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
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor clearColor] set];
    CGContextFillRect(ctx, rect);
    CGContextGetCTM(ctx);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -rect.size.height);
    NSString *path = [[NSBundle mainBundle] pathForResource:LogoViewLogoURL ofType:@"pdf"];
    NSURL *URL = [NSURL fileURLWithPath:path];
    CGPDFDocumentRef logo = CGPDFDocumentCreateWithURL((CFURLRef)URL);
    CGPDFPageRef page1 = CGPDFDocumentGetPage(logo, 1);
    CGRect logoRect = CGPDFPageGetBoxRect(page1, kCGPDFCropBox);
    CGContextScaleCTM(ctx, rect.size.width / logoRect.size.width, rect.size.height / logoRect.size.height);
    CGContextTranslateCTM(ctx, -logoRect.origin.x, -logoRect.origin.y);
    CGContextDrawPDFPage(ctx, page1);
    CGPDFDocumentRelease(logo);
}


@end
