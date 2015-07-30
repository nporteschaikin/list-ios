//
//  HomeLocationViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 7/30/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "HomeLocationViewController.h"
#import "PostEditorViewController.h"
#import "LIconControl.h"
#import "UIColor+List.h"

@interface HomeLocationViewController ()

@property (strong, nonatomic) LIconControl *addControl;

@end

@implementation HomeLocationViewController

static CGFloat const HomeLocationViewControllerAddControlSize = 50.f;
static CGFloat const HomeLocationViewControllerAddControlMargin = 12.f;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * Add subview for add control.
     */
    
    [self.view addSubview:self.addControl];
    
    /*
     * Add handler for add control.
     */
    
    [self.addControl addTarget:self
                        action:@selector(handleAddControlTouchDown:)
              forControlEvents:UIControlEventTouchDown];
    
}

- (void)presentPostEditorViewController {
    
    /*
     * Get current category.
     */
    
    NSInteger index = self.headerView.selectedIndex;
    NSArray *categories = self.categoriesController.categories;
    if (index < categories.count) {
        PostCategory *category = [categories objectAtIndex:index];
        
        /*
         * Create new post.
         */
        
        Post *post = [[Post alloc] init];
        post.category = category;
        
        /*
         * Create new view controller.
         */
        
        PostEditorViewController *postEditorViewController = [[PostEditorViewController alloc] initWithPost:post session:self.session];
        
        /*
         * Present
         */
        
        [self presentViewController:postEditorViewController
                           animated:YES
                         completion:nil];
        
    }
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat x, y, w, h;
    x = CGRectGetMaxX(self.view.bounds) - HomeLocationViewControllerAddControlMargin - HomeLocationViewControllerAddControlSize;
    y = CGRectGetMaxY(self.view.bounds) - HomeLocationViewControllerAddControlMargin - HomeLocationViewControllerAddControlSize;
    w = HomeLocationViewControllerAddControlSize;
    h = HomeLocationViewControllerAddControlSize;
    self.addControl.frame = CGRectMake(x, y, w, h);
    
}

#pragma mark - Add control handler

- (void)handleAddControlTouchDown:(LIconControl *)addControl {
    
    /*
     * Show post editor view controller.
     */
    
    [self presentPostEditorViewController];
    
}

#pragma mark - Dynamic getters

- (LIconControl *)addControl {
    if (!_addControl) {
        _addControl = [[LIconControl alloc] initWithStyle:LIconControlStyleAdd];
        _addControl.lineColor = [UIColor list_blueColorAlpha:1];
    }
    return _addControl;
}

@end
