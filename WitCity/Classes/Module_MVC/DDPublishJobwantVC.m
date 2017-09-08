
//
//  DDPublishJobwantVC.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/12.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDPublishJobwantVC.h"
#import "DDPublishJobwantTableView.h"
#import "DDJobSeekModel.h"
#import "YLLoginManager.h"
//#import "DDUtils.h"

@interface DDPublishJobwantVC ()

@property (nonatomic, strong) DDPublishJobwantTableView *jwTableView;
@property (nonatomic, strong) YLLoginManager *loginManager;

@end

@implementation DDPublishJobwantVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发布-求职";
    self.navigationItem.leftBarButtonItem = [self buttonForPublishVCNavigationBarWithAction:@selector(leftClick) imageNamed:@"navi_back"];
    [self addViews];
}

-(void)addViews{
    
    [self.view addSubview:self.jwTableView];
}

-(YLLoginManager *)loginManager
{
    if(!_loginManager) {
        _loginManager = [[YLLoginManager alloc]initWithController:self];
    }
    return _loginManager;
}


-(DDPublishJobwantTableView *)jwTableView{
    
    if(!_jwTableView) {
        _jwTableView  = [[DDPublishJobwantTableView alloc] initWithFrame:CGRectMake(0,0, WINDOW_WIDTH, CONTENT_HEIGHT2) style:UITableViewStylePlain];
    }
    //滑动到最底端
    [_jwTableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
//    _jwTableView.tableFooterView = self.bottomView;
    WS(wself);
    _jwTableView.allBlock = ^(NSDictionary *dict) {
        [wself callbackWithDict:dict];
    };
    return _jwTableView;
}

#pragma mark - callback
-(void)callbackWithDict:(NSDictionary *)dict
{
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    
    switch (blockType) {
        case kDDBlockTypePublishAction:
        {
            DDJobSeekModel *jsModel = dict[kYLModel];
            [self publish:jsModel];
            
        }break;
        default:
            break;
    }
}

//发布求职
-(void)publish:(DDJobSeekModel *)model{
    
    if ([DDUtils checkEmailAddress:model.email]) {
        
        [self.loginManager pushCheckedLoginWithPopToRoot:NO block:^{
            
//            [YLToast showToastInKeyWindowWithText:@"发布成功"];
//            // 延迟2秒执行：
//            double delayInSeconds = 1.5;
//            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//                [self leftClick];
//            });
            
            [DDLifeHttpUtil publishJobSeekWithName:model.name gender:model.gender college:model.college edu:model.edu birth:model.birth phone:model.phone email:model.email exep:model.exep history:model.history job:model.job worktype:model.workType salary:model.salary Block:^(NSDictionary *dict) {
                
                
                
                
            } failure:^{
                //
            }];
            
        }];
    }else{
        [YLToast showToastInKeyWindowWithText:@"请输入合法的邮箱"];
    }
}

-(void)leftClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end




