//
//  DDSystemMessageModel.h
//  WitCity
//
//  Created by 方冬冬 on 2016/11/2.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDSystemMessageModel : YLModel

@property (nonatomic, copy) NSString *content_id;  //内容 id
@property (nonatomic, copy) NSString *title;       //标题
@property (nonatomic, copy) NSString *content;     //内容
@property (nonatomic, copy) NSString *inserttime;  //发布时间
@property (nonatomic, copy) NSString *url;         //内容详情页详细接口
@end
