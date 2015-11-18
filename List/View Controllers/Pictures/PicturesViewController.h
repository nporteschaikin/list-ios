//
//  PicturesViewController.h
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"
#import "PicturesController.h"
#import "Session.h"

@interface PicturesViewController : ListUIViewController <UICollectionViewDelegate, PicturesControllerDelegate>

@property (strong, nonatomic, readonly) PicturesController *picturesController;
@property (strong, nonatomic, readonly) Session *session;
@property (strong, nonatomic, readonly) UICollectionView *collectionView;

- (instancetype)initWithSession:(Session *)session;

@end
