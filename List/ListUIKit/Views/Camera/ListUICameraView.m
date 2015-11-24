//
//  ListUICameraView.m
//  List
//
//  Created by Noah Portes Chaikin on 8/18/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUICameraView.h"
#import "UIImage+ListUI.h"
#import "UIColor+ListUI.h"

@interface ListUICameraView ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) ListUICameraShutterButton *shutterButton;
@property (strong, nonatomic) UIButton *flipButton;

@end

@implementation ListUICameraView

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Set defaults.
         */
        
        self.backgroundColor = [UIColor listBlackColorAlpha:1];
        
        /*
         * Create image view.
         */
        
        self.imageView = [[UIImageView alloc] init];
        [self addSubview:self.imageView];
        
        /*
         * Create shutter button.
         */
        
        self.shutterButton = [[ListUICameraShutterButton alloc] init];
        [self addSubview:self.shutterButton];
        
        /*
         * Create flip button.
         */
        
        UIImage *flipImage = [[UIImage listIcon:ListUIIconFlip size:30.f] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.flipButton = [[UIButton alloc] init];
        self.flipButton.tintColor = [UIColor whiteColor];
        [self.flipButton setImage:flipImage forState:UIControlStateNormal];
        [self addSubview:self.flipButton];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    CGSize size;
    x = 0.0f;
    y = 0.0f;
    w = CGRectGetWidth(self.layer.bounds);
    h = CGRectGetHeight(self.layer.bounds);
    self.previewLayer.frame = CGRectMake(x, y, w, h);
    self.imageView.frame = CGRectMake(x, y, w, h);
    
    size = CGSizeMake(CGRectGetHeight(self.bounds) * .12f, CGRectGetHeight(self.bounds) * .12f);
    x = (w - size.width) / 2;
    y = CGRectGetHeight(self.bounds) - (size.height + 25.0f);
    w = size.width;
    h = size.height;
    self.shutterButton.frame = CGRectMake(x, y, w, h);
    
    size = [self.flipButton sizeThatFits:CGSizeZero];
    x = (x - size.width) / 2;
    y = CGRectGetMidY(self.shutterButton.frame) - (size.height / 2);
    w = size.width;
    h = size.height;
    self.flipButton.frame = CGRectMake(x, y, w, h);
    
}

#pragma mark - Dynamic setters

- (void)setPreviewLayer:(AVCaptureVideoPreviewLayer *)previewLayer {
    
    /*
     * If preview layer exists, remove from super-layer.
     */
    
    if (_previewLayer) {
        [_previewLayer removeFromSuperlayer];
    }
    
    /*
     * Set preview layer.
     */
    
    _previewLayer = previewLayer;
    
    /*
     * Add to super layer.
     */
    
    [self.layer insertSublayer:previewLayer atIndex:0];
    
    /*
     * Style layer.
     */
    
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
}

@end
