//
//  PicturesViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PicturesViewController.h"
#import "PicturesDataSource.h"
#import "ListConstants.h"
#import "PicturesTableViewDelegate.h"

@interface PicturesViewController ()

@property (strong, nonatomic) Session *session;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) PicturesController *picturesController;
@property (strong, nonatomic) PicturesDataSource *dataSource;
@property (strong, nonatomic) PicturesTableViewDelegate *tableViewDelegate;

@end

@implementation PicturesViewController

- (instancetype)initWithSession:(Session *)session {
    if (self = [super init]) {
        self.session = session;
        
        /*
         * Create pictures controller.
         */
        
        self.picturesController = [[PicturesController alloc] init];
        self.picturesController.delegate = self;
        
        /*
         * Create data source.
         */
        
        self.dataSource = [[PicturesDataSource alloc] initWithPicturesController:self.picturesController];
        
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    /*
     * Set view background.
     */
    
    self.view.backgroundColor = [UIColor listBlackColorAlpha:1];
    
    /*
     * Setup photos view.
     */
    
    UITableView *tableView = self.tableView = [[UITableView alloc] init];
    PicturesTableViewDelegate *tableViewDelegate = self.tableViewDelegate = [[PicturesTableViewDelegate alloc] initWithPicturesController:self.picturesController];
    tableView.dataSource = self.dataSource;
    tableView.delegate = tableViewDelegate;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor listBlackColorAlpha:1];
    [self.view addSubview:tableView];
    
}

- (void)viewDidLoad {
    
    /*
     * Register class for reuse identifier.
     */
    
    UITableView *tableView = self.tableView;
    [self.dataSource registerReuseIdentifiersForTableView:tableView];
    
    /*
     * Set navigation item title view.
     */
    
    UIImage *icon = [[UIImage listIcon:ListUIIconPictures size:kUINavigationBarDefaultImageSize] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:icon];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /*
     * Perform request.
     */
    
    [self.picturesController requestPictures];
    
}

- (void)viewWillLayoutSubviews {
    
    /*
     * Lay out photo view.
     */
    
    CGFloat x, y, w, h;
    x = 0.0f;
    y = 0.0f;
    w = CGRectGetWidth(self.view.bounds);
    h = CGRectGetHeight(self.view.bounds);
    self.tableView.frame = CGRectMake(x, y, w, h);
    
}

#pragma mark - PicturesControllerDelegate

- (void)picturesControllerDidFetchPictures:(PicturesController *)picturesController {
    
    /*
     * Reload data.
     */
    
    [self.tableView reloadData];
    
}

@end
