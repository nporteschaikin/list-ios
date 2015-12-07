//
//  ListCollectionView.m
//  List
//
//  Created by Noah Portes Chaikin on 12/1/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListCollectionView.h"

@implementation ListCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        /*
         * Set defaults.
         */
        
        self.backgroundColor = [UIColor listUI_lightGrayColorAlpha:1.0f];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
    }
    return self;
}

@end
