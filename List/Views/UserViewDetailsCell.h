//
//  UserViewDetailsCell.h
//  List
//
//  Created by Noah Portes Chaikin on 7/21/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListTableViewCell.h"

@interface UserViewDetailsCell : ListTableViewCell

@property (strong, nonatomic, readonly) UIImageView *coverPhotoView;
@property (strong, nonatomic, readonly) UIImageView *avatarImageView;
@property (strong, nonatomic, readonly) UILabel *nameLabel;
@property (strong, nonatomic, readonly) UILabel *bioLabel;
@property (strong, nonatomic, readonly) UIButton *button;

@end
