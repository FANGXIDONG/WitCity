//
//  DDRecruitModel.h
//  WitCity
//
//  Created by 方冬冬 on 16/7/6.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

//招聘model

#import "YLModel.h"

@interface DDRecruitModel : YLModel

@property (nonatomic , copy) NSString *recruit_id;  //招聘id
@property (nonatomic , copy) NSString *thumb;       //公司logo
@property (nonatomic , copy) NSString *business;    //公司名称
@property (nonatomic , copy) NSString *exep;        //工作经验
@property (nonatomic , copy) NSString *worktype;    //1全职 2兼职 3实习
@property (nonatomic , copy) NSString *show;        //1显示 2隐藏
@property (nonatomic , copy) NSString *status;      //1审核通过 2审核中 3审核不通过
@property (nonatomic , copy) NSString *edu;         //学历1高中2中专3大专4本科5硕士6博士7博士后8学历不限
@property (nonatomic , copy) NSString *position;    //招聘职位
@property (nonatomic , copy) NSString *address;     //工作地点
@property (nonatomic , copy) NSString *salary;      //薪资  (1.2K以下，2.2-3K,3.3-5K,4.5-8K,5.8-10K,6.10K以上，7.面议)
@property (nonatomic , copy) NSString *inserttime;  //发布时间
@property (nonatomic , copy) NSString *url;         //内容详情数据接口
@property (nonatomic , copy) NSString *pages;       //总页数
@property (nonatomic , copy) NSString *phone;
@property (nonatomic , copy) NSString *person;

@property (nonatomic ,copy) NSString *workrequire; //职位要求
@property (nonatomic, copy) NSString *attact; //职位诱惑
@property (nonatomic , copy) NSString *industry; //行业
@property (nonatomic, copy) NSString *quality; //性质
@property (nonatomic , copy) NSString *size; //规模
@property (nonatomic, copy) NSString *summary; //公司简介



@end
