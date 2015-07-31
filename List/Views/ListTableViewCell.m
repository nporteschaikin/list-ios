//
//  ListTableViewCell.m
//  List
//
//  Created by Noah Portes Chaikin on 7/31/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupTapGestureRecognizer];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupTapGestureRecognizer];
    }
    return self;
}

- (void)setupTapGestureRecognizer {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureRecognizer:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    tapGestureRecognizer.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tapGestureRecognizer];
}

- (void)handleTapGestureRecognizer:(UITapGestureRecognizer *)tapGestureRecognizer {
    if ([self.delegate respondsToSelector:@selector(listTableViewCell:viewTapped:)]) {
        CGPoint point = [tapGestureRecognizer locationInView:self];
        UIView *subview = [self hitTest:point withEvent:nil];
        if (subview) {
            [self.delegate listTableViewCell:self viewTapped:subview];
        }
    }
}

@end
