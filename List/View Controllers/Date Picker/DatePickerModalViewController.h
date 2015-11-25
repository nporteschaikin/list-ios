//
//  DatePickerModalViewController.h
//  List
//
//  Created by Noah Portes Chaikin on 11/24/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"

@class DatePickerModalViewController;

@protocol DatePickerModalViewControllerDelegate <NSObject>

@optional
- (void)datePickerModalViewController:(DatePickerModalViewController *)viewController didPickDate:(NSDate *)date;

@end

@interface DatePickerModalViewController : ListUIViewController

@property (weak, nonatomic) id<DatePickerModalViewControllerDelegate> delegate;

@end
