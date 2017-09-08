//
//  YLNewsModel.h
//  WitCity
//
//  Created by simpletour on 16/6/1.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLModel.h"

@interface YLNewsModel : YLModel

@property (nonatomic, copy) NSString *content_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *avatar;    //头像
@property (nonatomic, copy) NSString *reply;     //回复数
@property (nonatomic, copy) NSString *name;      //姓名

@property (nonatomic, copy) NSString *isnew;   //标新

@property (nonatomic, copy) NSString *category;  //分类名称
@property (nonatomic, copy) NSString *thumb;     //缩略图
@property (nonatomic, copy) NSString *inserttime;//发布时间
@property (nonatomic, copy) NSString *collection;//收藏人数
@property (nonatomic, copy) NSString *status;    //收藏状态
@property (nonatomic, copy) NSString *url;       //内容详情页接口数据

@property (nonatomic, copy) NSString *module; //模板类型
@property (nonatomic, copy) NSString *person;//联系人
@property (nonatomic, copy) NSString *phone;//联系电话
@property (nonatomic, copy) NSString *pages;//总页数


@property (nonatomic, strong) NSArray *tag;//标签


@property (nonatomic, strong) NSNumber *reply_id;  //回复编号
@property (nonatomic, copy) NSString   *reply_name;//被回复人名
@property (nonatomic, copy) NSString   *rname;     //回复人名
@property (nonatomic, copy) NSString   *ravatar;   //头像
@property (nonatomic, copy) NSString   *rtalk;     //内容
@property (nonatomic, copy) NSString   *rinserttime;//时间

@end
