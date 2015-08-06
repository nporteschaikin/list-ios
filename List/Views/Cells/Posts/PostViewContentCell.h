//
//  PostViewContentCell.h
//  List
//
//  Created by Noah Portes Chaikin on 8/5/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListTableViewCell.h"

static CGFloat const PostViewContentCellPadding = 12.f;

@interface PostViewContentCell : ListTableViewCell

@property (strong, nonatomic, readonly) UILabel *contentLabel;

@end
