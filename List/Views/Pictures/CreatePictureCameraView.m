//
//  CreatePictureCameraView.m
//  List
//
//  Created by Noah Portes Chaikin on 8/18/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "CreatePictureCameraView.h"
#import "CameraShutterButton.h"

@interface CreatePictureCameraView ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) CameraShutterButton *shutterButton;
@property (strong, nonatomic) UIButton *flipButton;

@end

@implementation CreatePictureCameraView

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
        
        self.shutterButton = [[CameraShutterButton alloc] init];
        [self.shutterButton addTarget:self action:@selector(handleShutterButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:self.shutterButton];
        
        /*
         * Set button params.
         */
        
        UIColor *color = [UIColor whiteColor];
        CGSize shadowOffset = CGSizeZero;
        CGFloat shadowRadius = 3.0f;
        CGFloat shadowOpacity = 0.5f;
        CGColorRef shadowColor = [UIColor listBlackColorAlpha:1].CGColor;
        
        /*
         * Create flip button.
         */
        
        UIImage *flipImage = [UIImage listIcon:ListUIIconFlip size:30.f color:color];
        self.flipButton = [[UIButton alloc] init];
        self.flipButton.layer.shadowOffset = shadowOffset;
        self.flipButton.layer.shadowRadius = shadowRadius;
        self.flipButton.layer.shadowOpacity = shadowOpacity;
        self.flipButton.layer.shadowColor = shadowColor;
        [self.flipButton setImage:flipImage forState:UIControlStateNormal];
        [self.flipButton addTarget:self action:@selector(handleFlipButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
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
    x = CGRectGetWidth(self.bounds) - (size.width + 25.f);
    y = 25.f;
    w = size.width;
    h = size.height;
    self.flipButton.frame = CGRectMake(x, y, w, h);
    
}

#pragma mark - Button handlers

- (void)handleShutterButtonTouchDown:(CameraShutterButton *)shutterButton {
    
    /*
     * Send delegate message.
     */
    
    if ([self.delegate respondsToSelector:@selector(didTouchDownShutterButtonCreatePictureCameraView:)]) {
        [self.delegate didTouchDownShutterButtonCreatePictureCameraView:self];
    }
    
}

- (void)handleFlipButtonTouchDown:(UIButton *)flipButton {
    
    /*
     * Flip state.
     */
    
    flipButton.selected = !flipButton.selected;
    
    /*
     * Send delegate message.
     */
    
    if ([self.delegate respondsToSelector:@selector(createPictureCameraView:flipButtonDidChangeState:)]) {
        [self.delegate createPictureCameraView:self flipButtonDidChangeState:flipButton.state];
    }
    
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
