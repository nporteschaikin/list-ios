//
//  UserViewCoverPhotoCell.h
//  List
//
//  Created by Noah Portes Chaikin on 8/5/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListCoverPhotoCell.h"

@interface UserViewCoverPhotoCell : ListCoverPhotoCell

@property (strong, nonatomic, readonly) UIImageView *avatarImageView;
@property (strong, nonatomic, readonly) UILabel *nameLabel;
@property (strong, nonatomic, readonly) UIView *overlayView;

@end
