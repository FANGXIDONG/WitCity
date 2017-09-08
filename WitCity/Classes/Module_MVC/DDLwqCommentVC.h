//
//  DDLwqCommentVC.h
//  WitCity
//
//  Created by 方冬冬 on 16/7/25.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

//评论页面

#import "YLViewController.h"
#import "YLCommentHeaderView.h"
#import "DDLWQModel.h"

@interface DDLwqCommentVC : YLViewController

@property (nonatomic, assign) YLCommetnHeaderType type;
@property (nonatomic, strong) DDLWQModel *model;


@end
