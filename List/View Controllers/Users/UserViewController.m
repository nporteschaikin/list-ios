//
//  UserViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 7/21/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "UserViewController.h"
#import "PostViewController.h"
#import "PostsTableViewDelegate.h"
#import "UserDataSource.h"
#import "LIconControl.h"
#import "Constants.h"
#import "UserViewController.h"
#import "UserController.h"
#import "UserEditorViewController.h"
#import "UIColor+List.h"
#import "UIFont+List.h"

@interface UserViewController () <UITableViewDelegate, UserControllerDelegate, PostsControllerDelegate, ListTableViewCellDelegate>

@property (strong, nonatomic) UserController *userController;
@property (strong, nonatomic) PostsController *postsController;
@property (strong, nonatomic) PostsTableViewDelegate *postsDelegate;
@property (strong, nonatomic) Session *session;
@property (strong, nonatomic) UserDataSource *dataSource;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) LIconControl *closeControl;

@end

@implementation UserViewController

static CGFloat const UserViewControllerCloseControlSize = 40.f;
static CGFloat const UserViewControllerCloseControlMargin = 12.f;

- (id)initWithUser:(User *)user
           session:(Session *)session {
    if (self = [super init]) {
        
        /*
         * Set session.
         */
        
        self.session = session;
        
        /*
         * Create user controller.
         */
        
        self.userController = [[UserController alloc] initWithUser:user
                                                           session:session];
        self.userController.delegate = self;
        
        /*
         * Create post controller.
         */
        
        self.postsController = [[PostsController alloc] initWithSession:session];
        self.postsController.user = user;
        self.postsController.delegate = self;
        
        /*
         * Create data source.
         */
        
        self.dataSource = [[UserDataSource alloc] initWithUserController:self.userController
                                                         postsController:self.postsController];
        
        /*
         * Create posts delegate.
         */
        
        self.postsDelegate = [[PostsTableViewDelegate alloc] initWithPostsController:self.postsController];
        self.postsDelegate.viewController = self;
        self.postsDelegate.session = session;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * White background.
     */
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*
     * Add subviews.
     */
    
    [self.view addSubview:self.tableView];
    [self.view insertSubview:self.closeControl
                aboveSubview:self.tableView];
    
    /*
     * Add data source to table view.
     */
    
    self.tableView.dataSource = self.dataSource;
    [self.dataSource registerReuseIdentifiersForTableView:self.tableView];
    
    /*
     * Setup table view.
     */
    
    self.tableView.delegate = self;
    self.tableView.separatorColor = [UIColor list_grayColorAlpha:1];
    self.tableView.backgroundColor = [UIColor list_lightGrayColorAlpha:1];
    self.tableView.backgroundView = nil;
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        self.tableView.layoutMargins = UIEdgeInsetsZero;
    }
    
    /*
     * Handle close control.
     */
    
    [self.closeControl addTarget:self
                          action:@selector(handleCloseControlTouchDown:)
                forControlEvents:UIControlEventTouchDown];
    
    /*
     * Perform request.
     */
    
    [self performRequest];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /*
     * Reload.
     */
    
    [self.tableView reloadData];
    
}

- (void)performRequest {

    /*
     * Perform request with data source.
     */
    
    [self.postsController requestPosts];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat x, y, w, h;
    x = CGRectGetMinX(self.view.bounds);
    y = CGRectGetMinY(self.view.bounds);
    w = CGRectGetWidth(self.view.bounds);
    h = CGRectGetHeight(self.view.bounds);
    self.tableView.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.view.bounds) - UserViewControllerCloseControlSize - UserViewControllerCloseControlMargin;
    y = CGRectGetMinY( [UIScreen mainScreen].applicationFrame ) + UserViewControllerCloseControlMargin;
    w = UserViewControllerCloseControlSize;
    h = UserViewControllerCloseControlSize;
    self.closeControl.frame = CGRectMake(x, y, w, h);
}

#pragma mark - UserControllerDelegate

- (void)userControllerDidFetchUser:(UserController *)userController {
    
    /*
     * Refresh user.
     */
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:UserDataSourceSectionDetails]
                  withRowAnimation:UITableViewRowAnimationNone];
    
}

#pragma mark - PostControllerDelegate

- (void)postsControllerDidFetchPosts:(PostsController *)postController {
    
    /*
     * Refresh posts.
     */
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:UserDataSourceSectionPosts]
                  withRowAnimation:UITableViewRowAnimationFade];
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    User *user = self.userController.user;
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    CGFloat width = CGRectGetWidth(tableView.bounds);
    CGFloat height = 0.0f;
    CGFloat w;
    CGSize size;
    CGRect rect;
    NSString *string;
    UIFont *font;
    switch (section) {
        case UserDataSourceSectionDetails: {
            switch (row) {
                case UserDataSourceRowCoverPhoto: {
                    
                    /*
                     * Header row.
                     */
                    
                    return width * CoverPhotoHeightMultiplier;
                }
                case UserDataSourceRowBio: {
                    
                    /*
                     * Bio row.
                     */
                    
                    height += UserViewBioCellPadding;
                    string = user.bio;
                    w = width - (UserViewBioCellPadding * 2);
                    size = CGSizeMake(w, CGFLOAT_MAX);
                    font = [UIFont list_userViewBioCellFont];
                    rect = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName: font } context:nil];
                    height += rect.size.height;
                    height += UserViewBioCellPadding;
                    return height;
                    
                }
            }
        }
        case UserDataSourceSectionPosts: {
            
            /*
             * Post rows.
             */
            
            return [self.postsDelegate tableView:tableView heightForRowAtIndexPath:indexPath];
            
        }
    }
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(ListTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.delegate = self;
    cell.indexPath = indexPath;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case UserDataSourceSectionPosts: {
            return 20.0f;
        }
        default: {
            return 0.0f;
        }
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint contentOffset = scrollView.contentOffset;
    CGFloat Y = contentOffset.y;
    
    if (Y < 0) {
        
        /*
         * Stretch cover photo.
         */
        
        UserViewCoverPhotoCell *cell = (UserViewCoverPhotoCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        UIImageView *photoView = cell.photoView;
        CGRect frame = photoView.frame;
        frame.origin.y = Y;
        frame.size.height = (frame.size.width * CoverPhotoHeightMultiplier) + fabs(Y);
        photoView.frame = frame;
        cell.overlayView.frame = frame;
    }
    
    /*
     * Move close control
     */
    
    LIconControl *closeControl = self.closeControl;
    CGRect frame = closeControl.frame;
    frame.origin.y = (CGRectGetMinY( [UIScreen mainScreen].applicationFrame ) + UserViewControllerCloseControlMargin) - (Y > 0 ? Y : 0);
    closeControl.frame = frame;
    
}

#pragma mark - Close control handler

- (void)handleCloseControlTouchDown:(LIconControl *)closeControl {
    
    /*
     * Dismiss.
     */
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    
}

#pragma mark - Dynamic getters

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
    }
    return _tableView;
}

- (LIconControl *)closeControl {
    if (!_closeControl) {
        _closeControl = [[LIconControl alloc] initWithStyle:LIconControlStyleRemove];
        _closeControl.lineColor = [UIColor whiteColor];
    }
    return _closeControl;
}

@end
