//
//  CreatePictureEditorView.h
//  List
//
//  Created by Noah Portes Chaikin on 8/19/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"

@interface CreatePictureEditorView : UIScrollView

@property (strong, nonatomic, readonly) ListUITextView *textView;
@property (strong, nonatomic, readonly) UIImageView *imageView;
@property (nonatomic) CGFloat progress;
@property (strong, nonatomic, readonly) UIToolbar *toolbar;

@end
