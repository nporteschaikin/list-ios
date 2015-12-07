//
//  PictureViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PictureViewController.h"
#import "ListConstants.h"
#import "UIImageView+WebCache.h"
#import "NSDate+ListAdditions.h"

@interface PictureViewController ()

@property (strong, nonatomic) PictureView *pictureView;
@property (strong, nonatomic) Picture *picture;
@property (strong, nonatomic) Session *session;

@end

@implementation PictureViewController

- (instancetype)initWithPicture:(Picture *)picture session:(Session *)session {
    if (self = [super init]) {
        self.picture = picture;
        self.session = session;
    }
    return self;
}

- (void)loadView {
    
    /*
     * Set view defaults.
     */
    
    PictureView *pictureView = self.pictureView = [[PictureView alloc] init];
    self.view = pictureView;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
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
    Picture *picture = self.picture;
    pictureView.displayName = picture.user.displayName;
    pictureView.text = picture.text;
    pictureView.detailsLabel.text = [NSString stringWithFormat:@"%@ in %@", [picture.createdAt list_timeAgo], picture.placemark.title];
    [pictureView.assetView sd_setImageWithURL:picture.asset.URL];
    [pictureView.avatarView sd_setImageWithURL:picture.user.profilePhoto.URL];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    /*
     * Animate in footer view.
     */
    
    PictureView *pictureView = self.pictureView;
    [pictureView displayFooter:YES animated:YES];
    
}

#pragma mark - Right bar button handler

- (void)handleRightBarButtonItem:(UIBarButtonItem *)item {
    
    /*
     * Dismiss controller.
     */
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
