//
//  PostEditorView.m
//  List
//
//  Created by Noah Portes Chaikin on 7/7/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PostEditorView.h"
#import "UIColor+List.h"
#import "UIFont+List.h"
#import "UIButton+List.h"
#import "LIconControl.h"

@interface PostEditorView ()

@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) LTextField *titleTextField;
@property (strong, nonatomic) UIView *contentContainer;
@property (strong, nonatomic) LTextView *contentTextView;
@property (strong, nonatomic) UILabel *categoryLabel;
@property (strong, nonatomic) LIconControl *closeControl;
@property (strong, nonatomic) UIView *footerView;
@property (strong, nonatomic) UIButton *cameraButton;
@property (strong, nonatomic) UIView *coverPhotoContainer;
@property (strong, nonatomic) UIImageView *coverPhotoImageView;
@property (strong, nonatomic) UIButton *saveButton;

@end

@implementation PostEditorView

static CGFloat const PostEditorViewPadding = 12.f;
static CGFloat const PostEditorViewAvatarImageViewSize = 45.f;
static CGFloat const PostEditorViewContentContainerHeight = 150.f;
static CGFloat const PostEditorViewCoverPhotoContainerSize = 100.f;

- (instancetype)init {
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    
    /*
     * Gray bg by default.
     */
    
    self.backgroundColor = [UIColor list_lightGrayColorAlpha:1.0f];
    
    /*
     * Add subviews.
     */
    
    [self addSubview:self.headerView];
    [self.headerView addSubview:self.closeControl];
    [self.headerView addSubview:self.avatarImageView];
    [self addSubview:self.titleTextField];
    [self addSubview:self.contentContainer];
    [self.contentContainer addSubview:self.contentTextView];
    [self.contentContainer insertSubview:self.coverPhotoContainer
                            aboveSubview:self.contentTextView];
    [self.coverPhotoContainer addSubview:self.coverPhotoImageView];
    [self.coverPhotoContainer insertSubview:self.cameraButton
                               aboveSubview:self.coverPhotoImageView];
    
    [self addSubview:self.footerView];
    [self.footerView addSubview:self.saveButton];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    x = CGRectGetMinX(self.bounds);
    y = CGRectGetMinY(self.bounds);
    w = CGRectGetWidth(self.bounds);
    h = PostEditorViewAvatarImageViewSize + (PostEditorViewPadding * 2);
    self.headerView.frame = CGRectMake(x, y, w, h);
    
    x = w - (PostEditorViewPadding + PostEditorViewAvatarImageViewSize);
    y = PostEditorViewPadding;
    w = PostEditorViewAvatarImageViewSize;
    h = PostEditorViewAvatarImageViewSize;
    self.closeControl.frame = CGRectMake(x, y, w, h);
    
    x = PostEditorViewPadding;
    self.avatarImageView.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMinX(self.bounds);
    y = CGRectGetMaxY(self.headerView.frame) + 1.0;
    w = CGRectGetWidth(self.bounds);
    h = CGRectGetHeight(self.titleTextField.frame);
    self.titleTextField.frame = CGRectMake(x, y, w, h);
    
    y = CGRectGetMaxY(self.titleTextField.frame) + 1.0f;
    h = PostEditorViewContentContainerHeight;
    self.contentContainer.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMinX(self.contentContainer.bounds) + PostEditorViewPadding;
    y = CGRectGetMinY(self.contentContainer.bounds) + PostEditorViewPadding;
    w = PostEditorViewCoverPhotoContainerSize;
    h = PostEditorViewCoverPhotoContainerSize;
    self.coverPhotoContainer.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMinX(self.coverPhotoContainer.bounds);
    y = CGRectGetMinY(self.coverPhotoContainer.bounds);
    w = CGRectGetWidth(self.coverPhotoContainer.bounds);
    h = CGRectGetHeight(self.coverPhotoContainer.bounds);
    self.coverPhotoImageView.frame = CGRectMake(x, y, w, h);
    
    w = CGRectGetWidth(self.cameraButton.frame);
    h = CGRectGetHeight(self.cameraButton.frame);
    x = CGRectGetMidX(self.coverPhotoContainer.bounds) - (CGRectGetWidth(self.cameraButton.frame) / 2);
    y = CGRectGetMidY(self.coverPhotoContainer.bounds) - (h / 2);
    self.cameraButton.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMinX(self.contentContainer.bounds);
    y = CGRectGetMinY(self.contentContainer.bounds);
    w = CGRectGetWidth(self.contentContainer.bounds);
    h = CGRectGetHeight(self.contentContainer.bounds);
    self.contentTextView.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMinX(self.bounds);
    y = CGRectGetMaxY(self.contentContainer.frame) + 1.0f;
    w = CGRectGetWidth(self.bounds);
    h = CGRectGetHeight(self.saveButton.frame) + (PostEditorViewPadding * 2);
    self.footerView.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetWidth(self.footerView.bounds) - (PostEditorViewPadding + CGRectGetWidth(self.saveButton.frame));
    y = PostEditorViewPadding;
    w = CGRectGetWidth(self.saveButton.frame);
    h = CGRectGetHeight(self.saveButton.frame);
    self.saveButton.frame = CGRectMake(x, y, w, h);
    
    self.contentSize = CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetMaxY(self.footerView.frame) + 1.0f);
}

