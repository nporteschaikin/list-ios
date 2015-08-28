//
//  ListUIPhotosViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 8/25/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIPhotosViewController.h"

@interface ListUIPhotosViewController ()

@property (strong, nonatomic) ListUIPhotosView *photosView;

@end

@implementation ListUIPhotosViewController

- (void)loadView {
    
    /*
     * Use photos view.
     */
    
    self.photosView = [[ListUIPhotosView alloc] init];
    self.photosView.delegate = self;
    self.photosView.dataSource = self;
    self.view = self.photosView;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

#pragma mark - ListUIPhotosViewDataSource

- (ListUIPhotosViewCell *)photosView:(ListUIPhotosView *)scrollView cellForRowAtIndex:(NSInteger)index {
    
    /*
     * Must overwrite.
     */
    
    return nil;
    
}

- (NSInteger)numberOfRowsInPhotosView:(ListUIPhotosView *)photosView {
    
    /*
     * Must overwrite.
     */
    
    return 0;
    
}

@end
