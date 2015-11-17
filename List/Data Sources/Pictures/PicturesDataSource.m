//
//  PicturesDataSource.m
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PicturesDataSource.h"
#import "UIImageView+WebCache.h"

@interface PicturesDataSource ()

@property (strong, nonatomic) PicturesController *picturesController;

@end

@implementation PicturesDataSource

static NSString * const kPicturesCollectionViewCellReuseIdentifier = @"kPicturesCollectionViewCellReuseIdentifier";

- (instancetype)initWithPicturesController:(PicturesController *)picturesController {
    if (self = [super init]) {
        self.picturesController = picturesController;
    }
    return self;
}

- (void)registerReuseIdentifiersForCollectionView:(UICollectionView *)collectionView {
    [collectionView registerClass:[PicturesCollectionViewCell class] forCellWithReuseIdentifier:kPicturesCollectionViewCellReuseIdentifier];
}

#pragma mark - UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    PicturesController *picturesController = self.picturesController;
    NSArray *pictures = picturesController.pictures;
    Picture *picture = pictures[row];
    PicturesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPicturesCollectionViewCellReuseIdentifier forIndexPath:indexPath];
    cell.headerView.userNameLabel.text = picture.user.displayName;
    cell.headerView.placemarkTitleLabel.text = picture.placemark.title;
    [cell.assetView sd_setImageWithURL:picture.asset.URL];
    [cell.headerView.avatarImageView sd_setImageWithURL:picture.user.profilePhoto.URL];
    [cell.headerView setNeedsLayout];
    [cell.headerView layoutIfNeeded];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    PicturesController *picturesController = self.picturesController;
    NSArray *pictures = picturesController.pictures;
    return pictures.count;
}

@end
