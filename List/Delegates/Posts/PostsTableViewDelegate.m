//
//  PostsTableViewDelegate.m
//  List
//
//  Created by Noah Portes Chaikin on 8/4/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PostsTableViewDelegate.h"
#import "PostViewController.h"
#import "UserViewController.h"
#import "UIFont+List.h"
#import "NSDate+TimeAgo.h"
#import "NSDateFormatter+List.h"
#import "Constants.h"

@interface PostsTableViewDelegate ()

@property (strong, nonatomic) PostsController *postsController;

@end

@implementation PostsTableViewDelegate

- (instancetype)initWithPostsController:(PostsController *)postsController {
    if (self = [super init]) {
        self.postsController = postsController;
    }
    return self;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Post *post = self.postsController.posts[indexPath.row];
    CGFloat width = CGRectGetWidth(tableView.bounds);
    CGFloat height = PostsTableViewCellPadding;
    CGFloat w;
    CGSize size;
    CGRect rect;
    NSString *string;
    UIFont *font;
    
    height += PostHeaderViewAvatarImageViewSize;
    height += PostsTableViewCellPadding;
    
    if (post.coverPhotoURL) {
        
        // cover photo
        height += (width * CoverPhotoHeightMultiplier) - (PostsTableViewCellPadding * 2);
        height += PostsTableViewCellPadding;
        
        // Content
        string = post.content;
        w = width - (PostsTableViewCellPadding * 2);
        size = CGSizeMake(w, CGFLOAT_MAX);
        font = [UIFont list_postContentFont];
        rect = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName: font } context:nil];
        height += rect.size.height;
        
        height += PostsTableViewCellPadding;
        
    } else {
        
        height += PostsTableViewCellPadding;
        height += PostsTableViewCellPadding;
        
        // Title
        string = post.title;
        w = width - (PostsTableViewCellPadding * 2);
        size = CGSizeMake(w, CGFLOAT_MAX);
        font = [UIFont list_textPostsTableViewCellTitleFont];
        rect = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName: font } context:nil];
        height += rect.size.height;
        
        height += (PostsTableViewCellPadding / 2);
        
        // Content
        string = post.content;
        size = CGSizeMake(w, CGFLOAT_MAX);
        font = [UIFont list_postContentFont];
        rect = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName: font } context:nil];
        height += rect.size.height;
        
        height += PostsTableViewCellPadding;
        
    }
    
    // thread count
    string = [NSString stringWithFormat:@"%ld", (unsigned long)post.threads.count];
    size = CGSizeMake(w, CGFLOAT_MAX);
    w = w - ([UIFont list_listLabelViewDefaultFont].lineHeight + 3.f);
    font = [UIFont list_listLabelViewDefaultFont];
    rect = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName: font } context:nil];
    height += rect.size.height;
    
    height += PostsTableViewCellPadding;
    
    return height + 1.0f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(CoverPostsTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
     * Style cell.
     */
    
    cell.indexPath = indexPath;
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
    
}

#pragma mark - ListTableViewCellDelegate

- (void)listTableViewCell:(CoverPostsTableViewCell *)cell viewTapped:(UIView *)view point:(CGPoint)point {
    NSIndexPath *indexPath = cell.indexPath;
    Post *post = self.postsController.posts[indexPath.row];
    UIViewController *viewController;
    if (view == cell.headerView.userNameLabel || view == cell.headerView.avatarImageView) {
        
        /*
         * Open user.
         */
        
        viewController = [[UserViewController alloc] initWithUser:post.user session:self.session];
        
    } else {
        
        /*
         * Open post.
         */
        
        viewController = [[PostViewController alloc] initWithPost:post session:self.session];
        
    }
    
    if (viewController) {
        [self.viewController presentViewController:viewController
                                          animated:YES
                                        completion:nil];
    }
    
}

@end
