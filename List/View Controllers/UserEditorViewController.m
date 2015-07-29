//
//  UserEditorViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 7/27/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "UserEditorViewController.h"
#import "UserEditorDataSource.h"
#import "UserController.h"
#import "UIColor+List.h"
#import "ActivityIndicatorView.h"
#import "Constants.h"

typedef NS_ENUM(NSUInteger, UserEditorViewControllerImagePickerControllerAttribute) {
    UserEditorViewControllerImagePickerControllerAttributeCoverPhoto = 0,
    UserEditorViewControllerImagePickerControllerAttributeProfilePicture
};

@interface UserEditorViewController () <UserControllerDelegate, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UserController *userController;
@property (strong, nonatomic) UserEditorDataSource *dataSource;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *activityOverlay;
@property (strong, nonatomic) ActivityIndicatorView *activityIndicatorView;
@property (nonatomic) UserEditorViewControllerImagePickerControllerAttribute imagePickerControllerAttribute;

@end

@implementation UserEditorViewController

- (instancetype)initWithUser:(User *)user
                     session:(Session *)session {
    if (self = [super init]) {
        self.userController = [[UserController alloc] initWithUser:user
                                                           session:session];
        self.userController.delegate = self;
        self.dataSource = [[UserEditorDataSource alloc] initWithUserController:self.userController];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * Add subviews.
     */
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.activityIndicatorView];
    
    /*
     * Set up table view.
     */
    
    [self.dataSource registerReuseIdentifiersForTableView:self.tableView];
    self.tableView.dataSource = self.dataSource;
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
     * Add navigation items.
     */
    
    self.navigationItem.title = @"Edit Profile";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                            target:self
                                                                                            action:@selector(handleCancelBarButtonItem:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                           target:self
                                                                                           action:@selector(handleSaveBarButtonItem:)];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat x, y, w, h;
    x = CGRectGetMinX(self.view.bounds);
    y = CGRectGetMinY(self.view.bounds);
    w = CGRectGetWidth(self.view.bounds);
    h = CGRectGetHeight(self.view.bounds);
    self.activityOverlay.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMinX(self.view.bounds);
    y = CGRectGetMinY(self.view.bounds);
    w = CGRectGetWidth(self.view.bounds);
    h = CGRectGetHeight(self.view.bounds);
    self.tableView.frame = CGRectMake(x, y, w, h);
    
    x = ( CGRectGetMidX( self.activityOverlay.bounds ) - ( ActivityIndicatorViewDefaultSize / 2 ) );
    y = ( CGRectGetMidY( self.activityOverlay.bounds ) - ( ActivityIndicatorViewDefaultSize / 2 ) );
    w = ActivityIndicatorViewDefaultSize;
    h = ActivityIndicatorViewDefaultSize;
    self.activityIndicatorView.frame = CGRectMake(x, y, w, h);
}

#pragma mark - UserControllerDelegate

- (void)userControllerDidSaveUser:(UserController *)userController {
    
    /*
     * Dismiss.
     */
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    
    /*
     * Stop indicating activity.
     */
    
    self.activityOverlay.hidden = YES;
    [self.activityIndicatorView stopAnimating];
    
}

- (void)userController:(UserController *)userController failedToSaveUserWithError:(NSError *)error {
    
    /*
     * Stop indicating activity.
     */
    
    self.activityOverlay.hidden = YES;
    [self.activityIndicatorView stopAnimating];
    
}

- (void)userController:(UserController *)userController failedToSaveUserWithResponse:(id<NSObject>)response {
    
    /*
     * Stop indicating activity.
     */
    
    self.activityOverlay.hidden = YES;
    [self.activityIndicatorView stopAnimating];
    
}

#pragma mark - Bar button item handler

