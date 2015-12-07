//
//  EventEditorViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "EventEditorViewController.h"
#import "EventEditorDataSource.h"
#import "EventController.h"
#import "ClearNavigationBar.h"
#import "BlackNavigationBar.h"
#import "ListConstants.h"
#import "DatePickerModalViewController.h"
#import "LocationPickerViewController.h"
#import "NavigationBarRoundedButton.h"

@interface EventEditorViewController () <EventControllerDelegate, ListUICameraViewControllerDelegate, UIImagePickerControllerDelegate,
    UINavigationControllerDelegate, DatePickerModalViewControllerDelegate, LocationPickerViewControllerDelegate, LocationManagerDelegate>

@property (strong, nonatomic) EventController *eventController;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) Event *event;
@property (strong, nonatomic) Session *session;
@property (strong, nonatomic) EventEditorDataSource *dataSource;

@end

@implementation EventEditorViewController

- (instancetype)initWithEvent:(Event *)event session:(Session *)session {
    if (self = [super init]) {
        self.event = event;
        self.session = session;
        
        /*
         * Create picture controller.
         */
        
        self.eventController = [[EventController alloc] initWithEvent:event session:session];
        self.eventController.delegate = self;
        
        /*
         * Create data source.
         */
        
        self.dataSource = [[EventEditorDataSource alloc] initWithEvent:self.event];
        
    }
    return self;
}

- (void)loadView {
    
    /*
     * Create editor view
     */
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    self.tableView.contentInset = UIEdgeInsetsMake(-2.0f, 0.0f, 0.0f, 0.0f); // A little hacky.
    self.view = self.tableView;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * Set default date if one is missing.
     */
    
    Event *event = self.event;
    if (!event.startTime) {
        event.startTime = [NSDate date];
    }
    
    /*
     * Register class for reuse identifier.
     */
    
    UITableView *tableView = self.tableView;
    [self.dataSource registerReuseIdentifiersForTableView:tableView];
    
    /*
     * Listen to keyboard.
     */
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /*
     * Set navigation item title.
     */
    
    UINavigationItem *navigationItem = self.navigationItem;
    Event *event = self.event;
    navigationItem.title = event.eventID ? event.title : @"New Event";
    
    /*
     * Set save button.
     */
    
    NavigationBarRoundedButton *saveButton = [[NavigationBarRoundedButton alloc] init];
    [saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(handleSaveButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
    [saveButton sizeToFit];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
    navigationItem.rightBarButtonItem = barButtonItem;
    
}

- (void)dealloc {
    
    /*
     * Stop watching keyboard.
     */
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self];
    
}

- (void)setEventAssetWithImage:(UIImage *)image {
    
    /*
     * Create asset.
     */
    
    Event *event = self.event;
    Photo *asset = [[Photo alloc] init];
    asset.image = image;
    event.asset = asset;
    
    /*
     * Reload table view cell.
     */
    
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:EventEditorDataSourceCellAsset inSection:EventEditorDataSourceSectionAsset]] withRowAnimation:UITableViewRowAnimationFade];
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    switch (section) {
        case EventEditorDataSourceSectionAsset: {
            return CGRectGetHeight(tableView.bounds) * 0.4;
        }
        case EventEditorDataSourceSectionDetails: {
            switch (row) {
                case EventEditorDataSourceCellText: {
                    return 100.0f;
                }
                default: {
                    return 40.0f;
                }
            }
        }
    }
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case EventEditorDataSourceSectionDetails: {
            return 20.0f;
        }
    }
    return 1.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    switch (section) {
        case EventEditorDataSourceSectionAsset: {
            
            /*
             * Open picture alert controller.
             */
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                [alertController addAction:[UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    /*
                     * Open camera view controller.
                     */
                    
                    ListUICameraViewController *controller = [[ListUICameraViewController alloc] init];
                    controller.delegate = self;
                    UINavigationItem *navigationItem = controller.navigationItem;
                    navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage listUI_icon:ListUIIconCross size:kUINavigationBarCrossImageSize] style:UIBarButtonItemStyleDone target:self action:@selector(handlePresentedViewControllerRightBarButtonItem:)];
                    UINavigationController *navigationController = [[UINavigationController alloc] initWithNavigationBarClass:[ClearNavigationBar class] toolbarClass:nil];
                    navigationController.viewControllers = @[ controller ];
                    [self presentViewController:navigationController animated:YES completion:nil];
                    
                }]];
            }
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                [alertController addAction:[UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    /*
                     * View photo library.
                     */

                    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
                    controller.delegate = self;
                    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    controller.view.backgroundColor = [UIColor whiteColor];
                    [self presentViewController:controller animated:YES completion:nil];
                    
                }]];
            }
            
            /*
             * Add cancel action.
             */
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
            
            /*
             * Present.
             */
            
            [self presentViewController:alertController animated:YES completion:nil];
            
            break;
            
        }
        case EventEditorDataSourceSectionDetails: {
            switch (row) {
                case EventEditorDataSourceCellStartTime: {
                    
                    /*
                     * Open date picker.
                     */
                    
                    DatePickerModalViewController *controller = [[DatePickerModalViewController alloc] init];
                    controller.delegate = self;
                    
                    [self presentViewController:controller animated:YES completion:nil];
                    
                    break;
                    
                }
                case EventEditorDataSourceCellLocation: {
                    
                    /*
                     * Open location picker.
                     */
                    
                    LocationPickerViewController *controller = [[LocationPickerViewController alloc] init];
                    controller.delegate = self;
                    
                    UINavigationItem *navigationItem = controller.navigationItem;
                    navigationItem.titleView = [[UIImageView alloc] initWithImage:[[UIImage listUI_icon:ListUIIconLocation size:kUINavigationBarDefaultImageSize] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
                    navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage listUI_icon:ListUIIconCross size:kUINavigationBarCrossImageSize] style:UIBarButtonItemStyleDone target:self action:@selector(handlePresentedViewControllerRightBarButtonItem:)];
                    
                    UINavigationController *navigationController = [[UINavigationController alloc] initWithNavigationBarClass:[BlackNavigationBar class] toolbarClass:nil];
                    navigationController.viewControllers = @[ controller ];
                    
                    [self presentViewController:navigationController animated:YES completion:nil];
                    break;
                }
            }
            break;
        }
    }
    
}

