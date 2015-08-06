//
//  SettingsTableViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 7/27/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "SettingsDataSource.h"
#import "ActivityIndicatorView.h"
#import "Constants.h"
#import "UIFont+List.h"

@interface SettingsTableViewController ()

@property (strong, nonatomic) Session *session;
@property (strong, nonatomic) SettingsDataSource *dataSource;
@property (strong, nonatomic) ActivityIndicatorView *activityIndicatorView;

@end

@implementation SettingsTableViewController

- (id)initWithSession:(Session *)session {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        self.session = session;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * Add activity indicator view.
     */
    
    [self.view addSubview:self.activityIndicatorView];
    
    /*
     * Create data source.
     */
    
    self.dataSource = [[SettingsDataSource alloc] init];
    
    /*
     * Set up table view.
     */
    
    self.tableView.dataSource = self.dataSource;
    [self.dataSource registerReuseIdentifiersForTableView:self.tableView];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat x, y, w, h;
    x = (CGRectGetWidth(self.view.bounds) - ActivityIndicatorViewDefaultSize) / 2;
    y = (CGRectGetHeight(self.view.bounds) - ActivityIndicatorViewDefaultSize) / 2;
    w = ActivityIndicatorViewDefaultSize;
    h = ActivityIndicatorViewDefaultSize;
    self.activityIndicatorView.frame = CGRectMake(x, y, w, h);
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    switch (section) {
        case SettingsDataSourceSectionsDiscovery: {
            switch (row) {
                case SettingsDataSourceSectionsDiscoveryRowsRadius: {
                    break;
                }
            }
            break;
        }
        case SettingsDataSourceSectionsUser: {
            switch (row) {
                case SettingsDataSourceSectionsUserRowsSignOut: {
                    
                    /*
                     * Sign user out.
                     */
                    
                    self.activityIndicatorView.hidden = NO;
                    [self.session deauth:^(Session *session) {
                        
                        /*
                         * End activity indicator view.
                         */
                        
                        self.activityIndicatorView.hidden = YES;
                        
                        /*
                         * Dismiss controller.
                         */
                        
                        [self dismissViewControllerAnimated:YES
                                                 completion:nil];
                        
                    } onError:^(NSError *error) {
                        
                        /*
                         * End activity indicator view.
                         */
                        
                        self.activityIndicatorView.hidden = YES;
                        
                    } onFail:^(id<NSObject> body) {
                        
                        /*
                         * End activity indicator view.
                         */
                        
                        self.activityIndicatorView.hidden = YES;
                        
                    }];
                    
                    break;
                }
            }
            break;
        }
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == SettingsDataSourceSectionsDiscovery && indexPath.row == SettingsDataSourceSectionsDiscoveryRowsRadius) {
        [((SettingsSliderTableViewCell *)cell).slider addTarget:self
                                                         action:@selector(handleDiscoveryRadiusValueChanged:)
                                               forControlEvents:UIControlEventValueChanged];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.font = [UIFont list_settingsTableViewSectionHeaderFont];
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *footer = (UITableViewHeaderFooterView *)view;
    footer.textLabel.font = [UIFont list_settingsTableViewSectionFooterFont];
}

#pragma mark - Handle radius slider change.

- (void)handleDiscoveryRadiusValueChanged:(UISlider *)slider {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSString stringWithFormat:@"%f", slider.value]
                     forKey:DiscoveryRadiusInMilesUserDefaultsKey];
}

#pragma mark - Dynamic getters

- (ActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[ActivityIndicatorView alloc] initWithStyle:ActivityIndicatorViewStyleBlue];
        _activityIndicatorView.hidden = YES;
    }
    return _activityIndicatorView;
}

@end
