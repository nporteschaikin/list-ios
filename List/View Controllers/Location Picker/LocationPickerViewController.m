//
//  LocationPickerViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 11/24/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "LocationPickerViewController.h"

@interface LocationPickerViewController () <UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating>

@property (copy, nonatomic) NSArray *items;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation LocationPickerViewController

static NSString * const kListUITableViewCellReuseIdentifier = @"kListUITableViewCellReuseIdentifier";

- (void)loadView {
    
    /*
     * Create table view.
     */
    
    UITableView *tableView = self.tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[ListUITableViewCell class] forCellReuseIdentifier:kListUITableViewCellReuseIdentifier];
    self.view = tableView;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
}

#pragma mark - UITableViewDataSource

- (ListUITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListUITableViewCell *cell = [[ListUITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kListUITableViewCellReuseIdentifier];
    NSInteger row = indexPath.row;
    MKMapItem *item = self.items[row];
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text = item.placemark.title;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *items = self.items;
    return items.count;
}

#pragma mark - UITextFieldDelegate

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSLog(@"%@", @"foo");
}

//- (BOOL)handleTextFieldDidChange:(UITextField *)textField {
//    
//    /*
//     * Get query.
//     */
//    
//    NSString *query = textField.text;
//    
//    /*
//     * Fetch map items.
//     */
//    
//    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
//    request.naturalLanguageQuery = query;
//    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
//    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
//        self.items = response.mapItems;
//        [self.tableView reloadData];
//    }];
//    
//    return YES;
//}

@end
