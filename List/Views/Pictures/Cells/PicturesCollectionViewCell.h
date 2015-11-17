//
//  PicturesCollectionViewCell.h
//  List
//
//  Created by Noah Portes Chaikin on 9/9/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"
#import "PicturesHeaderView.h"

@interface PicturesCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic, readonly) UIImageView *assetView;
@property (strong, nonatomic, readonly) PicturesHeaderView *headerView;

@end
