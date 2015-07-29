//
//  PostsTableViewStatusView.h
//  List
//
//  Created by Noah Portes Chaikin on 7/11/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PostsTableViewStatusViewState) {
    PostsTableViewStatusViewStateLoading,
    PostsTableViewStatusViewStateLoaded,
    PostsTableViewStatusViewStateNoPosts,
    PostsTableViewStatusViewStateAPIRequestFailed,
    PostsTableViewStatusViewStateLocationManagerFailed
};

@interface PostsTableViewStatusView : UIView

@property (nonatomic) PostsTableViewStatusViewState state;

@end
