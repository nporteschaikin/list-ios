//
//  PictureViewController.h
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"
#import "PictureView.h"
#import "PictureController.h"

@interface PictureViewController : ListUIViewController <PictureControllerDelegate>

@property (strong, nonatomic, readonly) PictureView *pictureView;
@property (strong, nonatomic, readonly) PictureController *pictureController;
@property (strong, nonatomic, readonly) Session *session;

- (instancetype)initWithPicture:(Picture *)picture session:(Session *)session;

@end
