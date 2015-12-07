//
//  EventsCollectionViewCell.h
//  List
//
//  Created by Noah Portes Chaikin on 11/19/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"
#import "EventDateView.h"

static CGFloat const kEventsCollectionViewCellMargin = 12.0f;
static CGFloat const kEventsCollectionViewCellAvatarViewSize = 30.f;

@interface EventsCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic, readonly) UIImageView *assetView;
@property (strong, nonatomic, readonly) UILabel *titleLabel;
@property (strong, nonatomic, readonly) UILabel *timeLabel;
@property (strong, nonatomic, readonly) UILabel *descriptionLabel;
@property (strong, nonatomic, readonly) UIImageView *avatarView;
@property (strong, nonatomic, readonly) UILabel *userNameLabel;
@property (strong, nonatomic, readonly) UILabel *detailsLabel;
@property (strong, nonatomic, readonly) EventDateView *dateView;

@end
