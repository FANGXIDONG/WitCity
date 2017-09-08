//
//  DDJobSeekModel.h
//  WitCity
//
//  Created by 方冬冬 on 16/7/6.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

//求职model

#import "YLModel.h"

@interface DDJobSeekModel : YLModel
@property (nonatomic , copy) NSString *qzhi_id;     //求职id
@property (nonatomic , copy) NSString *avatar;      //求职人员头像
@property (nonatomic , copy) NSString *name;        //求职人员姓名
@property (nonatomic , copy) NSString *experience;  //工作经验   - 获取
@property (nonatomic , copy) NSString *job;         //期望职位
@property (nonatomic , copy) NSString *salary;      //期望薪资
@property (nonatomic , copy) NSString *inserttime;  //发布时间
@property (nonatomic , copy) NSString *url;         //内容详情数据接口
@property (nonatomic , copy) NSString *pages;       //总页数

@property (nonatomic, copy) NSString *workType; //工作类型  1.全职 2.兼职
@property (nonatomic, copy) NSString *gender; //性别  1男 2女
@property (nonatomic, copy) NSString *birth;  //出生日期
@property (nonatomic, copy) NSString *phone;  //联系电话
@property (nonatomic, copy) NSString *email;  //联系邮箱
@property (nonatomic, copy) NSString *exep;  //工作经验   - 发布
@property (nonatomic, strong) NSArray *history; //工作经历
@property (nonatomic ,copy) NSString *company;//公司名称
@property (nonatomic, copy) NSString *wtime;//工作时段
@property (nonatomic, copy) NSString *work;//工作内容
//@property (nonatomic, copy) NSString *job; //期望工作


@property (nonatomic , copy) NSString *college;    //学校
@property (nonatomic , copy) NSString *edu;         //学历
@property (nonatomic , copy) NSString *status;       //1审核通过 2审核中 3审核不通过
@property (nonatomic , copy) NSString *show;    //1显示 2隐藏
@end














