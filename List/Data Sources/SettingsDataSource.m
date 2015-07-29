//
//  SettingsDataSource.m
//  List
//
//  Created by Noah Portes Chaikin on 7/27/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "SettingsDataSource.h"
#import "Constants.h"

@implementation SettingsDataSource

static NSString * const SettingsTableViewCellReuseIdentifier = @"SettingsTableViewCellReuseIdentifier";
static NSString * const SettingsSliderTableViewCellReuseIdentifier = @"SettingsSliderTableViewCellReuseIdentifier";

- (void)registerReuseIdentifiersForTableView:(UITableView *)tableView {
    [tableView registerClass:[SettingsTableViewCell class]
      forCellReuseIdentifier:SettingsTableViewCellReuseIdentifier];
    [tableView registerClass:[SettingsSliderTableViewCell class]
      forCellReuseIdentifier:SettingsSliderTableViewCellReuseIdentifier];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingsTableViewCell *cell;
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    switch (section) {
        case SettingsDataSourceSectionsDiscovery: {
            switch (row) {
                case SettingsDataSourceSectionsDiscoveryRowsRadius: {
                    cell = (SettingsSliderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:SettingsSliderTableViewCellReuseIdentifier];
                    cell.textLabel.text = @"Radius";
                    ((SettingsSliderTableViewCell *)cell).slider.minimumValue = 0.5;
                    ((SettingsSliderTableViewCell *)cell).slider.maximumValue = 20;
                    ((SettingsSliderTableViewCell *)cell).amountMetric = @"miles";
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    float radius = [[userDefaults objectForKey:DiscoveryRadiusInMilesUserDefaultsKey] floatValue];
                    [((SettingsSliderTableViewCell *)cell).slider setValue:radius
                                                                  animated:YES];
                    break;
                }
            }
            break;
        }
        case SettingsDataSourceSectionsUser: {
            switch (row) {
                case SettingsDataSourceSectionsUserRowsSignOut: {
                    cell = [tableView dequeueReusableCellWithIdentifier:SettingsTableViewCellReuseIdentifier];
                    cell.textLabel.text = @"Sign out";
                    break;
                }
            }
            break;
        }
    }
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case SettingsDataSourceSectionsDiscovery: {
            return @"Discovery Preferences";
        }
        case SettingsDataSourceSectionsUser: {
            return @"Account";
        }
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    switch (section) {
        case SettingsDataSourceSectionsDiscovery: {
            return @"Specify the radius, in miles, to include posts from in your feed.";
        }
        case SettingsDataSourceSectionsUser: {
            return nil;
        }
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case SettingsDataSourceSectionsDiscovery: {
            return 1;
        }
        case SettingsDataSourceSectionsUser: {
            return 1;
        }
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

@end
