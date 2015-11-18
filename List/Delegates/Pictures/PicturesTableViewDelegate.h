//
//  PicturesTableViewDelegate.h
//  List
//
//  Created by Noah Portes Chaikin on 11/17/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"
#import "PicturesController.h"
#import "PicturesTableViewCell.h"

@interface PicturesTableViewDelegate : NSObject <UITableViewDelegate>

- (instancetype)initWithPicturesController:(PicturesController *)picturesController;

@end
