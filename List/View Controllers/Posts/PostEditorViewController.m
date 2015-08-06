//
//  PostEditorViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 7/7/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PostEditorViewController.h"
#import "PostEditorDataSource.h"
#import "EventEditorViewController.h"
#import "PostController.h"
#import "LLocationManager.h"
#import "UIColor+List.h"
#import "UIImageView+WebCache.h"
#import "ActivityIndicatorOverlay.h"

@interface PostEditorViewController () <UITableViewDelegate, PostControllerDelegate, ListTableViewCellDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) PostController *postController;
@property (strong, nonatomic) Session *session;
@property (strong, nonatomic) PostEditorDataSource *dataSource;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) ActivityIndicatorOverlay *activityIndicatorOverlay;

@end

@implementation PostEditorViewController

- (id)initWithPost:(Post *)post
           session:(Session *)session {
    if (self = [super init]) {
        self.session = session;
        
        /*
         * Create post controller.
         */
        
        self.postController = [[PostController alloc] initWithPost:post session:session];
        self.postController.delegate = self;
        
        /*
         * Create data source.
         */
        
        self.dataSource = [[PostEditorDataSource alloc] initWithPostController:self.postController];
        [self.dataSource registerReuseIdentifiersForTableView:self.tableView];
        
    }
    return self;
}

- (void)viewDidLoad {
    
    /*
     * Set background.
     */
    
    self.view.backgroundColor = [UIColor list_lightGrayColorAlpha:0.75];
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    /*
     * Add subviews.
     */
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.activityIndicatorOverlay];
    
    /*
     * Set up table view.
     */
    
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    self.tableView.separatorColor = [UIColor list_grayColorAlpha:1];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundView = nil;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        self.tableView.layoutMargins = UIEdgeInsetsZero;
    }
    
    /*
     * Set title.
     */
    
    Post *post = self.postController.post;
    switch (post.type) {
        case PostTypeEvent: {
            self.navigationItem.title = @"Event";
            break;
        }
        default: {
            self.navigationItem.title = @"Photo";
            break;
        }
    }
    
    /*
     * Set done.
     */
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                          target:self
                                                                                          action:@selector(handleCancelBarButtonItem:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"List"
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(handleSaveBarButtonItem:)];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat x, y, w, h;
    x = CGRectGetMinX(self.view.bounds);
    y = CGRectGetMinY(self.view.bounds);
    w = CGRectGetWidth(self.view.bounds);
    h = CGRectGetHeight(self.view.bounds);
    self.activityIndicatorOverlay.frame = CGRectMake(x, y, w, h);
    
    x = 0.0f;
    y = 0.0f;
    w = CGRectGetWidth(self.view.bounds);
    h = CGRectGetHeight(self.view.bounds);
    self.tableView.frame = CGRectMake(x, y, w, h);
}

#pragma mark - Bar button system item handlers

- (void)handleCancelBarButtonItem:(UIBarButtonItem *)item {
    
    /*
     * Dismiss.
     */
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)handleSaveBarButtonItem:(UIBarButtonItem *)item {
    
    /*
     * Set post.
     */
    
    Post *post = self.postController.post;
    
    // Title
    ListTextFieldCell *titleCell = (ListTextFieldCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:PostEditorDataSourceRowsTitle inSection:0]];
    post.title = titleCell.textField.text;
    
    switch (post.type) {
        case PostTypeEvent: {
            
            // Event location.
            ListTextFieldCell *locationCell = (ListTextFieldCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:PostEditorDataSourceRowsEventPlace inSection:0]];
            post.event.place = locationCell.textField.text;
            
            // Event content.
            ListTextViewCell *contentCell = (ListTextViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:PostEditorDataSourceRowsEventContent inSection:0]];
            post.content = contentCell.textView.text;
            
            break;
        }
        default: {
            
            // Post content
            ListTextViewCell *contentCell = (ListTextViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:PostEditorDataSourceRowsPostContent inSection:0]];
            post.content = contentCell.textView.text;
            
            break;
        }
    }
    
    /*
     * Set location.
     */
    
    LLocationManager *locationManager = [LLocationManager sharedManager];
    post.location = locationManager.location;
    
    /*
     * Show activity indicator.
     */
    
    self.activityIndicatorOverlay.hidden = NO;
    
    /*
     * Disable right bar button.
     */
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    /*
     * Save.
     */
    
    [self.postController savePost];
    
}

