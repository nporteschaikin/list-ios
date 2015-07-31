//
//  PostViewDetailsCell.h
//  List
//
//  Created by Noah Portes Chaikin on 7/16/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostLocationView.h"

@interface PostViewDetailsCell : UITableViewCell

@property (strong, nonatomic, readonly) UIImageView *coverPhotoView;
@property (strong, nonatomic, readonly) UIImageView *avatarImageView;
@property (strong, nonatomic, readonly) UILabel *titleLabel;
@property (strong, nonatomic, readonly) UILabel *userNameLabel;
@property (strong, nonatomic, readonly) UILabel *dateLabel;
@property (strong, nonatomic, readonly) UILabel *contentLabel;
@property (strong, nonatomic, readonly) PostLocationView *postLocationView;
@property (strong, nonatomic, readonly) UIImageView *listImageView;
@property (nonatomic) BOOL hasCoverPhoto;

@end
