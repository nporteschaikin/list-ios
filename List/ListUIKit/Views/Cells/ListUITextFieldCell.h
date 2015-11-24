//
//  ListUITextFieldCell.h
//  List
//
//  Created by Noah Portes Chaikin on 11/23/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUITableViewCell.h"
#import "ListUITextField.h"

@interface ListUITextFieldCell : ListUITableViewCell

@property (strong, nonatomic, readonly) ListUITextField *textField;

@end
