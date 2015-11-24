//
//  EventEditorDataSource.m
//  List
//
//  Created by Noah Portes Chaikin on 11/23/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "EventEditorDataSource.h"
#import "UIImageView+WebCache.h"

@interface EventEditorDataSource ()

@property (strong, nonatomic) Event *event;

@end

@implementation EventEditorDataSource

static NSString * const kListUITextFieldCellReuseIdentifier = @"kListUITextFieldCellReuseIdentifier";
static NSString * const kListUITextViewCellReuseIdentifier = @"kListUITextViewCellReuseIdentifier";
static NSString * const kListUITableViewCellReuseIdentifier = @"kListUITableViewCellReuseIdentifier";
static NSString * const kEventEditorAssetCellReuseIdentifier = @"kEventEditorAssetCellReuseIdentifier";

- (instancetype)initWithEvent:(Event *)event {
    if (self = [super init]) {
        self.event = event;
    }
    return self;
}

- (void)registerReuseIdentifiersForTableView:(UITableView *)tableView {
    [tableView registerClass:[ListUITextFieldCell class] forCellReuseIdentifier:kListUITextFieldCellReuseIdentifier];
    [tableView registerClass:[ListUITextViewCell class] forCellReuseIdentifier:kListUITextViewCellReuseIdentifier];
    [tableView registerClass:[ListUITableViewCell class] forCellReuseIdentifier:kListUITableViewCellReuseIdentifier];
    [tableView registerClass:[EventEditorAssetCell class] forCellReuseIdentifier:kEventEditorAssetCellReuseIdentifier];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    Event *event = self.event;
    UITableViewCell *cell;
    switch (section) {
        case EventEditorDataSourceSectionAsset: {
            
            /*
             * Asset section.
             */
            
            EventEditorAssetCell *assetCell = [tableView dequeueReusableCellWithIdentifier:kEventEditorAssetCellReuseIdentifier];
            // TODO: maybe improve this if possible
            if (event.asset.image) {
                assetCell.assetView.image = event.asset.image;
            } else if (event.asset.URL) {
                [assetCell.assetView sd_setImageWithURL:event.asset.URL];
            }
            assetCell.helperViewsVisible = !event.asset;
            cell = assetCell;
            break;
            
        }
        case EventEditorDataSourceSectionDetails: {
            
            /*
             * Details section.
             */
            
            switch (row) {
                case EventEditorDataSourceCellTitle: {
                    
                    /*
                     * Title row.
                     */
                    
                    ListUITextFieldCell *titleCell = [tableView dequeueReusableCellWithIdentifier:kListUITextFieldCellReuseIdentifier];
                    ListUITextField *textField = titleCell.textField;
                    textField.placeholder = @"Event Title";
                    textField.text = event.title;
                    cell = titleCell;
                    break;
                    
                }
                case EventEditorDataSourceCellStartTime: {
                    
                    /*
                     * Start time row.
                     */
                    
                    ListUITableViewCell *startTimeCell = [[ListUITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kListUITableViewCellReuseIdentifier];
                    startTimeCell.textLabel.text = @"Starts";
                    startTimeCell.detailTextLabel.text = @"August 1, 2016; 11:00 PM";
                    cell = startTimeCell;
                    break;
                    
                }
                case EventEditorDataSourceCellLocation: {
                    
                    /*
                     * Location row.
                     */
                    
                    ListUITableViewCell *locationCell = [[ListUITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kListUITableViewCellReuseIdentifier];
                    locationCell.textLabel.text = @"Location";
                    locationCell.detailTextLabel.text = @"Brooklyn Bowl";
                    cell = locationCell;
                    break;
                    
                }
                case EventEditorDataSourceCellText: {
                    
                    /*
                     * TExt row.
                     */
                    
                    ListUITextViewCell *textCell = [tableView dequeueReusableCellWithIdentifier:kListUITextViewCellReuseIdentifier];
                    ListUITextView *textView = textCell.textView;
                    textView.placeholder = @"Description";
                    textView.text = event.text;
                    cell = textCell;
                    break;
                    
                }
            }
            
            break;
        }
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case EventEditorDataSourceSectionAsset: {
            return 1;
        }
        case EventEditorDataSourceSectionDetails: {
            return 4;
        }
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

@end
