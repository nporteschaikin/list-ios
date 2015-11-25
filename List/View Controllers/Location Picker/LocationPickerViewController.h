//
//  LocationPickerViewController.h
//  List
//
//  Created by Noah Portes Chaikin on 11/24/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"
#import <MapKit/MapKit.h>

@class LocationPickerViewController;

@protocol LocationPickerViewControllerDelegate <NSObject>

@optional;
- (void)locationPickerViewController:(LocationPickerViewController *)controller didSelectMapItem:(MKMapItem *)item;

@end

@interface LocationPickerViewController : ListUIViewController

@property (weak, nonatomic) id<LocationPickerViewControllerDelegate> delegate;

@end
