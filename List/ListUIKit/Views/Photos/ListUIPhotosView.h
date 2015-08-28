//
//  ListUIPhotosView.h
//  List
//
//  Created by Noah Portes Chaikin on 8/25/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIPhotosViewCell.h"

@class ListUIPhotosView;

@protocol ListUIPhotosViewDelegate <UIScrollViewDelegate>
@end

@protocol ListUIPhotosViewDataSource <NSObject>

- (ListUIPhotosViewCell *)photosView:(ListUIPhotosView *)scrollView cellForRowAtIndex:(NSInteger)index;
- (NSInteger)numberOfRowsInPhotosView:(ListUIPhotosView *)photosView;

@end

@interface ListUIPhotosView : UIScrollView

@property (weak, nonatomic) id<ListUIPhotosViewDelegate> delegate;
@property (weak, nonatomic) id<ListUIPhotosViewDataSource> dataSource;
@property (nonatomic) CGFloat collapsedHeight;
@property (nonatomic) CGFloat expandedHeight;
@property (nonatomic) CGFloat mininumAlpha;
@property (nonatomic) CGFloat maximumAlpha;

- (void)reloadData;

@end
