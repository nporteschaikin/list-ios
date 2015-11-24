//
//  PicturesCollectionViewCell.h
//  List
//
//  Created by Noah Portes Chaikin on 11/18/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"

static CGFloat const kPicturesCollectionViewCellMargin = 7.f;
static CGFloat const kPicturesCollectionViewCellAvatarViewSize = 30.f;

@interface PicturesCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic, readonly) UIImageView *assetView;
@property (strong, nonatomic, readonly) UILabel *descriptionLabel;
@property (strong, nonatomic, readonly) UIImageView *avatarView;
@property (strong, nonatomic, readonly) UILabel *userNameLabel;
@property (strong, nonatomic, readonly) UILabel *dateLabel;

@end