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

- (void)registerReuseIdentifiersForTableView:(UITableView *)tableView {
    [tableView registerClass:[PicturesTableViewCell class] forCellReuseIdentifier:kPicturesTableViewCellReuseIdentifier];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    PicturesController *picturesController = self.picturesController;
    NSArray *pictures = picturesController.pictures;
    Picture *picture = pictures[row];
    PicturesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPicturesTableViewCellReuseIdentifier];
    [cell.assetView sd_setImageWithURL:picture.asset.URL];
    [cell.avatarView sd_setImageWithURL:picture.user.profilePhoto.URL];
    cell.userNameLabel.text = picture.user.displayName;
    cell.descriptionLabel.text = picture.text;
    cell.dateLabel.text = @"3m";
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    PicturesController *picturesController = self.picturesController;
    NSArray *pictures = picturesController.pictures;
    return pictures.count;
}

@end
