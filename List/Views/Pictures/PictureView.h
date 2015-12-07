//
//  PictureView.h
//  List
//
//  Created by Noah Portes Chaikin on 12/7/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"

static CGFloat const kPictureViewAvatarViewSize = 30.f;
static CGFloat const kPictureViewMargin = 12.f;

@interface PictureView : UIView

@property (strong, nonatomic, readonly) UIImageView *assetView;
@property (strong, nonatomic, readonly) UIImageView *avatarView;
@property (strong, nonatomic, readonly) UILabel *detailsLabel;
@property (strong, nonatomic) NSString *displayName;
@property (strong, nonatomic) NSString *text;

- (void)displayFooter:(BOOL)display animated:(BOOL)animated;

@end
