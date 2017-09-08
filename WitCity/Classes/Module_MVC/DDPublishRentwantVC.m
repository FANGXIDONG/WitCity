
//
//  DDPublishRentwantVC.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/12.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDPublishRentwantVC.h"
#import "DDPublishRentwantTableView.h"
#import "DDRentWantModel.h"
#import "YLLoginManager.h"

@interface DDPublishRentwantVC ()

@property (nonatomic, strong) DDPublishRentwantTableView *rwTableView;
@property (nonatomic, strong) YLLoginManager *loginManager;
@end

@implementation DDPublishRentwantVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发布-求租";
    self.navigationItem.leftBarButtonItem = [self buttonForPublishVCNavigationBarWithAction:@selector(leftClick) imageNamed:@"navi_back"];
    [self addViews];
}

-(void)addViews{
    [self.view addSubview:self.rwTableView];
}


-(YLLoginManager *)loginManager
{
    if(!_loginManager) {
        _loginManager = [[YLLoginManager alloc]initWithController:self];
    }
    return _loginManager;
}

-(DDPublishRentwantTableView *)rwTableView
{
    if(!_rwTableView) {
        _rwTableView  = [[DDPublishRentwantTableView alloc] initWithFrame:CGRectMake(0,0, WINDOW_WIDTH, CONTENT_HEIGHT2) style:UITableViewStylePlain];
    }
    WS(wself);
    _rwTableView.allBlock = ^(NSDictionary *dict) {
        [wself callbackWithDict:dict];
    };
    return _rwTableView;
}

#pragma mark  - callback
-(void)callbackWithDict:(NSDictionary *)dict{
    
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    switch (blockType) {
      
        case kDDBlockTypePublishAction:
        {
            DDRentWantModel *rwModel = dict[kYLModel];
            //发布
            [self publish:rwModel];
        }break;
            
        default:
            break;
    }
}

-(void)publish:(DDRentWantModel *)model{
    
    
    [self.loginManager pushCheckedLoginWithPopToRoot:NO block:^{
        
//        [YLToast showToastInKeyWindowWithText:@"发布成功"];
//        // 延迟2秒执行：
//        double delayInSeconds = 1.5;
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//            [self leftClick];
//        });
        
        [DDLifeHttpUtil publishRentWantWithTitle:model.title area:model.area type:model.type price:model.price summary:model.summary person:model.person phone:model.phone Block:^(NSDictionary *dict) {
            if ([dict[@"status"] intValue] == 1) {
                [YLToast showToastInKeyWindowWithText:@"发布成功"];
                [self leftClick];
            }
        } failure:^{
            //
        }];
        
        
    }];
    
}


-(void)leftClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end



