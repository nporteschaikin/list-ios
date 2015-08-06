//
//  ListTextFieldCell.h
//  List
//
//  Created by Noah Portes Chaikin on 8/2/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListTableViewCell.h"
#import "LTextField.h"

@interface ListTextFieldCell : ListTableViewCell

@property (strong, nonatomic, readonly) LTextField *textField;

@end
