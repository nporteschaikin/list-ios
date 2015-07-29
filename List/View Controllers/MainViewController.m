//
//  MainViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 7/1/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "MainViewController.h"
#import "CategoriesController.h"
#import "CategoriesViewController.h"
#import "MenuViewController.h"
#import "Session.h"
#import "Constants.h"
#import "UIColor+List.h"

@interface MainViewController () <CategoriesViewControllerDelegate, MenuViewControllerDelegate>

@property (strong, nonatomic) Session *session;
@property (strong, nonatomic) CategoriesViewController *categoriesViewController;
@property (strong, nonatomic) MenuViewController *menuViewController;

@end

@implementation MainViewController

- (id)initWithSession:(Session *)session {
    if (self = [super init]) {
        self.session = session;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * Set background.
     */
    
    self.view.backgroundColor = [UIColor list_blueColorAlpha:1];
    
    /*
     * Create categories controller.
     */
    
    CategoriesController *categoriesController = [[CategoriesController alloc] init];
    
    /*
     * Create categories controller.
     */
    
    self.categoriesViewController = [[CategoriesViewController alloc] initWithCategoriesController:categoriesController
                                                                                           session:self.session];
    self.categoriesViewController.delegate = self;
    [self addChildViewController:self.categoriesViewController];
    [self.view addSubview:self.categoriesViewController.view];
    [self.categoriesViewController didMoveToParentViewController:self];
    
    /*
     * Create menu view controller.
     */
    
    self.menuViewController = [[MenuViewController alloc] initWithSession:self.session];
    self.menuViewController.delegate = self;
    self.menuViewController.view.hidden = YES;
    self.menuViewController.view.alpha = 0.0f;
    self.menuViewController.view.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
    [self addChildViewController:self.menuViewController];
    [self.view insertSubview:self.menuViewController.view
                aboveSubview:self.categoriesViewController.view];
    [self.menuViewController didMoveToParentViewController:self];
    
}

- (void)openMenuView:(BOOL)open
            animated:(BOOL)animated {
    MenuViewController *menuViewController = self.menuViewController;
    CategoriesViewController *categoriesViewController = self.categoriesViewController;
    UIView *menuView = menuViewController.view;
    UIView *categoriesView = categoriesViewController.view;
    
    if (open) {
        menuView.hidden = NO;
        [menuViewController viewWillAppear:YES];
        [categoriesViewController viewWillDisappear:YES];
    } else {
        [menuViewController viewWillDisappear:YES];
        [categoriesViewController viewWillAppear:YES];
    }
    
    void (^animationBlock)(void) = ^void(void) {
        if (open) {
            categoriesView.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
            categoriesView.alpha = 0.0f;
            menuView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
            menuView.alpha = 1.0f;
        } else {
            categoriesView.transform = CGAffineTransformMakeTranslation(0, 0);
            categoriesView.alpha = 1.0f;
            menuView.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
            menuView.alpha = 0.0f;
        }
    };
    void (^completionBlock)(BOOL) = ^void(BOOL finished) {
        if (open) {
            [menuViewController viewDidAppear:YES];
            [categoriesViewController viewDidDisappear:YES];
        } else {
            menuView.hidden = YES;
            [menuViewController viewDidDisappear:YES];
            [categoriesViewController viewDidAppear:YES];
        }
    };
    if (animated) {
        [UIView animateWithDuration:0.25f
                         animations:animationBlock
                         completion:completionBlock];
    } else {
        completionBlock(YES);
    }
}

#pragma mark - CategoriesViewControllDelegate

- (void)categoriesViewControllerHeaderViewMenuControlTouchDown:(CategoriesViewController *)viewController {
    [self openMenuView:YES
              animated:YES];
}

#pragma mark - MenuViewControllerDelegate

- (void)menuViewControllerCloseControlTouchDown:(MenuViewController *)viewController {
    [self openMenuView:NO
              animated:YES];
}

@end
