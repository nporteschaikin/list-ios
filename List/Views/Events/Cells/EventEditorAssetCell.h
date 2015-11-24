//
//  EventEditorAssetCell.h
//  List
//
//  Created by Noah Portes Chaikin on 11/23/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"

@interface EventEditorAssetCell : ListUITableViewCell

@property (strong, nonatomic, readonly) UIImageView *assetView;
@property (nonatomic, getter=isHelperViewsVisible) BOOL helperViewsVisible;

@end
