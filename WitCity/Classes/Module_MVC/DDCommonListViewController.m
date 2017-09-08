
//
//  DDCommonListViewController.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/6.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDCommonListViewController.h"
#import "DDRecruitListTableView.h"
#import "DDLifeHttpUtil.h"
#import "DDRentOutModel.h"    //出租model
#import "DDRentWantModel.h"
#import "DDJobSeekModel.h"
#import "DDLWQModel.h"
#import "DDLwqCommentVC.h"
#import "DDBrowserImageInfo.h"
#import "DDDefaultVC.h" 
#import "DDRentoutDetailViewController.h"

@interface DDCommonListViewController ()<MWPhotoBrowserDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) DDRecruitListTableView *tableView;
@property (nonatomic, strong) DDBrowserImageInfo *browserImg;
@end

@implementation DDCommonListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:self.naviTitle];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    [self addViews];
    [self refresh];
    //**************方法一****************//
    //设置滑动回退
    __weak typeof(self) weakSelf = self;
    self.navigationController.interactivePopGestureRecognizer.delegate = weakSelf;
    //判断是否为第一个view
    if (self.navigationController && [self.navigationController.viewControllers count] == 1) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
#pragma mark- UIGestureRecognizerDelegate
//**************方法一****************//
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}

-(void)addViews
{
    [self.view addSubview:self.tableView];
}

-(DDRecruitListTableView *)tableView
{
    if(!_tableView) {
        _tableView = [[DDRecruitListTableView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2) style:UITableViewStylePlain];
        WS(wself);
        _tableView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _tableView;
}

-(void)loadWithPage:(NSInteger)page append:(BOOL)append
{
    switch (_categoryId) {
        case kDDCommunityJobWantList:
        {
            [DDLifeHttpUtil jobSeekListWithpage:page block:^(NSDictionary *dict) {
                NSArray *array = [DDJobSeekModel mj_objectArrayWithKeyValuesArray:dict];
                [self showDataWithTableView:self.tableView dataList:array withFlag:_categoryId append:append];
            } failure:^{
                //
            }];
        }
            break;
        case kDDCommunityRentOutList:
        {
           [DDLifeHttpUtil rentOutListWithpage:page block:^(NSDictionary *dict) {
               NSArray *array = [DDRentOutModel mj_objectArrayWithKeyValuesArray:dict];
               [self showDataWithTableView:self.tableView dataList:array withFlag:_categoryId append:append];
           } failure:^{
               //
           }];
        }
            break;
        case kDDCommunityRentWantList:
        {
            [DDLifeHttpUtil rentWantListWithpage:page block:^(NSDictionary *dict) {
                NSArray *array = [DDRentWantModel mj_objectArrayWithKeyValuesArray:dict];
                [self showDataWithTableView:self.tableView dataList:array withFlag:_categoryId append:append];
            } failure:^{
                //
            }];
        }
            break;
        case kDDCommunityLWQList:
        {
            [DDLifeHttpUtil LWQListWithpage:page block:^(NSDictionary *dict) {
               NSArray *aarr = [dict mj_JSONObject];
                NSMutableArray *dataList = [NSMutableArray array];
                for (NSDictionary *dic in aarr) {
                    DDLWQModel *model = [[DDLWQModel alloc] initWithDict:dic];
                    [dataList addObject:model];
                }
                [self showDataWithTableView:self.tableView dataList:dataList withFlag:_categoryId append:append];
            } failure:^{
                //
            }];
        }
            break;
    }
}

#pragma mark - callback
-(void)callbackWithDict:(NSDictionary *)dict
{
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    
    switch (blockType) {
        case kDDBlockTypeJobWant:{
            DDJobSeekModel *jsModel = dict[kYLModel];
            [self pushToJobwantDefaultVCWithModel:jsModel];
        }break;
        case kDDBlockTypeRentOut:{
            DDRentOutModel *roModel = dict[kYLModel];
            //出租（原生）
            [self pushToRentoutDetailVCWithModel:roModel];
            
        }break;
        case kDDBlockTypeRentWant:{
            
            DDRentWantModel *rwModel = dict[kYLModel];
            [self pushToDefaultVCWithModel:rwModel];
            
        }break;
        default:
        case kDDBlockTypeLWQ:
        {
            DDLWQModel *model = dict[kYLModel];
            [self pushCommentVCWithModel:model];
        }
            break;
        case kDDBlockTypeLwqImageBrowser:
        {
            _browserImg =dict[kYLModel];
            
            MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
            browser.displayActionButton = NO;
            browser.displayNavArrows = YES;
            browser.displaySelectionButtons = NO; //选择按钮
            browser.alwaysShowControls = NO;
            browser.zoomPhotosToFill = YES;
            browser.enableGrid = NO;
            browser.startOnGrid = NO;
            browser.enableSwipeToDismiss = YES;
            browser.autoPlayOnAppear = NO;
    
            [browser setCurrentPhotoIndex:_browserImg.index];
    
            [self.navigationController pushViewController:browser animated:YES];
        }
    }
}

#pragma mark--MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.browserImg.imageArr.count;
}
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.browserImg.imageArr.count) {
        
        return [self.browserImg.imageArr objectAtIndex:index];
    }
    return nil;
}


#pragma mark - push

-(void)pushToRentoutDetailVCWithModel:roModel
{
    DDRentoutDetailViewController *rwDetailVC = [[DDRentoutDetailViewController alloc] init];
    rwDetailVC.roModel = roModel;
    rwDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:rwDetailVC animated:YES];
}

-(void)pushToJobwantDefaultVCWithModel:model
{
    DDDefaultVC *defaultVc = [[DDDefaultVC alloc] init];
    defaultVc.jsModel = model;
    defaultVc.flag = @"求职详情";
    defaultVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:defaultVc animated:YES];
}


-(void)pushToDefaultVCWithModel:model
{
    DDDefaultVC *defaultVc = [[DDDefaultVC alloc] init];
    defaultVc.rwModel = model;
    defaultVc.flag = @"求租详情";
    defaultVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:defaultVc animated:YES];
}

- (void)pushCommentVCWithModel:(DDLWQModel *)model
{
    DDLwqCommentVC *vc = [[DDLwqCommentVC alloc]init];
    vc.model = model;
    vc.type = kDDCommetnHeaderTypeLWQ;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
