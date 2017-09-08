//
//  DDSIInquireResultOrOpenVC.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/1.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDSIInquireResultOrOpenVC.h"
#import "DDSocialInsurancesView.h"
#import "DDSIOpenViewController.h"

@interface DDSIInquireResultOrOpenVC ()

@property (nonatomic, strong) DDSocialInsurancesView *insurancesView;
@end

@implementation DDSIInquireResultOrOpenVC

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
        
//        if ([_typeFlag intValue] == 0) {
//             _insurancesView.type = kDDSocialInsuranceViewTypeAccountInfo;
//        }
//        if ([_typeFlag intValue] ==1) {
           _insurancesView.type = kDDSocialInsuranceViewTypeOpenIntroduce;
//        }
        WS(wself);
        _insurancesView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
//        switch (_insurancesView.type) {
//            case kDDSocialInsuranceViewTypeAccountInfo:
//            {
//                [self navigationWithTitle:@"账户信息"];
//            }break;
//            case kDDSocialInsuranceViewTypeOpen:
//            {
                [self navigationWithTitle:@"业务介绍"];
//            }
//                
//            default:
//                break;
//        }
    }
    return _insurancesView;
}

-(void)callbackWithDict:(NSDictionary *)dict{
    
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    
    switch (blockType) {
        case kDDBlockTypeWatchRencentTwoConsume:
        {
            NSLog(@"近两笔消费");
        }
            break;
        case kDDBlockTypeSocialInsurnceOpen:
        {
//            NSLog(@"开通");
            [self.navigationController pushViewController:[DDSIOpenViewController new] animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end








