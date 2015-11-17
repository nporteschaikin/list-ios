//
//  CreatePictureCameraViewController.h
//  List
//
//  Created by Noah Portes Chaikin on 8/18/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"
#import "Picture.h"
#import "Session.h"
#import "CreatePictureCameraView.h"

@interface CreatePictureCameraViewController : ListUIViewController <CreatePictureCameraViewDelegate, ListUICameraControllerDelegate>

@property (strong, nonatomic, readonly) CreatePictureCameraView *createPictureCameraView;

- (instancetype)initWithPicture:(Picture *)picture;

@end
