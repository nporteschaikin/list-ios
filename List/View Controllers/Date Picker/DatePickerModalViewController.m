//
//  DatePickerModalViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 11/24/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "DatePickerModalViewController.h"

@interface DatePickerModalViewController ()

@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) UIToolbar *toolbar;

@end

@implementation DatePickerModalViewController

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Set defaults.
         */
        
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    /*
     * Add date picker.
     */
    
    UIView *view = self.view;
    UIDatePicker *datePicker = self.datePicker = [[UIDatePicker alloc] init];
    datePicker.backgroundColor = [UIColor whiteColor];
    [datePicker addTarget:self action:@selector(handleDatePickerValueChange:) forControlEvents:UIControlEventValueChanged];
    [view addSubview:datePicker];
    
    /*
     * Add toolbar
     */
    
    UIToolbar *toolbar = self.toolbar = [[UIToolbar alloc] init];
    toolbar.backgroundColor = [UIColor listUI_lightGrayColorAlpha:1];
    toolbar.tintColor = [UIColor listUI_blueColorAlpha:1];
    toolbar.items = @[ [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                       [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(handleCloseBarButtonItem:)] ];
    [view addSubview:toolbar];
    
    /*
     * By default, view background should be clear.
     */
    
    view.backgroundColor = [UIColor clearColor];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat x, y, w, h;
    CGSize size;
    
    x = 0.0f;
    w = CGRectGetWidth(self.view.bounds);
    size = [self.datePicker sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    y = CGRectGetHeight(self.view.bounds) - size.height;
    h = size.height;
    self.datePicker.frame = CGRectMake(x, y, w, h);
    
    size = [self.toolbar sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    y = y - size.height;
    h = size.height;
    self.toolbar.frame = CGRectMake(x, y, w, h);
    
}

#pragma mark - Date picker handler

- (void)handleDatePickerValueChange:(UIDatePicker *)picker {
    
    /*
     * If delegate method exists,
     * run it.
     */
    
    if ([self.delegate respondsToSelector:@selector(datePickerModalViewController:didPickDate:)]) {
        NSDate *date = picker.date;
        [self.delegate datePickerModalViewController:self didPickDate:date];
    }
    
}

#pragma mark - Bar button handler

- (void)handleCloseBarButtonItem:(UIBarButtonItem *)item {
    
    /*
     * If delegate method exists,
     * run it.
     */
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
