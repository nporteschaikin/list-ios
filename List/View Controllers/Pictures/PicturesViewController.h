//
//  PicturesViewController.h
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"
#import "PicturesController.h"
#import "Session.h"

@interface PicturesViewController : ListUIPhotosViewController <PicturesControllerDelegate>

@property (strong, nonatomic, readonly) PicturesController *picturesController;

- (instancetype)initWithSession:(Session *)session NS_DESIGNATED_INITIALIZER;

@end
