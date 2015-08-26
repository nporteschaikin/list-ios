//
//  CreatePictureEditorView.h
//  List
//
//  Created by Noah Portes Chaikin on 8/19/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"

@interface CreatePictureEditorView : UIScrollView

@property (copy, nonatomic) NSString *text;
@property (strong, nonatomic) UIImage *image;
@property (copy, nonatomic) NSArray *toolbarItems;

- (void)setToolbarItems:(NSArray *)items animated:(BOOL)animated;

@end
