//
//  LocationPickerViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 11/24/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "LocationPickerViewController.h"
#import "LocationPickerTableViewCell.h"

@interface LocationPickerViewController () <ListSearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) ListSearchBar *searchBar;
@property (strong, nonatomic) UITableView *tableView;
@property (copy, nonatomic) NSArray *mapItems;
@property (strong, nonatomic) MKLocalSearch *search;

@end

@implementation LocationPickerViewController

static NSString * const kLocationPickerTableViewCellReuseIdentifier = @"kLocationPickerTableViewCellReuseIdentifier";

- (void)loadView {
    [super loadView];
    
    /*
     * Set view defaults.
     */
    
    UIView *view = self.view;
    view.backgroundColor = [UIColor listUI_lightGrayColorAlpha:1.0f];
    
    /*
     * Create search bar.
     */
    
    ListSearchBar *searchBar = self.searchBar = [[ListSearchBar alloc] init];
    searchBar.delegate = self;
    [view addSubview:searchBar];
    
    /*
     * Create table view.
     */
    
    UITableView *tableView = self.tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.hidden = YES;
    tableView.separatorColor = [UIColor listUI_lightGrayColorAlpha:1.0f];
    [tableView registerClass:[LocationPickerTableViewCell class] forCellReuseIdentifier:kLocationPickerTableViewCellReuseIdentifier];
    [view addSubview:tableView];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    /*
     * Layout search bar.
     */
    
    CGFloat x, y, w, h;
    CGSize size;
    
    x = 0.0f;
    y = 0.0f;
    w = CGRectGetWidth(self.view.bounds);
    size = [self.searchBar sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    h = size.height;
    self.searchBar.frame = CGRectMake(x, y, w, h);
    
    /*
     * Layout table view.
     */
    
    y = y + h;
    h = CGRectGetHeight(self.view.bounds) - y;
    self.tableView.frame = CGRectMake(x, y, w, h);
    
}

- (void)requestLocations {
    
    /*
     * Cancel last search
     */
    
    [self.search cancel];
    
    /*
     * Create request.
     */
    
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    ListSearchBar *searchBar = self.searchBar;
    NSString *text = searchBar.text;
    request.naturalLanguageQuery = text;
    
    /*
     * Create search object
     * and send request.
     */
    
    MKLocalSearch *search = self.search = [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        
        /*
         * Reset map items.
         */
        
        self.mapItems = response.mapItems;
        
        /*
         * Reset details.
         */
        
        [self.tableView reloadData];
        
        /*
         * If there is text, show table view.
         */
        
        self.tableView.hidden = !text.length;
        
    }];
    
}

#pragma mark - ListSearchBarDelegate

- (void)searchBar:(ListSearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    /*
     * Request new set of locations.
     */
    
    [self requestLocations];
    
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LocationPickerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLocationPickerTableViewCellReuseIdentifier];
    NSInteger row = indexPath.row;
    NSArray *mapItems = self.mapItems;
    MKMapItem *mapItem = mapItems[row];
    cell.nameLabel.text = mapItem.name;
    cell.descriptionLabel.text = mapItem.placemark.title;
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *mapItems = self.mapItems;
    return mapItems.count;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55.f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
     * Remove separator margins.
     */
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        cell.separatorInset = UIEdgeInsetsZero;
    }
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
     * Animate out.
     */
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(locationPickerViewController:didSelectMapItem:)]) {
        
        /*
         * Find selected map item.
         */
        
        NSInteger row = indexPath.row;
        NSArray *mapItems = self.mapItems;
        MKMapItem *mapItem = mapItems[row];
        
        /*
         * Send delegate message.
         */
        
        [self.delegate locationPickerViewController:self didSelectMapItem:mapItem];
        
    }
    
}

@end
