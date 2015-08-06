//
//  MenuDataSource.h
//  List
//
//  Created by Noah Portes Chaikin on 7/24/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuTableViewCell.h"

typedef NS_ENUM(NSUInteger, MenuDataSourceRows) {
    MenuDataSourceRowsNotifications = 0,
    MenuDataSourceRowsProfile = 1,
    MenuDataSourceRowsSettings = 2
};

@interface MenuDataSource : NSObject <UITableViewDataSource>

- (void)registerReuseIdentifiersForTableView:(UITableView *)tableView;

@end
