//
//  CreatePictureEditorViewController.h
//  List
//
//  Created by Noah Portes Chaikin on 8/19/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"
#import "PictureController.h"
#import "CreatePictureEditorView.h"

@interface CreatePictureEditorViewController : ListUIViewController <PictureControllerDelegate>

@property (strong, nonatomic, readonly) CreatePictureEditorView *createPictureEditorView;
- (instancetype)initWithPicture:(Picture *)picture session:(Session *)session NS_DESIGNATED_INITIALIZER;

@end
