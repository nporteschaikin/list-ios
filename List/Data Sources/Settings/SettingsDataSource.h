//
//  SettingsDataSource.h
//  List
//
//  Created by Noah Portes Chaikin on 7/27/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsTableViewCell.h"
#import "SettingsSliderTableViewCell.h"

typedef NS_ENUM(NSUInteger, SettingsDataSourceSections) {
    SettingsDataSourceSectionsDiscovery = 0,
    SettingsDataSourceSectionsUser
};

typedef NS_ENUM(NSUInteger, SettingsDataSourceSectionsDiscoveryRows) {
    SettingsDataSourceSectionsDiscoveryRowsRadius = 0
};

typedef NS_ENUM(NSUInteger, SettingsDataSourceSectionsUserRows) {
    SettingsDataSourceSectionsUserRowsSignOut = 0
};

@interface SettingsDataSource : NSObject <UITableViewDataSource>

- (void)registerReuseIdentifiersForTableView:(UITableView *)tableView;

@end
