//
//  PostsSearchBar.h
//  List
//
//  Created by Noah Portes Chaikin on 7/21/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PostsSearchBar;

@protocol PostsSearchBarDelegate <NSObject>

@optional
- (void)postsSearchBarDidChange:(PostsSearchBar *)searchBar;

@end

@interface PostsSearchBar : UIView

@property (weak, nonatomic) id<PostsSearchBarDelegate> delegate;
@property (copy, nonatomic, readonly) NSString *text;

@end
