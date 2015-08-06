//
//  HomeLocationViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 7/30/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "HomeLocationViewController.h"
#import "CreatePostView.h"
#import "CreatePostViewDelegate.h"
#import "LIconControl.h"
#import "UIColor+List.h"

@interface HomeLocationViewController ()

@property (strong, nonatomic) CreatePostView *createPostView;
@property (strong, nonatomic) CreatePostViewDelegate *createPostDelegate;
@property (strong, nonatomic) LIconControl *addControl;

@end

@implementation HomeLocationViewController

static CGFloat const HomeLocationViewControllerControlSize = 50.f;
static CGFloat const HomeLocationViewControllerControlMargin = 6.f;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * Create create post delegate; add to create post view.
     */
    
    self.createPostDelegate = [[CreatePostViewDelegate alloc] init];
    self.createPostDelegate.viewController = self;
    self.createPostDelegate.session = self.session;
    self.createPostView.delegate = self.createPostDelegate;
    
    /*
     * Add subview for add control.
     */
    
    [self.view addSubview:self.addControl];
    [self.view addSubview:self.createPostView];
    
    /*
     * Add handler for add control.
     */
    
    [self.addControl addTarget:self
                        action:@selector(handleAddControlTouchDown:)
              forControlEvents:UIControlEventTouchDown];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /*
     * Hide create post view controller.
     */
    
    [self dismissCreatePostView];
    
}

- (void)presentCreatePostView {
    if (self.createPostView.hidden) {
        self.createPostView.hidden = NO;
        [self.createPostView displayButtons:YES animated:YES completion:nil];
    }
}

- (void)dismissCreatePostView {
    if (!self.createPostView.hidden) {
        [self.createPostView displayButtons:NO animated:YES completion:^{
            self.createPostView.hidden = YES;
        }];
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat x, y, w, h;
    x = CGRectGetMaxX(self.view.bounds) - HomeLocationViewControllerControlMargin - HomeLocationViewControllerControlSize;
    y = CGRectGetMaxY(self.view.bounds) - HomeLocationViewControllerControlMargin - HomeLocationViewControllerControlSize;
    w = HomeLocationViewControllerControlSize;
    h = HomeLocationViewControllerControlSize;
    self.addControl.frame = CGRectMake(x, y, w, h);
    
    CGRect frame = self.view.frame;
    CGSize size = [self.createPostView sizeThatFits:CGSizeMake(frame.size.width, HomeLocationViewControllerControlSize)];
    x = CGRectGetMinX(self.addControl.frame) - (size.width + HomeLocationViewControllerControlMargin);
    y = CGRectGetMinY(self.addControl.frame);
    w = size.width;
    h = size.height;
    self.createPostView.frame = CGRectMake(x, y, w, h);

}

#pragma mark - Add control handler

- (void)handleAddControlTouchDown:(LIconControl *)addControl {
    
    /*
     * Show or hide create post view controller.
     */
    
    self.createPostView.hidden ? [self presentCreatePostView]
        : [self dismissCreatePostView];
    
}

#pragma mark - LocationHeaderViewDelegate

- (void)locationHeaderView:(LocationHeaderView *)locationHeaderView didSelectControlAtIndex:(NSInteger)index {
    [super locationHeaderView:locationHeaderView didSelectControlAtIndex:index];
    
    /*
     * Update create post delegate.
     */
    
    PostCategory *category = self.categoriesController.categories[index];
    self.createPostDelegate.category = category;
    
}

#pragma mark - CategoriesControllerDelegate

- (void)categoriesControllerDidFetchCategories:(CategoriesController *)categoriesController {
    [super categoriesControllerDidFetchCategories:categoriesController];
    
    /*
     * Set category on create post delegate.
     */
    
    self.createPostDelegate.category = categoriesController.categories[0];
    
}

#pragma mark - Dynamic getters

- (LIconControl *)addControl {
    if (!_addControl) {
        _addControl = [[LIconControl alloc] initWithStyle:LIconControlStyleAdd];
        _addControl.lineColor = [UIColor list_blueColorAlpha:1];
    }
    return _addControl;
}

- (CreatePostView *)createPostView {
    if (!_createPostView) {
        _createPostView = [[CreatePostView alloc] init];
        _createPostView.hidden = YES;
    }
    return _createPostView;
}

@end
