//
//  EventEditorViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 8/3/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "EventEditorViewController.h"
#import "ListGeneralCell.h"
#import "UIColor+List.h"
#import "NSDateFormatter+List.h"

typedef NS_ENUM(NSUInteger, EventPostTimeEditorRows) {
    EventPostTimeEditorRowsStartTime = 0,
    EventPostTimeEditorRowsEndTime
};

@interface EventEditorViewController ()

@property (strong, nonatomic) Event *event;
@property (strong, nonatomic) UIDatePicker *datePicker;

@end

@implementation EventEditorViewController

static NSString * const ListGeneralCellReuseIdentifier = @"ListGeneralCellReuseIdentifier";

- (instancetype)initWithEvent:(Event *)event {
    if (self = [super init]) {
        self.event = event;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * Register table cell.
     */
    
    [self.tableView registerClass:[ListGeneralCell class] forCellReuseIdentifier:ListGeneralCellReuseIdentifier];
    self.tableView.separatorColor = [UIColor list_grayColorAlpha:1];
    self.tableView.backgroundColor = [UIColor list_lightGrayColorAlpha:1];
    self.tableView.backgroundView = nil;
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        self.tableView.layoutMargins = UIEdgeInsetsZero;
    }
    
    /*
     * Create navigation bar.
     */
    
    self.navigationItem.title = @"Date & Time";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                          target:self
                                                                                          action:@selector(handleCancelBarButtonItem:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                           target:self
                                                                                           action:@selector(handleDoneBarButtonItem:)];
    
    /*
     * Listen to date picker.
     */
    
    [self.datePicker addTarget:self
                        action:@selector(handleDatePickerValueChange:)
              forControlEvents:UIControlEventValueChanged];
    
}

#pragma mark - Bar button item selectors

- (void)handleCancelBarButtonItem:(UIBarButtonItem *)item {
    
    /*
     * Return to root view controller.
     */
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)handleDoneBarButtonItem:(UIBarButtonItem *)item {
    
    /*
     * Return to root view controller.
     */
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)displayDatePickerForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.datePicker.superview == nil) {
        
        /*
         * Set the frames for start and finish.
         */
        
        CGRect startFrame = self.datePicker.frame;
        CGRect endFrame = self.datePicker.frame;
        startFrame.origin.y = CGRectGetHeight(self.view.frame);
        endFrame.origin.y = startFrame.origin.y - CGRectGetHeight(endFrame);
        
        /*
         * Set start frame.
         */
        
        self.datePicker.frame = startFrame;
        
        /*
         * Add view.
         */
        
        [self.view addSubview:self.datePicker];
        
        /*
         * Animate it in.
         */
        
        [UIView animateWithDuration:0.25f
                         animations: ^{
                             self.datePicker.frame = endFrame;
                         }
                         completion:nil];
    }
}

#pragma mark - Date picker handler

- (void)handleDatePickerValueChange:(UIDatePicker *)datePicker {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    ListGeneralCell *cell = (ListGeneralCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    switch (indexPath.row) {
        case EventPostTimeEditorRowsStartTime: {
            self.event.startTime = datePicker.date;
        }
        case EventPostTimeEditorRowsEndTime: {
            self.event.endTime = datePicker.date;
        }
    }
    cell.detailTextLabel.text = [[NSDateFormatter list_defaultDateFormatter] stringFromDate:self.datePicker.date];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListGeneralCell *cell = [tableView dequeueReusableCellWithIdentifier:ListGeneralCellReuseIdentifier];
    NSInteger row = indexPath.row;
    Event *event = self.event;
    switch (row) {
        case EventPostTimeEditorRowsStartTime: {
            cell.textLabel.text = @"Starts";
            cell.detailTextLabel.text = [[NSDateFormatter list_defaultDateFormatter] stringFromDate:event.startTime];
            break;
        }
        case EventPostTimeEditorRowsEndTime: {
            cell.textLabel.text = @"Ends";
            cell.detailTextLabel.text = [[NSDateFormatter list_defaultDateFormatter] stringFromDate:event.endTime];
            break;
        }
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(ListTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self displayDatePickerForRowAtIndexPath:indexPath];
}

#pragma mark - Dynamic getters

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.backgroundColor = [UIColor whiteColor];
    }
    return _datePicker;
}

@end
