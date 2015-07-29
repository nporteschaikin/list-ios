//
//  PostEditorViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 7/7/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PostEditorViewController.h"
#import "PostController.h"
#import "ActivityIndicatorView.h"
#import "APIRequest.h"
#import "Constants.h"
#import "UIColor+List.h"
#import "LLocationManager.h"
#import "UIImageView+WebCache.h"

@interface PostEditorViewController () <PostControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) PostEditorView *postEditorView;
@property (strong, nonatomic) UIView *activityOverlay;
@property (strong, nonatomic) ActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) PostController *postController;
@property (strong, nonatomic) UIImagePickerController *imagePickerController;

@end

@implementation PostEditorViewController

- (id)initWithPost:(Post *)post
           session:(Session *)session {
    if (self = [super init]) {
        
        /*
         * Create post controller.
         */
        
        self.postController = [[PostController alloc] initWithPost:post session:session];
        self.postController.delegate = self;
        
    }
    return self;
}

- (void)viewDidLoad {
    
    /*
     * Clear background.
     */
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*
     * Add subviews
     */
    
    [self.view addSubview:self.postEditorView];
    [self.view insertSubview:self.activityOverlay
                aboveSubview:self.postEditorView];
    [self.activityOverlay addSubview:self.activityIndicatorView];
    
    /*
     * Listen to save button.
     */
    
    UIButton *saveButton = self.postEditorView.saveButton;
    [saveButton addTarget:self
                   action:@selector(handleSaveButtonTouchDown:)
         forControlEvents:UIControlEventTouchDown];
    
    /*
     * Listen to close control.
     */
    
    LIconControl *closeControl = self.postEditorView.closeControl;
    [closeControl addTarget:self
                     action:@selector(handleCloseControlTouchDown:)
         forControlEvents:UIControlEventTouchDown];
    
    /*
     * Listen to camera button.
     */
    
    UIButton *cameraButton = self.postEditorView.cameraButton;
    [cameraButton addTarget:self
                     action:@selector(handleCameraButtonTouchDown:)
           forControlEvents:UIControlEventTouchDown];
    
    /*
     * Set up photo button.
     */
    
    PostController *postController = self.postController;
    User *currentUser = postController.session.user;
    if (currentUser.profilePictureURL) {
        [self.postEditorView.avatarImageView sd_setImageWithURL:currentUser.profilePictureURL];
    }
    
    /*
     * Register keyboard notifications.
     */
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(keyboardWillBeShown:)
                          name:UIKeyboardWillShowNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(keyboardWillBeHidden:)
                          name:UIKeyboardWillHideNotification
                        object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /*
     * Start editing title file.d
     */
    
    PostEditorView *postEditorView = self.postEditorView;
    LTextField *titleTextField = postEditorView.titleTextField;
    [titleTextField becomeFirstResponder];
    
}

- (void)dealloc {
    
    /*
     * Remove keyboard notifications
     */
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat x, y, w, h;
    x = CGRectGetMinX( self.view.bounds );
    y = CGRectGetMinY( self.view.bounds );
    w = CGRectGetWidth( self.view.bounds );
    h = CGRectGetHeight( self.view.bounds );
    self.postEditorView.frame = CGRectMake(x, y, w, h);
    self.activityOverlay.frame = CGRectMake(x, y, w, h);
    
    x = ( CGRectGetMidX( self.activityOverlay.bounds ) - ( ActivityIndicatorViewDefaultSize / 2 ) );
    y = ( CGRectGetMidY( self.activityOverlay.bounds ) - ( ActivityIndicatorViewDefaultSize / 2 ) );
    w = ActivityIndicatorViewDefaultSize;
    h = ActivityIndicatorViewDefaultSize;
    self.activityIndicatorView.frame = CGRectMake(x, y, w, h);
}

#pragma mark - Dynamic getters

- (PostEditorView *)postEditorView {
    if (!_postEditorView) {
        _postEditorView = [[PostEditorView alloc] init];
    }
    return _postEditorView;
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

#pragma mark - Button handlers

- (void)handleSaveButtonTouchDown:(UIButton *)saveButton {
    
    /*
     * Update post.
     */
    
    Post *post = self.postController.post;
    post.title = self.postEditorView.titleTextField.text;
    post.content = self.postEditorView.contentTextView.text;
    
    LLocationManager *locationManager = [LLocationManager sharedManager];
    post.location = locationManager.location;
    
    self.activityOverlay.hidden = NO;
    [self.activityIndicatorView startAnimating];
    [self.postController savePost];
    
}

- (void)handleCloseControlTouchDown:(LIconControl *)closeControl {
    
    /*
     * Send delegate message.
     */
    
    [self.delegate postEditorViewControllerDidAskToClose:self];
}

- (void)handleCameraButtonTouchDown:(UIButton *)cameraButton {
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
}

#pragma mark - PostControllerDelegate

- (void)postControllerDidSavePost:(PostController *)postController {
    
    /*
     * Send delegate message.
     */
    
    [self.delegate postEditorViewControllerDidSavePost:self];
    
    /*
     * Hide activity indicator.
     */
    
    self.activityOverlay.hidden = YES;
    [self.activityIndicatorView stopAnimating];
    
}

- (void)postController:(PostController *)postController failedToSavePostWithError:(NSError *)error {
    
    /*
     * Hide activity indicator.
     */
    
    self.activityOverlay.hidden = YES;
    [self.activityIndicatorView stopAnimating];
    
}

- (void)postController:(PostController *)postController failedToSavePostWithResponse:(id<NSObject>)response {
    
    /*
     * Hide activity indicator.
     */
    
    self.activityOverlay.hidden = YES;
    [self.activityIndicatorView stopAnimating];
    
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
     * Save image to post.
     */
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    Post *post = self.postController.post;
    post.coverImage = image;
    
    /*
     * Update post editor view.
     */
    
    UIImageView *imageView = self.postEditorView.coverPhotoImageView;
    imageView.image = image;
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    /*
     * Close image picker.
     */
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

#pragma mark - Keyboard observers

- (void)keyboardWillBeShown:(NSNotification *)notification {
    NSDictionary *info = notification.userInfo;
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    PostEditorView *postEditorView = self.postEditorView;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    postEditorView.contentInset = contentInsets;
    postEditorView.scrollIndicatorInsets = contentInsets;
    
    UIView *activeView;
    for (UIView *view in postEditorView.subviews) {
        if ([view isFirstResponder]) activeView = view;
    }
    
    if (activeView) {
        CGRect aRect = postEditorView.frame;
        aRect.size.height -= kbSize.height;
        if (!CGRectContainsRect(aRect, activeView.frame)) {
            [postEditorView scrollRectToVisible:activeView.frame
                                       animated:YES];
        }
    }
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    PostEditorView *postEditorView = self.postEditorView;
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    postEditorView.contentInset = contentInsets;
    postEditorView.scrollIndicatorInsets = contentInsets;
}

@end
