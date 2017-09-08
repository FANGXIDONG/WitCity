//
//  DDCommunityVC.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/5.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDCommunityVC.h"
#import "DDLifeHomeView.h" //通用视图
#import "DDRecruitListTableView.h"
#import "DDLifeHttpUtil.h"   //生活版数据请求
#import "DDRecruitModel.h"
#import "DDCommonListViewController.h"  //求职、出租、求租、柳梧圈通用控制器

#import "DDDefaultVC.h"
#import "DDLifeUserCenterVC.h"

@interface YLListTableView()

@property (nonatomic , strong) YLListTableView *tv;

@end

#define kSegeHeight  2
#define kExtraH      15

@interface DDCommunityVC ()

@property (nonatomic, strong) DDRecruitListTableView *recuitTableV;
@property (nonatomic ,strong) UIView *variousView ;
@property (nonatomic, strong) DDRecruitModel *rmodel;
@property (nonatomic,  assign) float width;

@end

@implementation DDCommunityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self naviSetting];
    [self addViews];
    [self refresh];
}

-(void)naviSetting{
    
    self.naviStyle = 1;
    self.navigationItem.title = @"社区";
    self.navigationItem.leftBarButtonItem = [self buttonForNavigationBarWithAction:@selector(leftClick) imageNamed:@"hudong_titleleft"];
}

-(void)leftClick{
    [self pushLifeUserCenter];
}


-(void)addViews{
    
    
    self.view.backgroundColor  = kYLColorFontGray;
    
    
    NSArray *nameArray = @[@"招聘",@"求职",@"出租",@"求租", @"柳梧圈"];
    NSArray *imageArray = @[@"sq_zp",@"sq_qz",@"sq_cz",@"sq_qiuzu",@"sq_lwq"];
    
    float commonPadding = 0.0;
    float font = 0.0;
    float orginY = 0.0;
    if (IS_IPHONE_6P) {
        commonPadding = 5;
        font = 15;
        orginY = 15;
    }
    if (IS_IPHONE_6) {
        commonPadding = 7;
        font = 14;
        orginY = 10;
    }
    if (IS_IPHONE_5) {
        commonPadding = 15;
        font = 12;
        orginY = 5;
    }
    if (IS_IPHONE_4_OR_LESS) {
        commonPadding = 18;
        font = 10;
        orginY = 5;
    }
    
    self.width = (WINDOW_WIDTH - 5*commonPadding)/nameArray.count;
    
    self.variousView = [[UIView alloc]initWithFrame:CGRectMake(0,0, WINDOW_WIDTH, _width + kExtraH)];
    self.variousView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.variousView];
    
    DDLifeHomeView *iconView;
    for (int i = 0; i < nameArray.count; i ++ ) {
        iconView = [[DDLifeHomeView alloc] initWithFrame:CGRectMake((i*_width)+commonPadding/2+i*commonPadding, orginY, _width, self.variousView.frame.size.height) title:[nameArray objectAtIndex:i] imageName:[imageArray objectAtIndex:i] font:FONT_H(font) titleColor:[UIColor colorWithHex:YLCOLOR_DARK_GREY] titleHeight:10 index:(int)i + 5];
        
        [self.variousView addSubview:iconView];
        WS(wself);
        iconView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
//    NSArray *nameArray = @[@"招聘",@"求职",@"出租",@"求租", @"柳梧圈"];
//    NSArray *imageArray = @[@"sq_zp",@"sq_qz",@"sq_cz",@"sq_qiuzu",@"sq_lwq"];
//    
//    float width = (WINDOW_WIDTH - 50)/nameArray.count;
//    
//    self.variousView = [[UIView alloc]initWithFrame:CGRectMake(0,0, WINDOW_WIDTH, width + 10)];
//    [self.view addSubview:self.variousView];
//    
//    DDLifeHomeView *iconView;
//    for (int i = 0; i < nameArray.count; i ++ ) {
//        iconView = [[DDLifeHomeView alloc] initWithFrame:CGRectMake((i*width)+5+i*10, 5, width, self.variousView.frame.size.height-10) title:[nameArray objectAtIndex:i] imageName:[imageArray objectAtIndex:i] font:FONT_H(12) titleColor:[UIColor colorWithHex:YLCOLOR_DARK_GREY] titleHeight:10 index:i+5];
//        [self.variousView addSubview:iconView];
//        WS(wself);
//        iconView.allBlock = ^(NSDictionary *dict) {
//            [wself callbackWithDict:dict];
//        };
//    }
    
    UILabel *segeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, _width + kExtraH, WINDOW_WIDTH, kSegeHeight)];
    segeLab.backgroundColor = YLCOLOR(YLCOLOR_BACKGROUND_GARY);
    [self.view addSubview:segeLab];

    [self.view addSubview:self.recuitTableV];
}


#pragma mark - getter
-(DDRecruitListTableView *)recuitTableV
{
    if(!_recuitTableV) {
        _recuitTableV = [[DDRecruitListTableView alloc]initWithFrame:CGRectMake(0, _width+ kSegeHeight + kExtraH, WINDOW_WIDTH, CONTENT_HEIGHT - _width - kSegeHeight - kExtraH) style:UITableViewStylePlain];
        
        WS(wself);
        _recuitTableV.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _recuitTableV;
}

#pragma mark - callback
-(void)callbackWithDict:(NSDictionary *)dict
{
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    switch (blockType) {
        case kDDBlockTypeRecruit:{
            self.rmodel = dict[kYLModel];
            [self pushToRecruitDefaultVC];

        }break;
        case kDDBlockTypeJobWant:
        {
            [self pushCommunityCommonListVCWithCategoryId:1 title:@"求职"];
        }break;
        case kDDBlockTypeRentOut:
        {
          [self pushCommunityCommonListVCWithCategoryId:2 title:@"出租"];
        }break;
        case kDDBlockTypeRentWant:
        {
            [self pushCommunityCommonListVCWithCategoryId:3 title:@"求租"];
        }break;
        case kDDBlockTypeLWQ:
        {
            [self pushCommunityCommonListVCWithCategoryId:4 title:@"柳梧圈"];
        }break;
        default:
            break;
    }
}


#pragma mark - push

-(void)pushToRecruitDefaultVC
{
    DDDefaultVC *defaultVc = [[DDDefaultVC alloc] init];
    defaultVc.rModel = self.rmodel;
    defaultVc.flag = @"职位详情";
    defaultVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:defaultVc animated:YES];
}


- (void)pushCommunityCommonListVCWithCategoryId:(NSInteger )categoryId title:(NSString *)title
{
    DDCommonListViewController *vc = [[DDCommonListViewController alloc] init];
    vc.categoryId = categoryId;
    vc.naviTitle = title;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)pushLifeUserCenter{
    DDLifeUserCenterVC *vc = [[DDLifeUserCenterVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES; //NAvi时隐藏tabbar
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - server
-(void)loadWithPage:(NSInteger)page append:(BOOL)append
{
    [DDLifeHttpUtil recruitListWithpage:page block:^(NSDictionary *dict) {
        NSArray *array = [DDRecruitModel mj_objectArrayWithKeyValuesArray:dict];
        [self showDataWithTableView:self.recuitTableV dataList:array withFlag:0  append:append];
    } failure:^{
        //
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end




