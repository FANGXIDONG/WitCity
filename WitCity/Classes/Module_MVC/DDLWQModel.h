//
//  DDLWQModel.h
//  WitCity
//
//  Created by 方冬冬 on 16/7/6.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

//柳梧圈model

#import "YLModel.h"

@class DDContentImageModel;
@interface DDLWQModel : YLModel
@property (nonatomic , copy) NSString *circle_id;   //柳梧圈帖子id
@property (nonatomic , copy) NSString *name;        //发布人昵称
@property (nonatomic , copy) NSString *avatar;      //头像
@property (nonatomic , copy) NSString *thumb;       //图片
@property (nonatomic , copy) NSString *title;       //标题
@property (nonatomic , copy) NSString *content;     //内容
@property (nonatomic , copy) NSString *reply;       //回复人数
@property (nonatomic , copy) NSString *inserttime;  //发布时间
@property (nonatomic , copy) NSString *url;         //内容详情数据接口
@property (nonatomic , copy) NSString *pages;       //总页数

@property (nonatomic , copy) NSString *status;       //1审核通过 2审核中 3审核通过

@property (nonatomic, strong) NSMutableArray <DDContentImageModel*>* imageArray;

-(instancetype)initWithDict:(NSDictionary *)dict;
@end


@interface DDContentImageModel : NSObject

@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@end















