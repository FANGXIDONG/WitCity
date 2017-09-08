//
//  DDPublishRecruitVC.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/17.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDPublishRecruitVC.h"
#import "DDPublishRecruitTableView.h"
#import "YLLoginManager.h"

@interface DDPublishRecruitVC()

@property (nonatomic, strong) DDPublishRecruitTableView *recruitTableView;
@property (nonatomic, strong) YLLoginManager *loginManager;

@end

@implementation DDPublishRecruitVC

-(void)viewDidLoad{
    NSString *title;
    if ([self.flag isEqualToString:@"招聘更新"]) {
        title = @"编辑-招聘";
    }else{
        title = @"发布-招聘";
    }
    self.navigationItem.title = title;
    self.navigationItem.leftBarButtonItem = [self buttonForPublishVCNavigationBarWithAction:@selector(leftClick) imageNamed:@"navi_back"];
    [self addViews];
}

-(void)addViews{
    
    [self.view addSubview:self.recruitTableView];
}
-(YLLoginManager *)loginManager
{
    if(!_loginManager) {
        _loginManager = [[YLLoginManager alloc]initWithController:self];
    }
    return _loginManager;
}


-(DDPublishRecruitTableView *)recruitTableView{
    
    if(!_recruitTableView) {
        _recruitTableView  = [[DDPublishRecruitTableView alloc] initWithFrame:CGRectMake(0,0, WINDOW_WIDTH, CONTENT_HEIGHT2) style:UITableViewStylePlain];
    }
    //滑动到最底端
    [_recruitTableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionBottom animated:YES];
    WS(wself);
    _recruitTableView.allBlock = ^(NSDictionary *dict) {
        [wself callbackWithDict:dict];
    };
    if ([self.flag isEqualToString:@"招聘更新"]) {
        [_recruitTableView setUpdateRecruitDataWithModel:self.model];
    }
    return _recruitTableView;
}

#pragma mark - callback
-(void)callbackWithDict:(NSDictionary *)dict
{
    
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    
    switch (blockType) {
        case kDDBlockTypePublishAction:
        {
            DDRecruitModel *recruitModel = dict[kYLModel];
            [self publish:recruitModel];
        }break;
        default:
            break;
    }
}

//发布招聘
-(void)publish:(DDRecruitModel *)model{
 
    [self.loginManager pushCheckedLoginWithPopToRoot:NO block:^{
        
        [DDLifeHttpUtil publishRecruitWithThumb:model.thumb business:model.business position:model.position workrequire:model.workrequire address:model.address salary:model.salary exep:model.exep edu:model.edu worktype:model.worktype attact:model.attact industry:model.industry quality:model.quality size:model.size summary:model.summary person:model.person phone:model.phone Block:^(NSDictionary *dict) {
            
            if ([dict[@"status"] intValue] == 1) {
                [YLToast showToastInKeyWindowWithText:@"发布成功"];
                [self leftClick];
            }
          
        } failure:^{
            //
        }];
//        [YLToast showToastInKeyWindowWithText:@"发布成功"];
//        // 延迟2秒执行：
//        double delayInSeconds = 1.5;
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//            [self leftClick];
//        });

    }];
}


-(void)leftClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end


















