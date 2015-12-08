//
//  EventViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "EventViewController.h"
#import "ListConstants.h"

@interface EventViewController ()

@property (strong, nonatomic) EventController *eventController;

@end

@implementation EventViewController

- (instancetype)initWithEvent:(Event *)event session:(Session *)session {
    if (self = [super init]) {
        
        /*
         * Create event controller.
         */
        
        self.eventController = [[EventController alloc] initWithEvent:event session:session];
        self.eventController.delegate = self;
        
    }
    return self;
}

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * Set up navigation item.
     */
    
    UINavigationItem *navigationItem = self.navigationItem;
    navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage listUI_icon:ListUIIconCross size:kUINavigationBarCrossImageSize] style:UIBarButtonItemStyleDone target:self action:@selector(handleRightBarButtonItem:)];
    
}

#pragma mark - Right bar button handler

- (void)handleRightBarButtonItem:(UIBarButtonItem *)item {
    
    /*
     * Dismiss controller.
     */
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
