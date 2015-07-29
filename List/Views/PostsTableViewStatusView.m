//
//  PostsTableViewStatusView.m
//  List
//
//  Created by Noah Portes Chaikin on 7/11/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PostsTableViewStatusView.h"
#import "ActivityIndicatorView.h"
#import "Constants.h"
#import "UIColor+List.h"
#import "UIFont+List.h"

@interface PostsTableViewStatusView ()

@property (strong, nonatomic) ActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) UILabel *messageLabel;

@end

@implementation PostsTableViewStatusView

static CGFloat const PostsTableViewStatusViewActivityIndicatorSize = 25.f;
static CGFloat const PostsTableViewStatusViewMargin = 50.f;

- (instancetype)init {
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    
    /*
     * Set background to gray.
     */
    
    self.backgroundColor = [UIColor list_lightGrayColorAlpha:1];
    
    /*
     * Add subviews.
     */
    
    [self addSubview:self.activityIndicatorView];
    [self addSubview:self.messageLabel];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    x = CGRectGetMidX(self.bounds) - (PostsTableViewStatusViewActivityIndicatorSize / 2);
    y = PostsTableViewStatusViewMargin;
    w = PostsTableViewStatusViewActivityIndicatorSize;
    h = PostsTableViewStatusViewActivityIndicatorSize;
    self.activityIndicatorView.frame = CGRectMake(x, y, w, h);
    
    w = CGRectGetWidth(self.bounds) - (PostsTableViewStatusViewMargin * 2);
    self.messageLabel.preferredMaxLayoutWidth = w;
    x = CGRectGetMidX(self.bounds) - (w / 2);
    h = [self.messageLabel sizeThatFits:CGSizeMake(w, 0.0f)].height;
    y = CGRectGetMidY(self.bounds) - (h / 2);
    self.messageLabel.frame = CGRectMake(x, y, w, h);
}

- (ActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[ActivityIndicatorView alloc] initWithStyle:ActivityIndicatorViewStyleBlue];
    }
    return _activityIndicatorView;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.font = [UIFont list_postsTableViewStatusMessageFont];
        _messageLabel.textColor = [UIColor list_blackColorAlpha:0.5f];
        _messageLabel.numberOfLines = 0;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _messageLabel;
}

- (void)setState:(PostsTableViewStatusViewState)state {
    _state = state;
    switch (state) {
        case PostsTableViewStatusViewStateLoading: {
            self.hidden = NO;
            [self.activityIndicatorView startAnimating];
            break;
        }
        case PostsTableViewStatusViewStateLoaded: {
            self.hidden = YES;
            [self.activityIndicatorView stopAnimating];
            break;
        }
        case PostsTableViewStatusViewStateAPIRequestFailed: {
            self.hidden = NO;
            [self.activityIndicatorView stopAnimating];
            self.messageLabel.text = @"We couldn't download posts in your area.  Are you connected to the Internet?";
            [self setNeedsLayout];
            [self layoutIfNeeded];
            break;
        }
        case PostsTableViewStatusViewStateLocationManagerFailed: {
            self.hidden = NO;
            [self.activityIndicatorView stopAnimating];
            self.messageLabel.text = @"We couldn't find your location.  Ensure that location services are turned on.";
            [self setNeedsLayout];
            [self layoutIfNeeded];
            break;
        }
        case PostsTableViewStatusViewStateNoPosts: {
            self.hidden = NO;
            [self.activityIndicatorView stopAnimating];
            self.messageLabel.text = @"There are no posts here.";
            [self setNeedsLayout];
            [self layoutIfNeeded];
        }
    }
}

@end
