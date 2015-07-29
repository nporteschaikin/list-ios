//
//  MenuDataSource.m
//  List
//
//  Created by Noah Portes Chaikin on 7/24/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "MenuDataSource.h"

@implementation MenuDataSource

static NSString * const MenuTableViewCellReuseIdentifier = @"MenuTableViewCellReuseIdentifier";

- (void)registerReuseIdentifiersForTableView:(UITableView *)tableView {
    [tableView registerClass:[MenuTableViewCell class]
      forCellReuseIdentifier:MenuTableViewCellReuseIdentifier];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MenuTableViewCellReuseIdentifier];
    switch (row) {
        case MenuDataSourceRowsNotifications: {
            cell.titleLabel.text = @"Notifications";
            break;
        }
        case MenuDataSourceRowsProfile: {
            cell.titleLabel.text = @"Profile";
            break;
        }
        case MenuDataSourceRowsSettings: {
            cell.titleLabel.text = @"Settings";
            break;
        }
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end