#pragma mark - EventControllerDelegate

- (void)eventControllerDidSaveEvent:(EventController *)eventController {
    
    /*
     * Dismiss this view controller.
     */
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - ListUICameraViewControllerDelegate

- (void)cameraViewController:(ListUICameraViewController *)controller didCaptureStillImage:(UIImage *)image {
    
    /*
     * Handle captured image.
     */
    
    [self setEventAssetWithImage:image];
    
    /*
     * Dismiss controller.
     */
    
    [controller dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    /*
     * Handle selected image.
     */
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self setEventAssetWithImage:image];
    
    /*
     * Dismiss controller.
     */
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - DatePickerModalViewControllerDelegate

- (void)datePickerModalViewController:(DatePickerModalViewController *)viewController didPickDate:(NSDate *)date {
    
    /*
     * Set event.
     */
    
    Event *event = self.event;
    event.startTime = date;
    
    /*
     * Reload table cell.
     */
    
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:EventEditorDataSourceCellStartTime inSection:EventEditorDataSourceSectionDetails]] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

#pragma mark - LocationPickerViewControllerDelegate

- (void)locationPickerViewController:(LocationPickerViewController *)controller didSelectMapItem:(MKMapItem *)item {
    
    /*
     * Set to event.
     */
    
    Event *event = self.event;
    event.placeName = item.name;
    event.placeAddress = item.placemark.title;
    event.location = item.placemark.location;
    
    /*
     * Reload table cell.
     */
    
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:EventEditorDataSourceCellLocation inSection:EventEditorDataSourceSectionDetails]] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    /*
     * Dismiss controller.
     */
    
    [controller dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Bar button item handlers

- (void)handlePresentedViewControllerRightBarButtonItem:(UIBarButtonItem *)item {
    
    /*
     * Dismiss controller.
     */
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)handleSaveButtonTouchDown:(NavigationBarRoundedButton *)button {
    
    /*
     * Set title.
     */
    
    Event *event = self.event;
    UITableView *tableView = self.tableView;
    ListUITextFieldCell *titleCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:EventEditorDataSourceCellTitle inSection:EventEditorDataSourceSectionDetails]];
    event.title = titleCell.textField.text;
    
    /*
     * Set title.
     */
    
    ListUITextViewCell *textCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:EventEditorDataSourceCellText inSection:EventEditorDataSourceSectionDetails]];
    event.text = textCell.textView.text;
    
    /*
     * Save picture.
     */
    
    EventController *eventController = self.eventController;
    [eventController saveEvent];
    
}

#pragma mark - Keyboard handler

- (void)keyboardWasShown:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    /*
     * Fix table offset.
     */
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(-2.0f, 0.0, kbSize.height, 0.0);
    UITableView *tableView = self.tableView;
    tableView.contentInset = contentInsets;
    tableView.scrollIndicatorInsets = contentInsets;
    
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    
    /*
     * Fix table offset.
     */
    
    UITableView *tableView = self.tableView;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(-2.0f, 0.0f, 0.0f, 0.0f);
    tableView.contentInset = contentInsets;
    tableView.scrollIndicatorInsets = contentInsets;
    
}

@end
