//
//  EventsCollectionViewCell.h
//  List
//
//  Created by Noah Portes Chaikin on 11/19/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"

static CGFloat const kEventsCollectionViewCellMargin = 12.0f;

@interface EventsCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic, readonly) UIImageView *assetView;
@property (strong, nonatomic, readonly) UILabel *titleLabel;
@property (strong, nonatomic, readonly) UILabel *timeLabel;
@property (strong, nonatomic, readonly) UILabel *descriptionLabel;

@end
