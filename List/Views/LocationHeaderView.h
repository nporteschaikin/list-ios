//
//  LocationHeaderView.h
//  List
//
//  Created by Noah Portes Chaikin on 7/30/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "HeaderView.h"

@class LocationHeaderView;

@protocol LocationHeaderViewDataSource

- (NSString *)locationHeaderViewTitle:(LocationHeaderView *)locationHeaderView;
- (NSString *)locationHeaderView:(LocationHeaderView *)locationHeaderView controlTitleAtIndex:(NSInteger)index;
- (NSInteger)numberOfControlsInLocationHeaderView:(LocationHeaderView *)locationHeaderView;

@end

@protocol LocationHeaderViewDelegate <NSObject>

@optional
- (void)locationHeaderView:(LocationHeaderView *)locationHeaderView didSelectControlAtIndex:(NSInteger)index;

@end

@interface LocationHeaderView : HeaderView

@property (weak, nonatomic) id<LocationHeaderViewDataSource> dataSource;
@property (weak, nonatomic) id<LocationHeaderViewDelegate> delegate;
@property (nonatomic, readonly) NSInteger selectedIndex;

- (void)reloadData;
- (void)reloadTitle;
- (void)reloadControls;
- (void)animateTitleView:(BOOL)animate;

@end
