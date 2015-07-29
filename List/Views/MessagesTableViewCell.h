//
//  MessagesTableViewCell.h
//  List
//
//  Created by Noah Portes Chaikin on 7/28/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessagesTableViewCell : UITableViewCell

@property (strong, nonatomic, readonly) UIImageView *avatarImageView;
@property (strong, nonatomic, readonly) UILabel *dateLabel;
@property (strong, nonatomic, readonly) UILabel *contentLabel;
@property (copy, nonatomic) NSString *userNameString;
@property (copy, nonatomic) NSString *contentString;

@end
