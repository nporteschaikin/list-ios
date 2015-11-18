//
//  PicturesTableViewCell.h
//  List
//
//  Created by Noah Portes Chaikin on 11/17/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"

static CGFloat const kPicturesTableViewCellAvatarViewSize = 25.f;
static CGFloat const kPicturesTableViewCellSpacing = 12.f;

@interface PicturesTableViewCell : UITableViewCell

@property (strong, nonatomic, readonly) UIImageView *assetView;
@property (strong, nonatomic, readonly) UIImageView *avatarView;
@property (strong, nonatomic, readonly) UILabel *userNameLabel;
@property (strong, nonatomic, readonly) UILabel *dateLabel;
@property (strong, nonatomic, readonly) UILabel *descriptionLabel;

@end
