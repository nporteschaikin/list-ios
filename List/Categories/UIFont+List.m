//
//  UIFont+List.m
//  List
//
//  Created by Noah Portes Chaikin on 7/1/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "UIFont+List.h"
#import "Constants.h"

@implementation UIFont (List)

+ (UIFont *)list_postViewDetailsCellTitleFont {
    return [self fontWithName:ListFontSemiboldName
                         size:15.0f];
}

+ (UIFont *)list_postViewDetailsCellUserNameFont {
    return [self fontWithName:ListFontSemiboldName
                         size:12.0f];
}

+ (UIFont *)list_postViewDetailsCellDateFont {
    return [self fontWithName:ListFontLightName
                         size:12.0f];
}

+ (UIFont *)list_postViewDetailsCellTextFont {
    return [self fontWithName:ListFontName
                         size:15.0f];
}

+ (UIFont *)list_postHeaderViewUserNameFont {
    return [self fontWithName:ListFontSemiboldName
                         size:12.0f];
}

+ (UIFont *)list_postHeaderViewLocationFont {
    return [self list_postHeaderViewUserNameFont];
}

+ (UIFont *)list_postHeaderViewDateFont {
    return [self fontWithName:ListFontLightName
                         size:12.0f];
}

+ (UIFont *)list_textPostsTableViewCellTitleFont {
    return [self fontWithName:ListFontSemiboldName
                         size:15.0f];
}

+ (UIFont *)list_coverPostsTableViewCellTitleFont {
    return [self fontWithName:ListFontSemiboldName
                         size:15.0f];
}

+ (UIFont *)list_postContentFont {
    return [self fontWithName:ListFontName
                         size:13.0f];
}

+ (UIFont *)list_headerViewFont {
    return [self fontWithName:ListFontSemiboldName
                         size:14.0f];
}

+ (UIFont *)list_buttonFont {
    return [self fontWithName:ListFontName
                         size:15.0f];
}

+ (UIFont *)list_lTextFieldFont {
    return [self fontWithName:ListFontName
                         size:15.0f];
}

+ (UIFont *)list_lTextViewFont {
    return [self list_lTextFieldFont];
}

+ (UIFont *)list_listGeneralCellTextFont {
    return [self list_lTextFieldFont];
}

+ (UIFont *)list_listGeneralCellDetailsFont {
    return [self list_lTextFieldFont];
}

+ (UIFont *)list_postEditorViewHeaderFont {
    return [self fontWithName:ListFontSemiboldName
                         size:12.0f];
}

+ (UIFont *)list_locationBarViewFont {
    return [self fontWithName:ListFontSemiboldName
                         size:14.0f];
}

+ (UIFont *)list_postsTableViewStatusMessageFont {
    return [self fontWithName:ListFontSemiboldName
                         size:11.0f];
}

+ (UIFont *)list_threadsTableViewCellUserNameFont {
    return [self fontWithName:ListFontSemiboldName
                         size:13.0f];
}

+ (UIFont *)list_threadsTableViewCellContentFont {
    return [self fontWithName:ListFontName
                         size:13.0f];
}

+ (UIFont *)list_threadsTableViewCellDateFont {
    return [self fontWithName:ListFontLightName
                         size:11.0f];
}

+ (UIFont *)list_messagesTableViewCellUserNameFont {
    return [self list_threadsTableViewCellUserNameFont];
}

+ (UIFont *)list_messagesTableViewCellContentFont {
    return [self list_threadsTableViewCellContentFont];
}

+ (UIFont *)list_messagesTableViewCellDateFont {
    return [self list_threadsTableViewCellDateFont];
}

+ (UIFont *)list_messagesFormViewSaveButtonFont {
    return [self fontWithName:ListFontSemiboldName
                         size:18.0f];
}

+ (UIFont *)list_messagesFormViewTextViewFont {
    return [self fontWithName:ListFontName
                         size:18.0f];
}

+ (UIFont *)list_threadsFormViewSaveButtonFont {
    return [self fontWithName:ListFontSemiboldName
                         size:18.0f];
}

+ (UIFont *)list_threadsFormViewPrivacyButtonFont {
    return [self fontWithName:ListFontSemiboldName
                         size:12.0f];
}

+ (UIFont *)list_threadsFormViewTextViewFont {
    return [self fontWithName:ListFontName
                         size:18.0f];
}

+ (UIFont *)list_postsSearchBarFont {
    return [self fontWithName:ListFontSemiboldName
                         size:14.0f];
}

+ (UIFont *)list_userViewCoverPhotoCellNameFont {
    return [self fontWithName:ListFontLightName
                         size:20.0f];
}

+ (UIFont *)list_menuViewFooterLocationFont {
    return [self fontWithName:ListFontSemiboldName
                         size:14.0f];
}

+ (UIFont *)list_menuViewFooterSignOutFont {
    return [self list_menuViewFooterLocationFont];
}

+ (UIFont *)list_menuTableViewCellTitleFont {
    return [self fontWithName:ListFontLightName
                         size:25.0f];
}

+ (UIFont *)list_navigationBarTitleFont {
    return [self fontWithName:ListFontSemiboldName
                         size:15.0f];
}

+ (UIFont *)list_notificationsTableViewCellContentFont {
    return [self fontWithName:ListFontName
                         size:13.0f];
}

+ (UIFont *)list_notificationsTableViewCellBoldFont {
    return [self fontWithName:ListFontSemiboldName
                         size:13.0f];
}

+ (UIFont *)list_notificationsTableViewCellDateFont {
    return [self fontWithName:ListFontLightName
                         size:12.0f];
}

+ (UIFont *)list_loginViewLabelFont {
    return [self fontWithName:ListFontLightName
                         size:20.0f];
}

+ (UIFont *)list_settingsTableViewSectionHeaderFont {
    return [self fontWithName:ListFontSemiboldName
                         size:10.0f];
}

+ (UIFont *)list_settingsTableViewSectionFooterFont {
    return [self fontWithName:ListFontName
                         size:12.0f];
}

+ (UIFont *)list_settingsTableViewCellTextFont {
    return [self fontWithName:ListFontName
                         size:15.0f];
}

+ (UIFont *)list_listPhotoCellLabelFont {
    return [self fontWithName:ListFontSemiboldName
                         size:15.0f];
}

+ (UIFont *)list_createPostButtonFont {
    return [self fontWithName:ListFontLightName
                         size:25.0f];
}

+ (UIFont *)list_postsTableViewCellEventsViewTimeFont {
    return [self fontWithName:ListFontSemiboldName
                         size:14.0f];
}

+ (UIFont *)list_postsTableViewCellEventsViewPlaceFont {
    return [self fontWithName:ListFontLightName
                         size:14.0f];
}

+ (UIFont *)list_listLabelViewDefaultFont {
    return [self fontWithName:ListFontSemiboldName
                         size:11.0f];
}

+ (UIFont *)list_listIconTableViewCellFont {
    return [self fontWithName:ListFontSemiboldName
                         size:13.0f];
}

+ (UIFont *)list_userViewBioCellFont {
    return [self fontWithName:ListFontName
                         size:14.0f];
}

@end
