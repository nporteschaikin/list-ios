//
//  PictureView.m
//  List
//
//  Created by Noah Portes Chaikin on 12/7/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PictureView.h"

@interface PictureView ()

@property (strong, nonatomic) UIImageView *assetView;
@property (strong, nonatomic) UIView *footerView;
@property (strong, nonatomic) CAGradientLayer *footerGradient;
@property (strong, nonatomic) UIImageView *avatarView;
@property (strong, nonatomic) UILabel *detailsLabel;
@property (strong, nonatomic) UILabel *textLabel;

@end

@implementation PictureView

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Set defaults.
         */
        
        self.backgroundColor = [UIColor listUI_blackColorAlpha:1.0f];
        
        /*
         * Create subviews.
         */
        
        UIImageView *assetView = self.assetView = [[UIImageView alloc] init];
        assetView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:assetView];
        
        UIView *footerView = self.footerView = [[UIView alloc] init];
        [self addSubview:footerView];
        
        CAGradientLayer *footerGradient = self.footerGradient = [[CAGradientLayer alloc] init];
        footerGradient.colors = @[ (id)[UIColor clearColor].CGColor, (id)[UIColor listUI_blackColorAlpha:0.75f].CGColor ];
        footerGradient.locations = @[ @0, @1 ];
        [footerView.layer insertSublayer:footerGradient atIndex:0];
        
        UIImageView *avatarView = self.avatarView = [[UIImageView alloc] init];
        avatarView.clipsToBounds = YES;
        avatarView.layer.cornerRadius = kPictureViewAvatarViewSize / 2;
        [footerView addSubview:avatarView];
        
        UILabel *textLabel = self.textLabel = [[UILabel alloc] init];
        textLabel.numberOfLines = 0;
        [footerView addSubview:textLabel];
        
        UILabel *detailsLabel = self.detailsLabel = [[UILabel alloc] init];
        detailsLabel.numberOfLines = 1;
        detailsLabel.font = [UIFont listUI_fontWithSize:11.f];
        detailsLabel.textColor = [UIColor listUI_grayColorAlpha:1.0f];
        [footerView addSubview:detailsLabel];
        
        /*
         * Hide footer to start.
         */
        
        [self displayFooter:NO animated:NO];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    CGSize size;
    x = 0.0f;
    y = 0.0f;
    w = CGRectGetWidth(self.bounds);
    h = CGRectGetHeight(self.bounds);
    self.assetView.frame = CGRectMake(x, y, w, h);
    
    x = (kPictureViewMargin * 2) + kPictureViewAvatarViewSize;
    y = kPictureViewMargin;
    w = w - ((kPictureViewMargin * 3) + kPictureViewAvatarViewSize);
    size = [self.textLabel sizeThatFits:CGSizeMake(w, CGFLOAT_MIN)];
    h = size.height;
    self.textLabel.frame = CGRectMake(x, y, w, h);
    
    y += h;
    h = self.detailsLabel.font.lineHeight;
    self.detailsLabel.frame = CGRectMake(x, y, w, h);
    
    x = kPictureViewMargin;
    y = kPictureViewMargin;
    w = kPictureViewAvatarViewSize;
    h = kPictureViewAvatarViewSize;
    self.avatarView.frame = CGRectMake(x, y, w, h);
    
    w = CGRectGetWidth(self.bounds);
    h = fmaxf(CGRectGetHeight(self.textLabel.frame) + CGRectGetHeight(self.detailsLabel.frame), kPictureViewAvatarViewSize) + (kPictureViewMargin * 2);
    x = 0.0f;
    y = CGRectGetHeight(self.bounds) - h;
    self.footerView.frame = CGRectMake(x, y, w, h);
    
    x = 0.0f;
    y = 0.0f;
    self.footerGradient.frame = CGRectMake(x, y, w, h);
    
}

- (void)updateTextLabel {
    
    /*
     * Return if we don't have both.
     */
    
    if (!self.displayName || !self.text) return;
    
    /*
     * Create attributed string.
     */
    
    NSAttributedString *displayName = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ", self.displayName] attributes:@{NSFontAttributeName: [UIFont listUI_semiboldFontWithSize:12.f], NSForegroundColorAttributeName: [UIColor whiteColor]}];
    NSAttributedString *text = [[NSAttributedString alloc] initWithString:self.text attributes:@{NSFontAttributeName: [UIFont listUI_fontWithSize:12.f], NSForegroundColorAttributeName: [UIColor whiteColor]}];;
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:displayName];
    [attributedText appendAttributedString:text];
    
    /*
     * Set attributed string to
     * text label.
     */
    
    self.textLabel.attributedText = attributedText;
    
    /*
     * Re-layout.
     */
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
}

- (void)displayFooter:(BOOL)display animated:(BOOL)animated {
    
    /*
     * Display or hide footer view.
     */
    
    void (^animateBlock)(void) = ^void(void) {
        UIView *footerView = self.footerView;
        footerView.alpha = display ? 1.0f : 0.0f;
    };
    void (^completeBlock)(BOOL) = ^void(BOOL finished) {
        // nothing yet.
    };
    if (animated) {
        [UIView animateWithDuration:0.25f animations:animateBlock completion:completeBlock];
        return;
    }
    animateBlock();
    completeBlock(YES);
    
}

#pragma mark - Touch handler

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    /*
     * Toggle footer view.
     */
    
    UIView *footerView = self.footerView;
    CGFloat alpha = footerView.alpha;
    [self displayFooter:alpha < 1 ? YES : NO animated:YES];
    
}

#pragma mark - Dynamic setters

- (void)setDisplayName:(NSString *)displayName {
    
    /*
     * Store variable.
     */
    
    _displayName = displayName;
    
    /*
     * Update text label.
     */
    
    [self updateTextLabel];
    
}

- (void)setText:(NSString *)text {
    
    /*
     * Store variable.
     */
    
    _text = text;
    
    /*
     * Update text label.
     */
    
    [self updateTextLabel];
    
}

@end
