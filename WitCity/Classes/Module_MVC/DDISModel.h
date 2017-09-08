//
//  DDISModel.h
//  WitCity
//
//  Created by 方冬冬 on 16/8/5.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLModel.h"

@interface DDISModel : YLModel

@property (nonatomic, assign) BOOL   status;    //订购状态 Y订购 N非订购
@property (nonatomic, assign) int   code;         //操作码，0表示成功 1表示没有data数据
@property (nonatomic, copy) NSString   *msg;           //提示信息

@end