- (void)handleSaveBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
    /*
     * Update user.
     */
    
    User *user = self.userController.user;
    NSIndexPath *bioIndexPath = [NSIndexPath indexPathForItem:UserEditorDataSourceSectionsDetailsRowsBio inSection:UserEditorDataSourceSectionsDetails];
    UserEditorTextViewTableViewCell *bioCell = (UserEditorTextViewTableViewCell *)[self.tableView cellForRowAtIndexPath:bioIndexPath];
    user.bio = bioCell.textView.text;
    
    self.activityOverlay.hidden = NO;
    [self.activityIndicatorView startAnimating];
    [self.userController saveUser];
}

- (void)handleCancelBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
    /*
     * Dismiss.
     */
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    /*
     * Close image picker.
     */
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    
    
    /*
     * Save image to user.
     */
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    User *user = self.userController.user;
    
    NSIndexPath *indexPath;
    switch (self.imagePickerControllerAttribute) {
        case UserEditorViewControllerImagePickerControllerAttributeCoverPhoto: {
            user.coverImage = image;
            indexPath = [NSIndexPath indexPathForItem:UserEditorDataSourceSectionsPhotosRowsCoverPhoto inSection:UserEditorDataSourceSectionsPhotos];
            break;
        }
        case UserEditorViewControllerImagePickerControllerAttributeProfilePicture: {
            user.profileImage = image;
            indexPath = [NSIndexPath indexPathForItem:UserEditorDataSourceSectionsPhotosRowsAvatar inSection:UserEditorDataSourceSectionsPhotos];
            break;
        }
    }
    
    /*
     * Update user editor cell view.
     */
    
    UserEditorPhotoTableViewCell *cell = (UserEditorPhotoTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    cell.photoView.image = image;
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    /*
     * Close image picker.
     */
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    switch (section) {
        case UserEditorDataSourceSectionsPhotos: {
            return 60.f;
        }
        case UserEditorDataSourceSectionsDetails: {
            switch (row) {
                case UserEditorDataSourceSectionsDetailsRowsBio: {
                    return 150.f;
                }
            }
        }
    }
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case UserEditorDataSourceSectionsPhotos: {
            return 0.0f;
        }
        case UserEditorDataSourceSectionsDetails: {
            return 12.0f;
        }
    }
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    switch (section) {
        case UserEditorDataSourceSectionsPhotos: {
            switch (row) {
                case UserEditorDataSourceSectionsPhotosRowsAvatar: {
                    self.imagePickerControllerAttribute = UserEditorViewControllerImagePickerControllerAttributeProfilePicture;
                    break;
                }
                case UserEditorDataSourceSectionsPhotosRowsCoverPhoto: {
                    self.imagePickerControllerAttribute = UserEditorViewControllerImagePickerControllerAttributeCoverPhoto;
                    break;
                }
            }
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;
            UIAlertController *alertController = [[UIAlertController alloc] init];
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera"
                                                                       style:UIAlertActionStyleDefault
                                                                     handler:^(UIAlertAction *action) {
                                                                         imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                                                                         [self presentViewController:imagePickerController
                                                                                            animated:YES
                                                                                          completion:nil];
                                                                     }];
                [alertController addAction:cameraAction];
            }
            UIAlertAction *libraryAction = [UIAlertAction actionWithTitle:@"Photo Library"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction *action) {
                                                                      imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                                                      [self presentViewController:imagePickerController
                                                                                         animated:YES
                                                                                       completion:nil];
                                                                  }];
            [alertController addAction:libraryAction];
            [self presentViewController:alertController
                               animated:YES
                             completion:nil];
            break;
        }
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
     * Style cell.
     */
    
    if (indexPath.section == UserEditorDataSourceSectionsDetails) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
    
}

#pragma mark - Dynamic getters

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    }
    return _tableView;
}

- (UIView *)activityOverlay {
    if (!_activityOverlay) {
        _activityOverlay = [[UIView alloc] init];
        _activityOverlay.hidden = YES;
        _activityOverlay.backgroundColor = [UIColor clearColor];
    }
    return _activityOverlay;
}

- (ActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[ActivityIndicatorView alloc] initWithStyle:ActivityIndicatorViewStyleBlue];
    }
    return _activityIndicatorView;
}

@end
