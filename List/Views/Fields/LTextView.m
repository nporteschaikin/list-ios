//
//  LTextView.m
//  List
//
//  Created by Noah Portes Chaikin on 7/8/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "LTextView.h"
#import "UIFont+List.h"
#import "UIColor+List.h"

@implementation LTextView

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Default font size.
         */
        
        self.font = [UIFont list_lTextViewFont];
        
        /*
         * Add notifications
         */
        
        NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
        [defaultCenter addObserver:self
                          selector:@selector(textViewTextDidChange:)
                              name:UITextViewTextDidChangeNotification
                            object:self];
        
        /*
         * Re-draw on relayout
         */
        
        self.contentMode = UIViewContentModeRedraw;
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    /*
     * If there is no text, draw placeholder.
     */
    
    if (self.text.length == 0) {
        UIColor *color = [UIColor list_darkGrayColorAlpha:1];
        NSDictionary *attributes = @{ NSFontAttributeName:self.font,
                                      NSForegroundColorAttributeName:color };
        CGFloat x, y, w, h;
        x = self.textContainerInset.left + 5.f;
        y = self.textContainerInset.top;
        w = rect.size.width - (x + self.textContainerInset.right);
        h = self.font.lineHeight;
        CGRect frame = CGRectMake(x, y, w, h);
        [self.placeholder drawInRect:frame
                      withAttributes:attributes];
    }
}

- (void)dealloc {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self];
}

#pragma mark - Observers

- (void)textViewTextDidChange:(NSNotification *)notification {
    [self setNeedsDisplay];
}

@end
