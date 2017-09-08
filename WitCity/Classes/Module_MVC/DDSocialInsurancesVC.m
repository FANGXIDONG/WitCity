//
//  SocialInsurancesVC.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/29.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDSocialInsurancesVC.h"
#import "DDSIInquireResultOrOpenVC.h"
#import "DDResponseModel.h"

@interface DDSocialInsurancesVC ()

@property (nonatomic, strong) DDSocialInsurancesView *insurancesView;

@end

@implementation DDSocialInsurancesVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addViews];
}

-(void)addViews{
    
    [self.view addSubview:self.insurancesView];
}

-(DDSocialInsurancesView *)insurancesView{
    
    if (!_insurancesView) {
        _insurancesView = [[DDSocialInsurancesView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2)];
        
        _insurancesView.type = self.statusType;
        WS(wself);
        _insurancesView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
        switch (_insurancesView.type) {
            case kDDSocialInsuranceViewTypeInquiry:
            {
                [self navigationWithTitle:@"社保查询"];
            }break;
            case kDDSocialInsuranceViewTypeOpenIntroduce:
            {
                [self navigationWithTitle:@"业务介绍"];;
            }
                
            default:
                break;
        }
    }
    return _insurancesView;
}

-(void)callbackWithDict:(NSDictionary *)dict{
    
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    
    switch (blockType) {
        case kDDBlockTypeSocialInsurnceInquire:
        {
            
            NSString *inquireType = dict[kYLValue];
//            [self pushStepVCWithType:0];
            [self judgeSocialInsuranceRelationShip:inquireType];
        }
            break;
        case kDDBlockTypeSocialInsurnceOpen:
        {
//            [self pushStepVCWithType:1];
        }
            break;
            
        default:
            break;
    }
}

-(void)judgeSocialInsuranceRelationShip:(NSString *)type{
//    [self showHudWithTitle:@"正在查询..."];
    [YLToast showToastWithView:self.view];
    [DDLifeHttpUtil getSocialInsuranceRelationshipWithPhone:nil Block:^(NSDictionary *dict) {
//    [self hideHud];
        [YLToast hiddenToastWithView:self.view];
        DDSIInquireResultOrOpenVC *inquireOrOpen = [[DDSIInquireResultOrOpenVC alloc] init];
        if ([ dict[@"status"] isEqualToString:@"N"]) {
            [self.navigationController pushViewController:inquireOrOpen animated:YES];
        }
        if ([ dict[@"status"] isEqualToString:@"Y"]) {
            NSString *str ;
            if ([type intValue] == 0) {
                str = @"余额";
                [self callRestMoney:type];
            }
            if ([type intValue] == 1) {
                str = @"仅两笔消费";
                [self callRecentSepend:type];
            }
            

        }
    } failure:^{
        //创建无数据内容
//        [self createTableViewAndFooterView];
    }];
}

//余额接口
-(void)callRestMoney:(NSString *)str{
    
    [DDLifeHttpUtil inquireSocialInsuranceCardMoneyDetailBlock:^(NSDictionary *dict) {
        
        NSString *message = [NSString  stringWithFormat:@"%@信息已发送",str];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:@"您的账户信息将会发送到您的手机上，请注意查收" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:NO completion:nil];
        
       
        
        
    } failure:^{
        //
    }];
}
//近两笔消费接口
-(void)callRecentSepend:(NSString *)str{
    
    [DDLifeHttpUtil inquireSocialInsuranceConsumeDetailBlock:^(NSDictionary *dict) {
        
        NSString *message = [NSString  stringWithFormat:@"%@信息已发送",str];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:@"您的账户信息将会发送到您的手机上，请注意查收" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:NO completion:nil];
    } failure:^{
        //
    }];
}

//-(void)pushStepVCWithType:(NSInteger)type{
//    
//   
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
