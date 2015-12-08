//
//  PictureViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PictureViewController.h"
#import "ListLoadingView.h"
#import "ListConstants.h"
#import "UIImageView+WebCache.h"
#import "NSDate+ListAdditions.h"

@interface PictureViewController ()

@property (strong, nonatomic) PictureView *pictureView;
@property (strong, nonatomic) PictureController *pictureController;
@property (strong, nonatomic) ListLoadingView *loadingView;

@end

@implementation PictureViewController

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
     * Add picture view.
     */
    
    PictureView *pictureView = self.pictureView = [[PictureView alloc] init];
    self.view = pictureView;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    /*
     * Add loading view.
     */
    
    ListLoadingView *loadingView = self.loadingView = [[ListLoadingView alloc] init];
    loadingView.hidden = YES;
    loadingView.lineColor = [UIColor whiteColor];
    [pictureView addSubview:loadingView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * Set up navigation item.
     */
    
    UINavigationItem *navigationItem = self.navigationItem;
    navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage listUI_icon:ListUIIconCross size:kUINavigationBarCrossImageSize] style:UIBarButtonItemStyleDone target:self action:@selector(handleRightBarButtonItem:)];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /*
     * Set up view.
     */
    
    PictureView *pictureView = self.pictureView;
    PictureController *controller = self.pictureController;
    Picture *picture = controller.picture;
    pictureView.displayName = picture.user.displayName;
    pictureView.text = picture.text;
    pictureView.detailsLabel.text = [NSString stringWithFormat:@"%@ in %@", [picture.createdAt list_timeAgo], picture.placemark.title];
    [pictureView.avatarView sd_setImageWithURL:picture.user.profilePhoto.URL];
    
    /*
     * Load image.
     */
    
    ListLoadingView *loadingView = self.loadingView;
    loadingView.hidden = NO;
    pictureView.assetView.alpha = 0.0f;
    [pictureView.assetView sd_setImageWithURL:picture.asset.URL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        loadingView.hidden = YES;
        [UIView animateWithDuration:0.25f animations:^{
            pictureView.assetView.alpha = 1.0f;
        }];
    }];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    /*
     * Animate in footer view.
     */
    
    PictureView *pictureView = self.pictureView;
    [pictureView displayFooter:YES animated:YES];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    /*
     * Position loading view.
     */
    
    CGFloat x, y, w, h;
    x = (CGRectGetWidth(self.view.bounds) - kListLoadingViewDefaultSize) / 2;
    y = (CGRectGetHeight(self.view.bounds) - kListLoadingViewDefaultSize) / 2;
    w = kListLoadingViewDefaultSize;
    h = kListLoadingViewDefaultSize;
    self.loadingView.frame = CGRectMake(x, y, w, h);
    
}

#pragma mark - Right bar button handler

- (void)handleRightBarButtonItem:(UIBarButtonItem *)item {
    
    /*
     * Dismiss controller.
     */
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
