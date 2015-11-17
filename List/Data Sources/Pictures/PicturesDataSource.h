//
//  PicturesDataSource.h
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"
#import "PicturesController.h"
#import "PicturesCollectionViewCell.h"

@interface PicturesDataSource : NSObject <UICollectionViewDataSource>

- (instancetype)initWithPicturesController:(PicturesController *)picturesController;
- (void)registerReuseIdentifiersForCollectionView:(UICollectionView *)collectionView;

@end
