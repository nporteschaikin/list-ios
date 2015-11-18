//
//  PicturesTableViewDelegate.m
//  List
//
//  Created by Noah Portes Chaikin on 11/17/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PicturesTableViewDelegate.h"

@interface PicturesTableViewDelegate ()

@property (strong, nonatomic) PicturesController *picturesController;

@end

@implementation PicturesTableViewDelegate

- (instancetype)initWithPicturesController:(PicturesController *)picturesController {
    if (self = [super init]) {
        self.picturesController = picturesController;
    }
    return self;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    PicturesController *picturesController = self.picturesController;
    NSArray *pictures = picturesController.pictures;
    Picture *picture = pictures[row];
    
    CGFloat height = 0.0f;
    CGFloat width;
    CGRect rect;
    CGSize size;
    
    /*
     * Add avatar height
     */
    
    height += kPicturesTableViewCellSpacing;
    height += kPicturesTableViewCellAvatarViewSize;
    height += kPicturesTableViewCellSpacing;
    
    /*
     * Add asset height.
     */
    
    width = CGRectGetWidth(tableView.bounds);
    height += width;
    height += kPicturesTableViewCellSpacing;
    
    /*
     * Add description height.
     */
    
    width = CGRectGetWidth(tableView.bounds) - (kPicturesTableViewCellSpacing * 2);
    rect = [picture.text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont listFontWithSize:12.f]} context:nil];
    size = rect.size;
    height += size.height;
    height += kPicturesTableViewCellSpacing;
    
    return height + kPicturesTableViewCellSpacing;
}

@end
