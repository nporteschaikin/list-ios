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
#import "PicturesFlowLayout.h"

@interface PicturesViewController ()

@property (strong, nonatomic) Session *session;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) PicturesController *picturesController;
@property (strong, nonatomic) PicturesDataSource *dataSource;
@property (strong, nonatomic) PicturesFlowLayout *layout;


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
     * Create default layout.
     */
    
    PicturesFlowLayout *layout = self.layout = [[PicturesFlowLayout alloc] init];
    
    /*
     * Setup photos view.
     */
    
    UICollectionView *collectionView = self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.dataSource = self.dataSource;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor listBlackColorAlpha:1];
    collectionView.pagingEnabled = YES;
    [self.view addSubview:collectionView];
    
}

- (void)viewDidLoad {
    
    /*
     * Register class for reuse identifier.
     */
    
    UICollectionView *collectionView = self.collectionView;
    [self.dataSource registerReuseIdentifiersForCollectionView:collectionView];
    
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
    self.collectionView.frame = CGRectMake(x, y, w, h);
    
}

#pragma mark - PicturesControllerDelegate

- (void)picturesControllerDidFetchPictures:(PicturesController *)picturesController {
    
    /*
     * Reload data.
     */
    
    [self.collectionView reloadData];
    
}

@end
