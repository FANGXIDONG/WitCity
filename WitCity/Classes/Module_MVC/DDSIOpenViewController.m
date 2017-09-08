
//
//  DDSIOpenViewController.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/15.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDSIOpenViewController.h"
#import "DDSocialInsurancesView.h"
#import "DDSINumberModel.h"

@interface DDSIOpenViewController()
@property (nonatomic, strong) DDSocialInsurancesView *insurancesView;
@end

@implementation DDSIOpenViewController


-(void)viewDidLoad{
    
    
    [self addViews];
}

-(void)addViews{
    
    [self.view addSubview:self.insurancesView];
}

-(DDSocialInsurancesView *)insurancesView{
    
    if (!_insurancesView) {
        _insurancesView = [[DDSocialInsurancesView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2)];
        _insurancesView.type = kDDSocialInsuranceViewTypeOpen;
        WS(wself);
        _insurancesView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
        [self navigationWithTitle:@"开通社保"];

    }
    return _insurancesView;
}

-(void)callbackWithDict:(NSDictionary *)dict{
    
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    
    switch (blockType) {
        case kDDBlockTypeSocialInsurnceOpenConfirmed:
        {
           DDSINumberModel *model = dict[kYLModel];
            [self openSIConfirmedAction:model];
        }
            break;
        default:
            break;
    }
}

//开通社保
-(void)openSIConfirmedAction:(DDSINumberModel *)model{
    
    [DDLifeHttpUtil orderSocialInsuranceWithSocialNumber:model.siNumber orSocialCardNumber:model.sicardNumber Block:^(NSDictionary *dict) {
        //
        NSLog(@"%@",dict);
        
    } failure:^{
        //
    }];
}

@end








