//
//  PictureViewController.h
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"
#import "PictureView.h"
#import "Picture.h"
#import "Session.h"

@interface PictureViewController : ListUIViewController

@property (strong, nonatomic, readonly) PictureView *pictureView;

- (instancetype)initWithPicture:(Picture *)picture session:(Session *)session;

@end
