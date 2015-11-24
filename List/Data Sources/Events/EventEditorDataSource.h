//
//  EventEditorDataSource.h
//  List
//
//  Created by Noah Portes Chaikin on 11/23/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"
#import "EventEditorAssetCell.h"
#import "Event.h"

typedef NS_ENUM(NSInteger, EventEditorDataSourceSection) {
    EventEditorDataSourceSectionAsset,
    EventEditorDataSourceSectionDetails
};

typedef NS_ENUM(NSInteger, EventEditorDataSourceCell) {
    EventEditorDataSourceCellAsset = 0,
    EventEditorDataSourceCellTitle = 0,
    EventEditorDataSourceCellStartTime,
    EventEditorDataSourceCellLocation,
    EventEditorDataSourceCellText
};

@interface EventEditorDataSource : NSObject <UITableViewDataSource>

- (instancetype)initWithEvent:(Event *)event;
- (void)registerReuseIdentifiersForTableView:(UITableView *)tableView;

@end
