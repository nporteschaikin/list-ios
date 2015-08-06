//
//  PostHeaderView.h
//  List
//
//  Created by Noah Portes Chaikin on 8/5/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat const PostHeaderViewAvatarImageViewSize = 30.f;
static CGFloat const PostHeaderViewUserNameLabelInset = 10.f;

@interface PostHeaderView : UIView

@property (strong, nonatomic, readonly) UIImageView *avatarImageView;
@property (strong, nonatomic, readonly) UILabel *userNameLabel;
@property (strong, nonatomic, readonly) UILabel *dateLabel;
@property (strong, nonatomic, readonly) UILabel *locationLabel;

@end
