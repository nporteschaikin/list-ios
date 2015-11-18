//
//  CreatePictureEditorViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 8/19/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "CreatePictureEditorViewController.h"

@interface CreatePictureEditorViewController ()

@property (strong, nonatomic) PictureController *pictureController;
@property (strong, nonatomic) CreatePictureEditorView *createPictureEditorView;

@end

@implementation CreatePictureEditorViewController

- (instancetype)initWithPicture:(Picture *)picture session:(Session *)session {
    if (self = [super init]) {
        
        /*
         * Create picture controller.
         */
        
        self.pictureController = [[PictureController alloc] initWithPicture:picture session:session];
        self.pictureController.delegate = self;
        
    }
    return self;
}

- (void)loadView {
    
    /*
     * Create modal picture editor view.
     */
    
    self.createPictureEditorView = [[CreatePictureEditorView alloc] init];
    self.view = self.createPictureEditorView;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * Register keyboard notifications.
     */
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(handleKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /*
     * Get some tools.
     */
    
    PictureController *pictureController = self.pictureController;
    Picture *picture = pictureController.picture;
    Photo *asset = picture.asset;
    CreatePictureEditorView *view = self.createPictureEditorView;
    
    /*
     * Set picture values where appropriate.
     */
    
    view.image = asset.image;
    view.text = picture.text;
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CreatePictureEditorView *view = self.createPictureEditorView;
    
    /*
     * Make editor first responder.
     */
    
    [view becomeFirstResponder];
    
    /*
     * If the toolbar has no items, set 'em up.
     */
    
    if (!view.toolbarItems) {
        
        /*
         * Create flex item.
         */
        
        UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        /*
         * Create save button item.
         */
        
        UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(handleSaveBarButtonItem:)];
        
        /*
         * Set to toolbar
         */
        
        [view setToolbarItems:@[flexItem, saveItem] animated:YES];
        
    }
    
}

- (void)dealloc {
    
    /*
     * Remove keyboard notifications
     */
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self];
    
}

#pragma mark - PictureControllerDelegate

- (void)pictureControllerDidSavePicture:(PictureController *)pictureController {
    
    /*
     * Dismiss this view controller.
     */
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Bar button item handlers.

- (void)handleSaveBarButtonItem:(UIBarButtonItem *)item {
    
    /*
     * Set picture.
     */
    
    CreatePictureEditorView *view = self.createPictureEditorView;
    PictureController *pictureController = self.pictureController;
    Picture *picture = pictureController.picture;
    picture.text = view.text;
    
    /*
     * Save picture.
     */
    
    [pictureController savePicture];
    
}

#pragma mark - Keyboard handlers

- (void)handleKeyboardWillShow:(NSNotification *)notification {
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    /*
     * Update scroll view.
     */
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    CreatePictureEditorView *view = self.createPictureEditorView;
    view.contentInset = contentInsets;
    view.scrollIndicatorInsets = contentInsets;
    
    /*
     * Scroll to bottom.
     */
    
    CGPoint point = CGPointMake(0, kbSize.height);
    [view setContentOffset:point animated:YES];
    
}

- (void)handleKeyboardWillHide:(NSNotification *)notification {
    
    /*
     * Update scroll view.
     */
    
    CreatePictureEditorView *view = self.createPictureEditorView;
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    view.contentInset = contentInsets;
    view.scrollIndicatorInsets = contentInsets;
    
}

@end
