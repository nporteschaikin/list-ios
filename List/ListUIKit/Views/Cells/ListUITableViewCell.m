//
//  ListUITableViewCell.m
//  List
//
//  Created by Noah Portes Chaikin on 11/23/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUITableViewCell.h"
#import "UIFont+ListUI.h"

@implementation ListUITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        /*
         * Set defaults
         */
        
        self.textLabel.font = [UIFont listUI_fontWithSize:15.f];
        self.detailTextLabel.font = [UIFont listUI_fontWithSize:15.f];
        
    }
    return self;
}

@end
