//
//  PostViewHeaderCell.h
//  List
//
//  Created by Noah Portes Chaikin on 8/5/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListTableViewCell.h"
#import "PostHeaderView.h"

static CGFloat const PostViewHeaderCellPadding = 12.f;

@interface PostViewHeaderCell : ListTableViewCell

@property (strong, nonatomic, readonly) PostHeaderView *headerView;

@end
