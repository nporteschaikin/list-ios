//
//  PicturesDataSource.h
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"
#import "PicturesController.h"
#import "PicturesPhotosViewCell.h"

@interface PicturesDataSource : NSObject <ListUIPhotosViewDataSource>

- (instancetype)initWithPicturesController:(PicturesController *)picturesController NS_DESIGNATED_INITIALIZER;

@end
