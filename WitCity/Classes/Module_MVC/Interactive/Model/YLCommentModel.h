//
//  YLCommentModel.h
//  WitCity
//
//  Created by simpletour on 16/6/14.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLModel.h"

@interface YLCommentModel : YLModel

@property (nonatomic, strong) NSNumber *reply_id;  //回复编号
@property (nonatomic, copy) NSString   *reply_name;//被回复人名
@property (nonatomic, copy) NSString   *rname;     //回复人名
@property (nonatomic, copy) NSString   *ravatar;   //头像
@property (nonatomic, copy) NSString   *rtalk;     //内容
@property (nonatomic, copy) NSString   *rinsertime;//时间

@end
