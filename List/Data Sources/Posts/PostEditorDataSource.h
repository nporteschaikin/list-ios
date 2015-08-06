//
//  PostEditorDataSource.h
//  List
//
//  Created by Noah Portes Chaikin on 8/2/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostController.h"
#import "ListTextFieldCell.h"
#import "ListTextViewCell.h"
#import "ListPhotoTextFieldCell.h"
#import "ListPhotoTextViewCell.h"
#import "ListGeneralCell.h"

typedef NS_ENUM(NSUInteger, PostEditorDataSourceRows) {
    PostEditorDataSourceRowsTitle = 0,
    PostEditorDataSourceRowsCategory = 1,
    
    PostEditorDataSourceRowsPostContent = 2,
    
    PostEditorDataSourceRowsEventTime = 2,
    PostEditorDataSourceRowsEventPlace = 3,
    PostEditorDataSourceRowsEventContent = 4
};

@interface PostEditorDataSource : NSObject <UITableViewDataSource>

- (instancetype)initWithPostController:(PostController *)postController NS_DESIGNATED_INITIALIZER;
- (void)registerReuseIdentifiersForTableView:(UITableView *)tableView;

@end
