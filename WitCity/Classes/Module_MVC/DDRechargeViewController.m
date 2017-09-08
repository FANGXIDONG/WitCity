
//
//  DDRechargeViewController.m
//  WitCity
//
//  Created by 方冬冬 on 2016/11/29.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDRechargeViewController.h"
#import "DDRechargeView.h"
#import "DDPayReq.h"    
#import "DDRequestModel.h"
#import "DDConfirmRechargeVC.h"

@interface DDRechargeViewController ()
@property (nonatomic, strong) DDRechargeView *rechareView;
@end

@implementation DDRechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@"手机充值"];
    [self addViews];
}

-(void)addViews{
    [self.view addSubview:self.rechareView];
}

-(DDRechargeView *)rechareView{
    if(!_rechareView) {
        _rechareView = [[DDRechargeView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2)];
        WS(wself);
        _rechareView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _rechareView;
}

#pragma mark - callback
-(void)callbackWithDict:(NSDictionary *)dict
{
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    switch (blockType) {
        case kDDBlockTypeWechatPayCreateOrder:{
            DDRequestModel *rModel = dict[kYLModel];
            [self pushComfirmOrderVC:rModel];
        }break;
    }
}

-(void)pushComfirmOrderVC:(DDRequestModel *)model{
    
    model.phone = self.rechareView.phoneTxt.text;
    
    if (model.phone == nil || [model.phone isEqualToString:@""]) {
        [YLToast showToastInKeyWindowWithText:@"请填写手机号码"];
    }
    else if (model.phone.length != 11) {
        [YLToast showToastInKeyWindowWithText:@"手机号码为11位"];
    }
    else if (![self validatePhoneWithPhone:model.phone]) {
        [YLToast showToastInKeyWindowWithText:@"请填写正确的手机号码"];
    }
   else if (model.money == nil || [model.money isEqualToString:@""]) {
        [YLToast showToastInKeyWindowWithText:@"请选择充值金额"];
    }else{
        DDConfirmRechargeVC *crVC = [[DDConfirmRechargeVC alloc] init];
        crVC.rModel = model;
        [self.navigationController pushViewController:crVC animated:YES];
    }
}

- (BOOL)validatePhoneWithPhone:(NSString *)phone
{
    phone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (phone.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:phone];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:phone];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:phone];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
//    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9]))\\d{8}$";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    return [pred evaluateWithObject:phone];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end






















