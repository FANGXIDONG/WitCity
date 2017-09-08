//
//  DDNewsModel.h
//  WitCity
//
//  Created by 方冬冬 on 16/7/13.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLModel.h"

@interface DDNewsModel : YLModel
@property (nonatomic, copy) NSString   *content_id;    //内容id
@property (nonatomic, copy) NSString   *thumb;         //图片
@property (nonatomic, copy) NSString   *url;           //web页
@property (nonatomic, copy) NSString   *category;      //分类（1.新闻 2.广告）
@property (nonatomic, copy) NSString   *doc;           //文字介绍
@end
