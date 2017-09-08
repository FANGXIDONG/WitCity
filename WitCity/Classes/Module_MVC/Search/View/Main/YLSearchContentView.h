//
//  YLSearchContentView.h
//  WitCity
//
//  Created by simpletour on 16/5/20.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLView.h"
#import "YLCategoryModel.h"

@interface YLSearchContentView : YLView

@property (nonatomic, strong) YLCategoryModel *model;

- (void)updateWithArray:(NSArray *)array;

@end