- (void)dealloc {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self];
}

#pragma mark - Dynamic getters

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] init];
        _headerView.backgroundColor = [UIColor whiteColor];
        _headerView.layer.masksToBounds = YES;
    }
    return _headerView;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] init];
        _footerView.backgroundColor = [UIColor whiteColor];
        _footerView.layer.masksToBounds = YES;
    }
    return _footerView;
}

- (UIView *)coverPhotoContainer {
    if (!_coverPhotoContainer) {
        _coverPhotoContainer = [[UIView alloc] init];
        _coverPhotoContainer.backgroundColor = [UIColor whiteColor];
        _coverPhotoContainer.layer.masksToBounds = YES;
    }
    return _coverPhotoContainer;
}

- (UILabel *)categoryLabel {
    if (!_categoryLabel) {
        _categoryLabel = [[UILabel alloc] init];
        _categoryLabel.textColor = [UIColor whiteColor];
        _categoryLabel.numberOfLines = 1.0f;
        _categoryLabel.font = [UIFont list_postEditorViewHeaderFont];
        _categoryLabel.layer.masksToBounds = YES;
        [_categoryLabel sizeToFit];
    }
    return _categoryLabel;
}

- (UIButton *)cameraButton {
    if (!_cameraButton) {
        _cameraButton = [UIButton list_cameraIconButtonWithSize:25.f
                                                            color:[UIColor list_blueColorAlpha:1.0f]];
    }
    return _cameraButton;
}

- (UIButton *)saveButton {
    if (!_saveButton) {
        _saveButton = [UIButton list_buttonWithSize:UIButtonListSizeMedium
                                                style:UIButtonListStyleBlue];
        [_saveButton setTitle:@"Post"
                     forState:UIControlStateNormal];
        [_saveButton sizeToFit];
    }
    return _saveButton;
}

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.backgroundColor = [UIColor list_lightGrayColorAlpha:1];
        _avatarImageView.layer.cornerRadius = PostEditorViewAvatarImageViewSize / 2;
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _avatarImageView;
}

- (UIImageView *)coverPhotoImageView {
    if (!_coverPhotoImageView) {
        _coverPhotoImageView = [[UIImageView alloc] init];
        _coverPhotoImageView.backgroundColor = [UIColor list_lightGrayColorAlpha:1];
        _coverPhotoImageView.contentMode = UIViewContentModeScaleAspectFill;
        _coverPhotoImageView.layer.masksToBounds = YES;
        _coverPhotoImageView.layer.cornerRadius = 3.f;
    }
    return _coverPhotoImageView;
}

- (LTextField *)titleTextField {
    if (!_titleTextField) {
        _titleTextField = [[LTextField alloc] init];
        _titleTextField.backgroundColor = [UIColor whiteColor];
        _titleTextField.placeholder = @"Title";
        _titleTextField.textInsets = UIEdgeInsetsMake(PostEditorViewPadding, PostEditorViewPadding, PostEditorViewPadding, PostEditorViewPadding);
        [_titleTextField sizeToFit];
    }
    return _titleTextField;
}

- (UIView *)contentContainer {
    if (!_contentContainer) {
        _contentContainer = [[UIView alloc] init];
        _contentContainer.backgroundColor = [UIColor whiteColor];
    }
    return _contentContainer;
}

- (LTextView *)contentTextView {
    if (!_contentTextView) {
        _contentTextView = [[LTextView alloc] init];
        _contentTextView.placeholder = @"Description";
        _contentTextView.textContainerInset = UIEdgeInsetsMake(PostEditorViewPadding, (PostEditorViewPadding * 2) + PostEditorViewCoverPhotoContainerSize, PostEditorViewPadding, PostEditorViewPadding);
    }
    return _contentTextView;
}

- (LIconControl *)closeControl {
    if (!_closeControl) {
        _closeControl = [[LIconControl alloc] initWithStyle:LIconControlStyleRemove];
        _closeControl.lineColor = [UIColor list_blueColorAlpha:1];
    }
    return _closeControl;
}

@end
