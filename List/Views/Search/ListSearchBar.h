//
//  ListSearchBar.h
//  List
//
//  Created by Noah Portes Chaikin on 11/25/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"

@class ListSearchBar;

@protocol ListSearchBarDelegate <NSObject>

@optional;
- (BOOL)searchBarShouldBeginEditing:(ListSearchBar *)searchBar;
- (void)searchBarTextDidBeginEditing:(ListSearchBar *)searchBar;
- (BOOL)searchBarShouldEndEditing:(ListSearchBar *)searchBar;
- (void)searchBarTextDidEndEditing:(ListSearchBar *)searchBar;
- (void)searchBar:(ListSearchBar *)searchBar textDidChange:(NSString *)searchText;
- (BOOL)searchBar:(ListSearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;

@end

@interface ListSearchBar : UIView

@property (weak, nonatomic) id<ListSearchBarDelegate> delegate;
@property (weak, nonatomic, readonly) NSString *text;
@property (weak, nonatomic) NSString *placeholder;

@end
