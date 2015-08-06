//
//  PostEditorDataSource.m
//  List
//
//  Created by Noah Portes Chaikin on 8/2/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PostEditorDataSource.h"
#import "UIImageView+WebCache.h"
#import "NSDateFormatter+List.h"

@interface PostEditorDataSource ()

@property (strong, nonatomic) PostController *postController;

@end

@implementation PostEditorDataSource

static NSString * const ListGeneralCellReuseIdentifier = @"ListGeneralCellReuseIdentifier";
static NSString * const ListTextFieldCellReuseIdentifier = @"ListTextFieldCellReuseIdentifier";
static NSString * const ListPhotoTextViewCellReuseIdentifier = @"ListTextViewCellReuseIdentifier";
static NSString * const ListTextViewCellReuseIdentifier = @"ListTextViewCellReuseIdentifier";
static NSString * const ListPhotoTextFieldCellReuseIdentifier = @"ListPhotoTextFieldCellReuseIdentifier";

- (instancetype)initWithPostController:(PostController *)postController {
    if (self = [super init]) {
        self.postController = postController;
    }
    return self;
}

- (void)registerReuseIdentifiersForTableView:(UITableView *)tableView {
    [tableView registerClass:[ListTextFieldCell class]
      forCellReuseIdentifier:ListTextFieldCellReuseIdentifier];
    [tableView registerClass:[ListTextViewCell class]
      forCellReuseIdentifier:ListTextViewCellReuseIdentifier];
    [tableView registerClass:[ListPhotoTextViewCell class]
      forCellReuseIdentifier:ListPhotoTextViewCellReuseIdentifier];
    [tableView registerClass:[ListGeneralCell class]
      forCellReuseIdentifier:ListGeneralCellReuseIdentifier];
    [tableView registerClass:[ListPhotoTextFieldCell class]
      forCellReuseIdentifier:ListPhotoTextFieldCellReuseIdentifier];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Post *post = self.postController.post;
    User *user = self.postController.session.user;
    NSInteger row = indexPath.row;
    
    UITableViewCell *cell;
    switch (row) {
        case PostEditorDataSourceRowsTitle: {
            
            // Title
            ListPhotoTextFieldCell *photoTextFieldCell = [tableView dequeueReusableCellWithIdentifier:ListPhotoTextFieldCellReuseIdentifier];
            photoTextFieldCell.textField.text = post.title;
            photoTextFieldCell.textField.placeholder = @"Title";
            [photoTextFieldCell.photoView sd_setImageWithURL:user.profilePictureURL];
            cell = photoTextFieldCell;
            
            break;
        }
        case PostEditorDataSourceRowsCategory: {
            
            // Category
            ListGeneralCell *generalCell = [tableView dequeueReusableCellWithIdentifier:ListGeneralCellReuseIdentifier];
            PostCategory *category = post.category;
            generalCell.textLabel.text = @"Category";
            generalCell.detailTextLabel.text = category.name;
            cell = generalCell;
            
            break;
        }
    }
    switch (post.type) {
        case PostTypeEvent: {
            Event *event = post.event;
            switch (row) {
                case PostEditorDataSourceRowsEventTime: {
                    
                    // Event time
                    ListGeneralCell *generalCell = [tableView dequeueReusableCellWithIdentifier:ListGeneralCellReuseIdentifier];
                    generalCell.textLabel.text = @"Date & Time";
                    generalCell.detailTextLabel.text = [[NSDateFormatter list_defaultDateFormatter] stringFromDate:event.startTime];
                    generalCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell = generalCell;
                    break;
                    
                }
                case PostEditorDataSourceRowsEventPlace: {
                    
                    // Event place
                    ListTextFieldCell *textFieldCell = [tableView dequeueReusableCellWithIdentifier:ListTextFieldCellReuseIdentifier];
                    textFieldCell.textField.text = event.place;
                    textFieldCell.textField.placeholder = @"Where?";
                    cell = textFieldCell;
                    break;
                    
                }
                case PostEditorDataSourceRowsEventContent: {
                    
                    // Event content.
                    ListPhotoTextViewCell *textViewCell = [tableView dequeueReusableCellWithIdentifier:ListTextViewCellReuseIdentifier];
                    textViewCell.textView.text = post.content;
                    textViewCell.textView.placeholder = @"Description";
                    cell = textViewCell;
                    break;
                    
                }
            }
            break;
        }
            
        case PostTypePost: {
            switch (row) {
                case PostEditorDataSourceRowsPostContent: {
                    // Post content
                    ListPhotoTextViewCell *textViewCell = [tableView dequeueReusableCellWithIdentifier:ListTextViewCellReuseIdentifier];
                    textViewCell.textView.text = post.content;
                    textViewCell.textView.placeholder = @"Description";
                    cell = textViewCell;
                    break;
                }
            }
            
            break;
        }
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Post *post = self.postController.post;
    switch (post.type) {
        case PostTypeEvent: {
            return 5;
        }
        default: {
            return 3;
        }
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end
