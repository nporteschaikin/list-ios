//
//  ListPhotoTextViewCell.h
//  List
//
//  Created by Noah Portes Chaikin on 8/2/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListTextViewCell.h"

@interface ListPhotoTextViewCell : ListTextViewCell

@property (strong, nonatomic, readonly) UIImageView *photoView;
@property (strong, nonatomic, readonly) UIButton *photoButton;

@end
