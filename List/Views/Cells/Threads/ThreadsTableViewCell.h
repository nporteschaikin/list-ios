//
//  ThreadsTableViewCell.h
//  List
//
//  Created by Noah Portes Chaikin on 7/16/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListTableViewCell.h"

static CGFloat const ThreadsTableViewCellPadding = 12.f;
static CGFloat const ThreadsTableViewCellAvatarImageViewSize = 30.f;

@interface ThreadsTableViewCell : ListTableViewCell

@property (strong, nonatomic, readonly) UIImageView *avatarImageView;
@property (strong, nonatomic, readonly) UILabel *dateLabel;
@property (strong, nonatomic, readonly) UILabel *contentLabel;
@property (copy, nonatomic) NSString *userNameString;
@property (copy, nonatomic) NSString *contentString;

@end
