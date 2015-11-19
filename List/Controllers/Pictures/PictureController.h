//
//  PictureController.h
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Picture.h"
#import "Session.h"

@class PictureController;

@protocol PictureControllerDelegate <NSObject>

@optional;
- (void)pictureControllerDidFetchPicture:(PictureController *)pictureController;
- (void)pictureController:(PictureController *)pictureController failedToFetchPictureWithError:(NSError *)error;
- (void)pictureController:(PictureController *)pictureController failedToFetchPictureWithResponse:(id<NSObject>)response;
- (void)pictureControllerDidSavePicture:(PictureController *)pictureController;
- (void)pictureControllerIsSavingPicture:(PictureController *)pictureController bytesWritten:(NSInteger)bytesWritten bytesExpectedToWrite:(NSInteger)bytesExpectedToWrite;
- (void)pictureController:(PictureController *)pictureController failedToSavePictureWithError:(NSError *)error;
- (void)pictureController:(PictureController *)pictureController failedToSavePictureWithResponse:(id<NSObject>)response;

@end

@interface PictureController : NSObject

@property (weak, nonatomic) id<PictureControllerDelegate> delegate;
@property (strong, nonatomic, readonly) Picture *picture;
@property (strong, nonatomic, readonly) Session *session;

- (instancetype)initWithPicture:(Picture *)picture session:(Session *)session;
- (void)savePicture;

@end
