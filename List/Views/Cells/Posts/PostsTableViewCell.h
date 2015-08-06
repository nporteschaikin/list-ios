//
//  PostsTableViewCell.h
//  List
//
//  Created by Noah Portes Chaikin on 8/6/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListTableViewCell.h"
#import "PostHeaderView.h"
#import "PostsTableViewCellDetailsView.h"
#import "ListLabelView.h"

static CGFloat const PostsTableViewCellPadding = 12.f;

@interface PostsTableViewCell : ListTableViewCell

@property (strong, nonatomic, readonly) PostHeaderView *headerView;
@property (strong, nonatomic, readonly) UILabel *titleLabel;
@property (strong, nonatomic, readonly) UILabel *contentLabel;
@property (strong, nonatomic) PostsTableViewCellDetailsView *detailsView;
@property (strong, nonatomic, readonly) ListLabelView *threadsCounterView;

@end
