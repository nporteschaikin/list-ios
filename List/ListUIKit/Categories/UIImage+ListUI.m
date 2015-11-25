//
//  listImageWithColorUI.m
//  List
//
//  Created by Noah Portes Chaikin on 8/14/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "UIImage+ListUI.h"
#import "UIFont+ListUI.h"
#import "ListUIConstants.h"

@implementation UIImage (ListUI)

+ (UIImage *)listUI_logoImageSize:(CGFloat)size {
    
    /*
     * Takes the PDF and turns it into a UIImage.
     */
    
    CGRect rect = CGRectMake(0, 0, size, size);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor clearColor] set];
    CGContextFillRect(ctx, rect);
    CGContextGetCTM(ctx);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -rect.size.height);
    NSString *path = [[NSBundle mainBundle] pathForResource:@"logo" ofType:@"pdf"];
    NSURL *URL = [NSURL fileURLWithPath:path];
    CGPDFDocumentRef logo = CGPDFDocumentCreateWithURL((CFURLRef)URL);
    CGPDFPageRef page1 = CGPDFDocumentGetPage(logo, 1);
    CGRect logoRect = CGPDFPageGetBoxRect(page1, kCGPDFCropBox);
    CGContextScaleCTM(ctx, rect.size.width / logoRect.size.width, rect.size.height / logoRect.size.height);
    CGContextTranslateCTM(ctx, -logoRect.origin.x, -logoRect.origin.y);
    CGContextDrawPDFPage(ctx, page1);
    CGPDFDocumentRelease(logo);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return image;
    
}

+ (UIImage *)listUI_icon:(ListUIIcon)icon size:(CGFloat)size {
    UIColor *color = [UIColor blackColor];
    return [self listUI_icon:icon size:size color:color];
}
+ (UIImage *)listUI_icon:(ListUIIcon)icon size:(CGFloat)size color:(UIColor *)color {
    
    /*
     * Returns a UIImage representation of an icon.
     */
    
    NSString *str = [NSString listUI_stringForIcon:icon];
    UIFont *font = [UIFont fontWithName:kListUIIconFontName size:size];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{NSFontAttributeName:font,
                                 NSForegroundColorAttributeName:color,
                                 NSBackgroundColorAttributeName:[UIColor clearColor] };
    CGSize imageSize = [str sizeWithAttributes:attributes];
    imageSize = CGSizeMake(imageSize.width, imageSize.height);
    CGRect rect = CGRectZero;
    rect.size = imageSize;
    CGPoint origin = CGPointMake(0, 0);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0f);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    [[UIColor clearColor] setFill];
    [path fill];
    [str drawAtPoint:origin withAttributes:attributes];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}

@end
