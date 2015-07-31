//
//  ListTableViewCell.h
//  List
//
//  Created by Noah Portes Chaikin on 7/31/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ListTableViewCell;

@protocol ListTableViewCellDelegate <NSObject>

@optional
- (void)listTableViewCell:(ListTableViewCell *)cell viewTapped:(UIView *)view point:(CGPoint)point;

@end

@interface ListTableViewCell : UITableViewCell

@property (weak, nonatomic) id<ListTableViewCellDelegate> delegate;
@property (strong, nonatomic) NSIndexPath *indexPath;

@end
