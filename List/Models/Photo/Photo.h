//
//  Photo.h
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"
#import "ListModel.h"

@interface Photo : ListModel

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSURL *URL;

@end
