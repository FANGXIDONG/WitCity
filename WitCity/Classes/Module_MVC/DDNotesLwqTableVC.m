//
//  DDNotesLwqTableVC.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/10.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDNotesLwqTableVC.h"
#import "YLLoginVC.h"            //登录vc
#import "YLLoginManager.h"       //登录管理对象
#import "DDLWQModel.h"
#import "DDMyNotesLWQTableView.h"

@interface DDNotesLwqTableVC ()
@property (nonatomic, strong) YLLoginManager    *loginManager;
@property (nonatomic, strong) DDMyNotesLWQTableView *lwqTableView;
@end

@implementation DDNotesLwqTableVC

#pragma mark - init
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addViews];
    [self refresh];
}

-(void)addViews
{
    [self.view addSubview:self.lwqTableView];
}

#pragma mark - getter


-(DDMyNotesLWQTableView *)lwqTableView
{
    if(!_lwqTableView) {
        _lwqTableView = [[DDMyNotesLWQTableView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2 - 40) style:UITableViewStylePlain];
        WS(wself);
        _lwqTableView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _lwqTableView;
}

-(YLLoginManager *)loginManager
{
    if(!_loginManager) {
        _loginManager = [[YLLoginManager alloc]initWithController:self];
    }
    return _loginManager;
}

#pragma mark - callback
-(void)callbackWithDict:(NSDictionary *)dict
{
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];

    switch (blockType) {
        case kDDBlockTypeNotesDelete:{
            
            LXAlertView *alert=[[LXAlertView alloc] initWithTitle:@"提示" message:@"是否要删除该数据" cancelBtnTitle:@"取消" otherBtnTitle:@"确定" clickIndexBlock:^(NSInteger clickIndex) {
                if (clickIndex == 1) {
                    [self deleteLwqWithCircle_id:dict[kYLValue]];
                }
            }];
            alert.animationStyle=LXASAnimationDefault;
            [alert showLXAlertView];
        }break;
        default:
            break;
    }
}

//删除柳梧圈
-(void)deleteLwqWithCircle_id:(NSString *)circle_id{
    
    [YLToast showToastWithView:self.view];
    [DDLifeHttpUtil deleteNotesOfLWQWithId:circle_id block:^(NSDictionary *dict) {
        [YLToast hiddenToastWithView:self.view];
        if ([dict[@"status"] intValue] == 1) {
            [self refresh];
        }
    } failure:^{
        //
    }];
}

#pragma mark - server
-(void)loadWithPage:(NSInteger)page append:(BOOL)append
{
    //发帖柳梧圈数据
    [self getLWQListDataWithPage:page append:append];
}

-(void)getLWQListDataWithPage:(NSInteger)page append:(BOOL)append{
    
    [DDLifeHttpUtil getMySendNotesOfLWQWithpage:page block:^(NSDictionary *dict) {
        NSArray *array = [DDLWQModel mj_objectArrayWithKeyValuesArray:dict];
        [self showDataWithTableView:self.lwqTableView dataList:array withFlag:0 append:append];
    } failure:^{
    }];
}


@end



