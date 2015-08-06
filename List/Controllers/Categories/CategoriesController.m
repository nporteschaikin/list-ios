//
//  CategoriesController.m
//  List
//
//  Created by Noah Portes Chaikin on 7/23/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "CategoriesController.h"
#import "Constants.h"
#import "APIRequest.h"

@interface CategoriesController ()

@property (copy, nonatomic) NSArray *categories;

@end

@implementation CategoriesController

- (void)requestCategories {
    APIRequest *request = [[APIRequest alloc] init];
    request.method = APIRequestMethodGET;
    request.endpoint = APICategoriesEndpoint;
    
    /*
     * Send request.
     */
    
    if ([self.delegate respondsToSelector:@selector(categoriesControllerDidRequestCategories:)]) {
        [self.delegate categoriesControllerDidRequestCategories:self];
    }
    
    [request sendRequest:^(id<NSObject> body) {
        
        /*
         * Update post.
         */
        
        self.categories = [PostCategory fromArray:(NSArray *)body];
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(categoriesControllerDidFetchCategories:)]) {
            [self.delegate categoriesControllerDidFetchCategories:self];
        }
        
    } onError:^(NSError *error) {
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(categoriesController:failedToFetchCategoriesWithError:)]) {
            [self.delegate categoriesController:self
               failedToFetchCategoriesWithError:error];
        }
        
    } onFail:^(id<NSObject> body) {
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(categoriesController:failedToFetchCategoriesWithResponse:)]) {
            [self.delegate categoriesController:self failedToFetchCategoriesWithResponse:body];
        }
        
    }];
}

@end
