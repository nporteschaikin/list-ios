//
//  ListIconTableViewCell.h
//  List
//
//  Created by Noah Portes Chaikin on 8/5/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListTableViewCell.h"
#import "LIconView.h"

static CGFloat const ListIconTableViewCellPaddingX = 12.f;
static CGFloat const ListIconTableViewCellPaddingY = 12.f;
static CGFloat const ListIconTableViewIconViewSize = 12.f;

@interface ListIconTableViewCell : ListTableViewCell

@property (strong, nonatomic, readonly) UILabel *label;
@property (strong, nonatomic, readonly) LIconView *iconView;

@end
