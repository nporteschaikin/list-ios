//
//  CreatePictureEditorView.h
//  List
//
//  Created by Noah Portes Chaikin on 8/19/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"

@interface CreatePictureEditorView : UIView

@property (copy, nonatomic) NSString *text;
@property (strong, nonatomic) UIImage *image;
@property (copy, nonatomic) NSArray *toolbarItems;
@property (nonatomic) CGFloat progress;
@property (strong, nonatomic, readonly) UIButton *returnButton;
@property (strong, nonatomic, readonly) UIButton *closeButton;
@property (strong, nonatomic, readonly) UIScrollView *scrollView;

- (void)setToolbarItems:(NSArray *)items animated:(BOOL)animated;

@end