#pragma mark - PostControllerDelegate

- (void)postControllerDidSavePost:(PostController *)postController {
    
    /*
     * Hide activity indicator.
     */
    
    self.activityIndicatorOverlay.hidden = YES;
    
    /*
     * Dismiss controller.
     */
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)postController:(PostController *)postController failedToSavePostWithError:(NSError *)error {
    
    /*
     * Enable right bar button.
     */
    
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    /*
     * Hide activity indicator.
     */
    
    self.activityIndicatorOverlay.hidden = YES;
    
}

- (void)postController:(PostController *)postController failedToSavePostWithResponse:(id<NSObject>)response {
    
    /*
     * Enable right bar button.
     */
    
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    /*
     * Hide activity indicator.
     */
    
    self.activityIndicatorOverlay.hidden = YES;
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Post *post = self.postController.post;
    NSInteger row = indexPath.row;
    if ( row == PostEditorDataSourceRowsTitle ) {
        return 60.f;
    } else if ( (post.type == PostTypeEvent && row == PostEditorDataSourceRowsEventContent)
        || (post.type == PostTypePost && row == PostEditorDataSourceRowsPostContent) ) {
        return 150.f;
    }
    
    return 44.f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(ListTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.delegate = self;
    cell.indexPath = indexPath;
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Post *post = self.postController.post;
    NSInteger row = indexPath.row;
    
    if (post.type == PostTypeEvent && row == PostEditorDataSourceRowsEventTime) {
        
        /*
         * Go to event post time controller.
         */
        
        Event *event = post.event;
        EventEditorViewController *viewController = [[EventEditorViewController alloc] initWithEvent:event];
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
}

#pragma mark - ListTableViewCellDelegate

- (void)listTableViewCell:(ListTableViewCell *)cell viewTapped:(UIView *)view point:(CGPoint)point {
    if ([cell isKindOfClass:[ListPhotoTextViewCell class]]) {
        UIButton *photoButton = ((ListPhotoTextViewCell *)cell).photoButton;
        if (view == photoButton) {
            
            /*
             * Open photo alert.
             */
            
            // Create controller.
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;
            
            // Create alert.
            UIAlertController *alertController = [[UIAlertController alloc] init];
            
            // Add camera type action.
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                    [self presentViewController:imagePickerController animated:YES completion:nil];
                }];
                [alertController addAction:cameraAction];
            }
            
            // Add photo library type action.
            UIAlertAction *libraryAction = [UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:imagePickerController animated:YES completion:nil];
            }];
            [alertController addAction:libraryAction];
            
            // Present alert
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    /*
     * Close image picker.
     */
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    /*
     * Save image to post.
     */
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    Post *post = self.postController.post;
    post.coverImage = image;
    
    /*
     * Update post editor view.
     */
    
    NSIndexPath *indexPath;
    switch (post.type) {
        case PostTypeEvent: {
            indexPath = [NSIndexPath indexPathForItem:PostEditorDataSourceRowsEventContent inSection:0];
            break;
        }
        default: {
            indexPath = [NSIndexPath indexPathForItem:PostEditorDataSourceRowsPostContent inSection:0];
            break;
        }
    }
    ListPhotoTextViewCell *cell = (ListPhotoTextViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    UIImageView *photoView = cell.photoView;
    photoView.image = image;
    
}

#pragma mark - Dynamic getters

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _tableView;
}

- (ActivityIndicatorOverlay *)activityIndicatorOverlay {
    if (!_activityIndicatorOverlay) {
        _activityIndicatorOverlay = [[ActivityIndicatorOverlay alloc] init];
        _activityIndicatorOverlay.hidden = YES;
    }
    return _activityIndicatorOverlay;
}

@end
