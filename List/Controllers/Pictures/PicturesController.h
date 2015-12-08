//
//  PicturesController.h
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Picture.h"
#import "Paging.h"
#import "Tag.h"
#import "Session.h"
#import "MapCircle.h"

@class PicturesController;

@protocol PicturesControllerDelegate <NSObject>

@optional
- (void)picturesControllerDidFetchPictures:(PicturesController *)picturesController;
- (void)picturesController:(PicturesController *)picturesController didInsertPictures:(NSArray *)pictures intoPictures:(NSArray *)prevPictures;
- (void)picturesController:(PicturesController *)picturesController failedToFetchPicturesWithError:(NSError *)error;
- (void)picturesController:(PicturesController *)picturesController failedToFetchPicturesWithResponse:(id<NSObject>)response;

@end;

@interface PicturesController : NSObject

@property (weak, nonatomic) id<PicturesControllerDelegate> delegate;

#pragma mark - Result properties
@property (copy, nonatomic, readonly) NSArray *pictures;
@property (copy, nonatomic, readonly) NSArray *tags;
@property (strong, nonatomic, readonly) Paging *paging;
@property (strong, nonatomic, readonly) Placemark *placemark;

#pragma mark - Query properties
@property (strong, nonatomic) MapCircle *mapCircle;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) Picture *start;

- (id)initWithSession:(Session *)session;
- (void)requestPictures;
- (void)insertPictures;

@end
