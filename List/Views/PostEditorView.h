//
//  PostEditorView.h
//  List
//
//  Created by Noah Portes Chaikin on 7/7/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTextField.h"
#import "LTextView.h"

@interface PostEditorView : UIScrollView

@property (strong, nonatomic, readonly) LTextField *titleTextField;
@property (strong, nonatomic, readonly) UILabel *categoryLabel;
@property (strong, nonatomic, readonly) LTextView *contentTextView;
@property (strong, nonatomic, readonly) UIButton *cameraButton;
@property (strong, nonatomic, readonly) UIButton *saveButton;
@property (strong, nonatomic, readonly) UIImageView *coverPhotoImageView;

@end
