//
//  PicturesController.h
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Picture.h"
#import "Tag.h"
#import "Session.h"
#import "MapCircle.h"

@class PicturesController;

@protocol PicturesControllerDelegate <NSObject>

@optional
- (void)picturesControllerDidFetchPictures:(PicturesController *)picturesController;
- (void)picturesController:(PicturesController *)picturesController failedToFetchPicturesWithError:(NSError *)error;
- (void)picturesController:(PicturesController *)picturesController failedToFetchPicturesWithResponse:(id<NSObject>)response;

@end;

@interface PicturesController : NSObject

@property (weak, nonatomic) id<PicturesControllerDelegate> delegate;
@property (copy, nonatomic, readonly) NSArray *pictures;
@property (copy, nonatomic, readonly) NSArray *tags;
@property (strong, nonatomic) MapCircle *mapCircle;
@property (strong, nonatomic) User *user;

- (id)initWithSession:(Session *)session;
- (void)requestPictures;

@end
