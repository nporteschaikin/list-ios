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
#import "PicturesLayout.h"
#import "ZoomAnimator.h"
#import "PictureViewController.h"
#import "ClearNavigationBar.h"

@interface PicturesViewController ()

@property (strong, nonatomic) Session *session;
@property (strong, nonatomic) ListCollectionView *collectionView;
@property (strong, nonatomic) PicturesController *picturesController;
@property (strong, nonatomic) PicturesDataSource *dataSource;
@property (strong, nonatomic) PicturesLayout *layout;
@property (strong, nonatomic) ZoomTransitioningDelegate *zoomTransitioningDelegate;

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
        
        /*
         * Create transitioning delegate.
         */
        
        self.zoomTransitioningDelegate = [[ZoomTransitioningDelegate alloc] init];
        
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    /*
     * Set view background.
     */
    
    self.view.backgroundColor = [UIColor listUI_lightGrayColorAlpha:1.0f];
    
    /*
     * Create default layout.
     */
    
    PicturesLayout *layout = self.layout = [[PicturesLayout alloc] initWithPicturesController:self.picturesController];
    
    /*
     * Create collection view.
     */
    
    ListCollectionView *collectionView = self.collectionView = [[ListCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.dataSource = self.dataSource;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * Register class for reuse identifier.
     */
    
    ListCollectionView *collectionView = self.collectionView;
    [self.dataSource registerReuseIdentifiersForCollectionView:collectionView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    /*
     * `super`
     */
    
    [super viewWillAppear:animated];
    
    /*
     * Perform request.
     */
    
    [self requestPictures];
    
}

- (void)requestPictures {
    
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
    
    /*
     * Set insets.
     */
    
    UIEdgeInsets insets = UIEdgeInsetsMake(self.topLayoutGuide.length, 0.0f, self.bottomLayoutGuide.length, 0.0f);
    self.collectionView.contentInset = insets;
    
}

#pragma mark - PicturesControllerDelegate

- (void)picturesControllerDidFetchPictures:(PicturesController *)picturesController {
    
    /*
     * Reload data.
     */
    
    [self.collectionView reloadData];
    
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    /*
     * Set up transitioning delegate
     */
    
    UICollectionViewLayoutAttributes *attributes = [collectionView layoutAttributesForItemAtIndexPath:indexPath];
    CGRect startFrame = attributes.frame;
    UIView *view = self.view;
    ZoomTransitioningDelegate *zoomTransitioningDelegate = self.zoomTransitioningDelegate;
    zoomTransitioningDelegate.startFrame = [collectionView convertRect:startFrame toView:view];
    
    /*
     * Transition.
     */
    
    NSInteger item = indexPath.item;
    PicturesController *controller = self.picturesController;
    NSArray *pictures = controller.pictures;
    Picture *picture = pictures[item];
    Session *session = self.session;
    PictureViewController *viewController = [[PictureViewController alloc] initWithPicture:picture session:session];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithNavigationBarClass:[ClearNavigationBar class] toolbarClass:nil];
    navigationController.viewControllers = @[ viewController ];
    navigationController.modalPresentationStyle = UIModalPresentationCustom;
    navigationController.transitioningDelegate = zoomTransitioningDelegate;
    [self presentViewController:navigationController animated:YES completion:nil];
    
}

@end
