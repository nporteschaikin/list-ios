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

@interface PicturesViewController ()

@property (strong, nonatomic) Session *session;
@property (strong, nonatomic) PicturesController *picturesController;
@property (strong, nonatomic) PicturesDataSource *dataSource;

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
     * Set data source.
     */
    
    self.photosView.dataSource = self.dataSource;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * Set location bar item.
     */
    
    self.locationBarItem.image = [UIImage listIcon:ListUIIconPictures size:kListUILocationBarDefaultImageSize];
    self.locationBarItem.barTintColor = [UIColor listBlackColorAlpha:1];
    self.locationBarItem.tintColor = [UIColor whiteColor];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /*
     * Perform request.
     */
    
    [self.picturesController requestPictures];
    
}

#pragma mark - PicturesControllerDelegate

- (void)picturesControllerDidFetchPictures:(PicturesController *)picturesController {
    
    /*
     * Reload data.
     */
    
    [self.photosView reloadData];
    
}

@end
