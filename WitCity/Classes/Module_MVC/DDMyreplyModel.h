//
//  DDMyreplyModel.h
//  WitCity
//
//  Created by 方冬冬 on 2016/11/2.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDMyreplyModel : YLModel

@property (nonatomic, copy) NSString *circle_id;    //帖子id
@property (nonatomic, copy) NSString *title;        //帖子标题
@property (nonatomic, copy) NSString *thumb;        //帖子标题
@property (nonatomic, copy) NSString *content;      //柳悟圈内容
@property (nonatomic, copy) NSString *inserttime;   //柳悟圈发布时间
@property (nonatomic, copy) NSString *rtalk;        //回复内容
@property (nonatomic, copy) NSString *rname;        //回复人姓名
@property (nonatomic, copy) NSString *rinserttime;  //回复时间
@property (nonatomic, copy) NSString *url;          //内容评论详情数据接口url
@end
