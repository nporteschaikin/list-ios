//
//  UserEditorDataSource.h
//  List
//
//  Created by Noah Portes Chaikin on 7/28/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserController.h"
#import "ListTextViewCell.h"
#import "ListPhotoCell.h"

typedef NS_ENUM(NSUInteger, UserEditorDataSourceSections) {
    UserEditorDataSourceSectionsPhotos = 0,
    UserEditorDataSourceSectionsDetails
};

typedef NS_ENUM(NSUInteger, UserEditorDataSourceSectionsPhotosRows) {
    UserEditorDataSourceSectionsPhotosRowsAvatar = 0,
    UserEditorDataSourceSectionsPhotosRowsCoverPhoto
};

typedef NS_ENUM(NSUInteger, UserEditorDataSourceSectionsDetailsRows) {
    UserEditorDataSourceSectionsDetailsRowsBio = 0
};

@interface UserEditorDataSource : NSObject <UITableViewDataSource>

@property (strong, nonatomic, readonly) UserController *userController;

- (instancetype)initWithUserController:(UserController *)userController NS_DESIGNATED_INITIALIZER;
- (void)registerReuseIdentifiersForTableView:(UITableView *)tableView;

@end
