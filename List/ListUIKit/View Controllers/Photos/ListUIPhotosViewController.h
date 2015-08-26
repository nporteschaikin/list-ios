//
//  ListUIPhotosViewController.h
//  List
//
//  Created by Noah Portes Chaikin on 8/25/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIViewController.h"
#import "ListUIPhotosView.h"

@interface ListUIPhotosViewController : ListUIViewController <ListUIPhotosViewDataSource, ListUIPhotosViewDelegate>

@property (strong, nonatomic, readonly) ListUIPhotosView *photosView;

@end
