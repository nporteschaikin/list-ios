//
//  PostsTableViewCell.h
//  List
//
//  Created by Noah Portes Chaikin on 7/1/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListTableViewCell.h"
#import "ThreadsCounterView.h"
#import "PostLocationView.h"

@interface PostsTableViewCell : ListTableViewCell

@property (strong, nonatomic, readonly) UIImageView *avatarImageView;
@property (strong, nonatomic, readonly) UILabel *titleLabel;
@property (strong, nonatomic, readonly) UILabel *userNameLabel;
@property (strong, nonatomic, readonly) UILabel *dateLabel;
@property (strong, nonatomic, readonly) UIImageView *coverPhotoImageView;
@property (strong, nonatomic, readonly) UILabel *contentLabel;
@property (strong, nonatomic, readonly) PostLocationView *postLocationView;
@property (strong, nonatomic, readonly) ThreadsCounterView *threadsCounterView;

@end
