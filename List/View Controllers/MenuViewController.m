//
//  MenuViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 7/21/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuDataSource.h"
#import "UIColor+List.h"
#import "APIRequest.h"
#import "Constants.h"
#import "LLocationManager.h"
#import "Placemark.h"
#import "UIImageView+WebCache.h"
#import "NotificationsViewController.h"
#import "NotificationsController.h"
#import "SettingsTableViewController.h"
#import "UserViewController.h"

@interface MenuViewController () <UITableViewDelegate>

@property (strong, nonatomic) Session *session;
@property (strong, nonatomic) MenuDataSource *dataSource;
@property (strong, nonatomic) LIconControl *closeControl;
@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation MenuViewController

static CGFloat const MenuViewControllerMargin = 12.f;
static CGFloat const MenuViewControllerCircleSize = 45.f;

- (instancetype)initWithSession:(Session *)session {
    if (self = [super init]) {
        self.session = session;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * Create data source.
     */
    
    self.dataSource = [[MenuDataSource alloc] init];
    [self.dataSource registerReuseIdentifiersForTableView:self.tableView];
    
    /*
     * Set up table view.
     */
    
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    /*
     * Set background to clear.
     */
    
    self.view.backgroundColor = [UIColor clearColor];
    
    /*
     * Add subviews.
     */
    
    [self.view addSubview:self.tableView];
    [self.view insertSubview:self.avatarImageView
                aboveSubview:self.tableView];
    [self.view insertSubview:self.closeControl
                aboveSubview:self.tableView];
    
    /*
     * Set avatar image view.
     */
    
    User *user = self.session.user;
    if (user.profilePictureURL) {
        [self.avatarImageView sd_setImageWithURL:user.profilePictureURL];
    }
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat x, y, w, h;
    x = CGRectGetWidth(self.view.bounds) - MenuViewControllerMargin - MenuViewControllerCircleSize;
    y = CGRectGetMinY( [UIScreen mainScreen].applicationFrame ) + MenuViewControllerMargin;
    w = MenuViewControllerCircleSize;
    h = MenuViewControllerCircleSize;
    self.closeControl.frame = CGRectMake(x, y, w, h);
    
    x = MenuViewControllerMargin;
    self.avatarImageView.frame = CGRectMake(x, y, w, h);
    
    x = 0.0f;
    y = 0.0f;
    w = CGRectGetWidth(self.view.bounds);
    h = CGRectGetHeight(self.view.bounds);
    self.tableView.frame = CGRectMake(x, y, w, h);
    
    UIEdgeInsets contentInset = self.tableView.contentInset;
    contentInset.top = CGRectGetMaxY(self.avatarImageView.frame) + (MenuViewControllerMargin * 2);
    self.tableView.contentInset = contentInset;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    static MenuTableViewCell *sizingCell;
    if (!sizingCell) {
        sizingCell = (MenuTableViewCell *)[self.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    return [sizingCell sizeThatFits:CGSizeMake(0, 0)].height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    UIViewController *viewController;
    switch (row) {
        case MenuDataSourceRowsNotifications: {
            
            /*
             * Create notifications controller.
             */
            
            NotificationsController *notificationsController = [[NotificationsController alloc] initWithSession:self.session];
            
            /*
             * Create table view controller.
             */
            
            viewController = [[NotificationsViewController alloc] initWithNotificationsController:notificationsController session:self.session];
            viewController.navigationItem.title = @"Notifications";
            
            break;
        }
            
        case MenuDataSourceRowsProfile: {
            
            /*
             * Create user view controller.
             */
            
            viewController = [[UserViewController alloc] initWithUser:self.session.user
                                                              session:self.session];
            viewController.navigationItem.title = @"Settings";
            
            break;
        }
        case MenuDataSourceRowsSettings: {
            
            /*
             * Create table view controller.
             */
            
            viewController = [[SettingsTableViewController alloc] initWithSession:self.session];
            viewController.navigationItem.title = @"Settings";
            break;
        }
    }
    
    if ([viewController isKindOfClass:[UserViewController class]]) {
        
        /*
         * Present user view controller without navigation controller.
         */
        
        [self presentViewController:viewController
                           animated:YES
                         completion:nil];
        
    } else if (viewController) {
        
        /*
         * Add close button.
         */
        
        viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                                         target:self
                                                                                                         action:@selector(handleNavigationControllerClose:)];
        
        /*
         * Create navigation controller.
         */
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
        
        /*
         * Present navigation controller.
         */
        
        [self presentViewController:navigationController
                           animated:YES
                         completion:nil];
        
        
    }
}

#pragma mark - Bar button item handler

- (void)handleNavigationControllerClose:(id)sender {
    
    /*
     * Close controller.
     */
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    
}

#pragma mark - Dynamic getters

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.backgroundColor = [UIColor list_lightGrayColorAlpha:1];
        _avatarImageView.clipsToBounds = YES;
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.cornerRadius = MenuViewControllerCircleSize / 2;
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _avatarImageView;
}

- (LIconControl *)closeControl {
    if (!_closeControl) {
        _closeControl = [[LIconControl alloc] initWithStyle:LIconControlStyleRemove];
        _closeControl.lineColor = [UIColor whiteColor];
    }
    return _closeControl;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
    }
    return _tableView;
}

@end
