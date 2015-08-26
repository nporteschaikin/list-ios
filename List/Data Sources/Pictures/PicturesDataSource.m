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

static NSString * const kPicturesTableViewCellReuseIdentifier = @"kPicturesTableViewCellReuseIdentifier";

- (instancetype)initWithPicturesController:(PicturesController *)picturesController {
    if (self = [super init]) {
        self.picturesController = picturesController;
    }
    return self;
}

#pragma mark - ListUIPhotosViewDataSource

- (ListUIPhotosViewCell *)photosView:(ListUIPhotosView *)scrollView cellForRowAtIndex:(NSInteger)index {
    PicturesPhotosViewCell *cell = [[PicturesPhotosViewCell alloc] init];
    PicturesController *picturesController = self.picturesController;
    NSArray *pictures = picturesController.pictures;
    Picture *picture = pictures[index];
    cell.headerView.userNameLabel.text = picture.user.displayName;
    cell.headerView.placemarkTitleLabel.text = picture.placemark.title;
    [cell.imageView sd_setImageWithURL:picture.asset.URL];
    [cell.headerView.avatarImageView sd_setImageWithURL:picture.user.profilePhoto.URL];
    return cell;
}

- (NSInteger)numberOfRowsInPhotosView:(ListUIPhotosView *)photosView {
    PicturesController *picturesController = self.picturesController;
    NSArray *pictures = picturesController.pictures;
    return pictures.count;
}

@end
