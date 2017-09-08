//
//  DDConfirmRechargeView.h
//  WitCity
//
//  Created by 方冬冬 on 2016/12/2.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLView.h"
#import "DDPayReq.h"
#import "DDRequestModel.h"

@interface DDConfirmRechargeView : YLView
@property (nonatomic, strong) UIView  *bgView;      //上部背景
-(void)setValuesWith:(DDPayReq *)req request:(DDRequestModel *)request;
@end
