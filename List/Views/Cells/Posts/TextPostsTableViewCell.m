//
//  TextPostsTableViewCell.m
//  List
//
//  Created by Noah Portes Chaikin on 8/6/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "TextPostsTableViewCell.h"
#import "UIFont+List.h"
#import "UIColor+List.h"

@interface TextPostsTableViewCell ()

@end

@implementation TextPostsTableViewCell

- (instancetype)init {
    if (self = [super init]) {
        [self.contentView bringSubviewToFront:self.titleLabel];
        [self.contentView bringSubviewToFront:self.contentLabel];
        
        // set title font
        self.titleLabel.font = [UIFont list_textPostsTableViewCellTitleFont];
        
        // set title color
        self.titleLabel.textColor = [UIColor list_blackColorAlpha:1];
        
        // set content color
        self.contentLabel.textColor = [UIColor list_darkGrayColorAlpha:1];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView bringSubviewToFront:self.titleLabel];
        [self.contentView bringSubviewToFront:self.contentLabel];
        
        // set title font
        self.titleLabel.font = [UIFont list_textPostsTableViewCellTitleFont];
        
        // set title color
        self.titleLabel.textColor = [UIColor list_blackColorAlpha:1];
        
        // set content color
        self.contentLabel.textColor = [UIColor list_lightBlackColorAlpha:1];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    CGSize size;
    
    w = CGRectGetWidth(self.contentView.bounds) - (PostsTableViewCellPadding * 2);
    x = PostsTableViewCellPadding;
    y = CGRectGetMaxY(self.headerView.frame) + (PostsTableViewCellPadding * 2);
    size = [self.titleLabel sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    h = size.height;
    self.titleLabel.frame = CGRectMake(x, y, w, h);
    
    y = y + h + (PostsTableViewCellPadding / 2);
    size = [self.contentLabel sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    h = size.height;
    self.contentLabel.frame = CGRectMake(x, y, w, h);
    
    y = y + h + PostsTableViewCellPadding;
    x = PostsTableViewCellPadding;
    size = [self.threadsCounterView sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    w = size.width;
    h = size.height;
    self.threadsCounterView.frame = CGRectMake(x, y, w, h);
    
}

@end
