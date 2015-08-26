//
//  TagsScrollView.h
//  List
//
//  Created by Noah Portes Chaikin on 8/23/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"

@class TagsScrollView;

@protocol TagsScrollViewDataSource <NSObject>

- (NSString *)tagsScrollView:(TagsScrollView *)view tagAtIndex:(NSInteger)index;
- (NSInteger)numberOfTagsInTagsScrollView:(TagsScrollView *)view;

@end

@protocol TagsScrollViewDelegate <UIScrollViewDelegate>

@optional
- (void)tagsScrollView:(TagsScrollView *)tag didSelectTagAtIndex:(NSInteger)index;
- (void)tagsScrollView:(TagsScrollView *)tag didDeselectTagAtIndex:(NSInteger)index;

@end

@interface TagsScrollView : UIScrollView

@property (weak, nonatomic) id<TagsScrollViewDataSource> dataSource;
@property (weak, nonatomic) id<TagsScrollViewDelegate> delegate;

- (void)selectTagAtIndex:(NSInteger)index;
- (void)deselectTagAtIndex:(NSInteger)index;
- (void)reloadData;

@end
