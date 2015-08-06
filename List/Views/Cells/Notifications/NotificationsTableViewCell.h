//
//  NotificationsTableViewCell.h
//  List
//
//  Created by Noah Portes Chaikin on 7/24/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationsTableViewCell : UITableViewCell

@property (strong, nonatomic, readonly) UIImageView *avatarImageView;
@property (strong, nonatomic, readonly) UILabel *contentLabel;
@property (strong, nonatomic, readonly) UILabel *dateLabel;

@end
