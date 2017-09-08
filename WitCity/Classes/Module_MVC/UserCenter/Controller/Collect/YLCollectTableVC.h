//
//  YLCollectTableVC.h
//  WitCity
//
//  Created by simpletour on 16/5/27.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLListViewController.h"
#import "YLCategoryModel.h"

@interface YLCollectTableVC : YLListViewController

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) YLCategoryModel *model;

@end
