//
//  DDServiceViewController.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/5.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDServiceViewController.h"
#import "DDLifeHomeView.h" //通用视图
#import "DDDefaultDevelopingVC.h"
#import "DDCommonView.h"
#import "DDLifeUserCenterVC.h"
#import "DDDefaultVC.h"
#import "DDSocialInsurancesVC.h"   //社保页面
#import "YLLoginManager.h"
#import "DDRechargeViewController.h"   //充值
//#import "DDPayReq.h"

#define kHeaderHeight  35

@interface DDServiceViewController ()
@property (nonatomic, strong) YLLoginManager    *loginManager;
@end

@implementation DDServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.naviStyle = 1;
    self.navigationItem.title = @"服务";
    self.navigationItem.leftBarButtonItem = [self buttonForNavigationBarWithAction:@selector(leftClick) imageNamed:@"hudong_titleleft"];
    
    [self UISetting];
    
    
    //测试充值接口
//    [self test];
}

-(void)test{
    
//    *  body 商品描述
//    *  money 充值金额
//    *  price 充值金额（实际支付，分为单位）
//    *  phone 充值电话
//    *  prodid 产品id
//    *  filltype 充值类型（默认KC）
//    *  incretype 充值商品类型（默认 phoneincrement）
    
    //单位是分
    
//    [DDLifeHttpUtil createRechargePrepayidWithUid:[YLUserSingleton shareInstance].uid Body:@"话费充值" money:@"10" phone:@"15205145990" prodid:@"'" filltype:@"KC" incretype:@"phoneincrement" block:^(NSDictionary *dict) {
//        //
//        
//        DDPayReq *pay = [DDPayReq mj_objectWithKeyValues:dict];
//        NSLog(@"pay");
//        
//        
//    } failure:^{
//        //
//    }];
//    
   
}

-(void)UISetting{
    
    float width = (WINDOW_WIDTH - 2)/3;
  
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT)];
    scrollView.backgroundColor = YLCOLOR(YLCOLOR_BACKGROUND_GRAY);
    [self.view addSubview:scrollView];
    
    scrollView.contentSize = CGSizeMake(0, width *5 + 4*kHeaderHeight );
    
    //生活缴费
    
    NSArray *name1Array = @[@"医保查询",@"电费",@"燃气费"];
    NSArray *image1Array = @[@"fw_si",@"fw_dianfei",@"fw_ranqi"];
    NSArray *name2Array = @[@"手机充值",@"有限电视",@"固定宽带"];
    NSArray *image2Array = @[@"fw_phone",@"fw_tv",@"fw_kuandai"];
    UILabel *lifeTrade = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, WINDOW_WIDTH, kHeaderHeight)];
    lifeTrade.text = @"便民生活";
    lifeTrade.textColor =kYLColorFontBlack;
    [scrollView addSubview:lifeTrade ];

    DDCommonView *v1;
    DDCommonView *v2;
    
    for (int i = 0; i < 3; i ++ ) {
        
        v1 = [[DDCommonView alloc] initWithFrame:CGRectMake(i*width + i*1, kHeaderHeight, width, width)];
        v1.title = name1Array[i];
        v1.imageNamed = image1Array[i];
        [scrollView addSubview:v1];
        
        v2 = [[DDCommonView alloc] initWithFrame:CGRectMake(i*width + i*1, kHeaderHeight+width+1, width, width)];
        v2.title = name2Array[i];
        v2.imageNamed = image2Array[i];
        [scrollView addSubview:v2];
        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SinglerTap:)];
        v1.tag = i+10;
        [v1 addGestureRecognizer:tap1];
        
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SinglerTap:)];
        v2.tag = i+10010;
        [v2 addGestureRecognizer:tap2];
    }

    //文化生活
    
    NSArray *name3Array = @[@"体育场预定",@"景点门票",@"西藏演绎"];
    NSArray *image3Array = @[@"fw_order",@"fw_ticket",@"fw_tibet"];

    UILabel *lifeTrade1 = [[UILabel alloc] initWithFrame:CGRectMake(10, v2.frame.origin.y + v2.frame.size.height, WINDOW_WIDTH, kHeaderHeight)];
    lifeTrade1.text = @"文化生活";
    lifeTrade1.textColor =kYLColorFontBlack;
    [scrollView addSubview:lifeTrade1 ];

    DDCommonView *v3;

    for (int i = 0; i < 3; i ++ ) {
        
        v3 = [[DDCommonView alloc] initWithFrame:CGRectMake(i*width + i*1, kHeaderHeight *2 + width *2 +1, width, width) ];
        v3.title =[name3Array objectAtIndex:i];
        v3.imageNamed =[image3Array objectAtIndex:i];
        [scrollView addSubview:v3];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SinglerTap:)];
        v3.tag = i+10086;
        [v3 addGestureRecognizer:tap];
    }
    
    //同城配送
    
    NSArray *name4Array = @[@"水果蔬菜",@"外卖小吃",@"超市便利"];
    NSArray *image4Array = @[@"fw_shuiguo",@"fw_eat",@"fw_chaoshi"];
    
    UILabel *lifeTrade2 = [[UILabel alloc] initWithFrame:CGRectMake(10, v3.frame.origin.y + v3.frame.size.height, WINDOW_WIDTH, kHeaderHeight)];
    lifeTrade2.text = @"同城配送";
    lifeTrade2.textColor =kYLColorFontBlack;
    [scrollView addSubview:lifeTrade2 ];
    
    DDCommonView *v4;
    
    for (int i = 0; i < 3; i ++ ) {
        
        v4 = [[DDCommonView alloc] initWithFrame:CGRectMake(i*width + i*1, v3.frame.origin.y + v3.frame.size.height + kHeaderHeight, width, width) ];
        v4.title =[name4Array objectAtIndex:i];
        v4.imageNamed =[image4Array objectAtIndex:i];
        [scrollView addSubview:v4];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SinglerTap:)];
        v4.tag = i+50;
        [v4 addGestureRecognizer:tap];
    }
    
    //车主服务
    
    NSArray *name5Array = @[@"查车位",@"违章查询",@"违章缴费"];
    NSArray *image5Array = @[@"fw_chewei",@"fw_weizhang",@"fw_jiaofei"];
    
    UILabel *lifeTrade3 = [[UILabel alloc] initWithFrame:CGRectMake(10, v4.frame.origin.y + v3.frame.size.height, WINDOW_WIDTH, kHeaderHeight)];
    lifeTrade3.text = @"车主服务";
    lifeTrade3.textColor =kYLColorFontBlack;
    [scrollView addSubview:lifeTrade3 ];
    
    DDCommonView *v5;
    
    for (int i = 0; i < 3; i ++ ) {
        
        v5 = [[DDCommonView alloc] initWithFrame:CGRectMake(i*width + i*1, v4.frame.origin.y + v4.frame.size.height + kHeaderHeight, width, width) ];
        v5.title =[name5Array objectAtIndex:i];
        v5.imageNamed =[image5Array objectAtIndex:i];
        [scrollView addSubview:v5];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SinglerTap:)];
        v5.tag = i+50;
        [v5 addGestureRecognizer:tap];

    }
}

-(YLLoginManager *)loginManager
{
    if(!_loginManager) {
        _loginManager = [[YLLoginManager alloc]initWithController:self];
    }
    return _loginManager;
}


-(void)SinglerTap:(UITapGestureRecognizer *)tap{
   
    //社保
    if ([tap view].tag == 10) {     
        [self.loginManager pushCheckedLoginWithPopToRoot:NO block:^{
            DDSocialInsurancesVC *siVC = [[DDSocialInsurancesVC alloc] init];
            siVC.statusType =kDDSocialInsuranceViewTypeInquiry;
            siVC.hidesBottomBarWhenPushed  = YES;
            [self.navigationController pushViewController:siVC animated:YES];
        }];
    }
    
    //体育场预定
    else if ([tap view].tag == 10086) {
       
        DDDefaultVC *defaultVC = [[ DDDefaultVC alloc] init];
        defaultVC.flag = @"体育场预定";
        defaultVC.hidesBottomBarWhenPushed  = YES;
        [self.navigationController pushViewController:defaultVC animated:NO];
    }
    //手机充值
    else if ([tap view].tag == 10010) {
        
        [self.loginManager pushCheckedLoginWithPopToRoot:NO block:^{
            DDRechargeViewController *rechargeVC = [[DDRechargeViewController alloc] init];
            rechargeVC.hidesBottomBarWhenPushed  = YES;
            [self.navigationController pushViewController:rechargeVC animated:YES];
        }];

    }else{
        
        DDDefaultDevelopingVC *defaultVC = [[DDDefaultDevelopingVC alloc] init];
        defaultVC.hidesBottomBarWhenPushed  = YES;
        [self.navigationController pushViewController:defaultVC animated:YES];
    }   
}

//-(void)judgeSocialInsuranceRelationShip{
//    
//    [DDLifeHttpUtil getSocialInsuranceRelationshipWithPhone:nil Block:^(NSDictionary *dict) {
//
//       
//        if ([ dict[@"status"] isEqualToString:@"N"]) {
//            siVC.statusType =kDDSocialInsuranceViewTypeOpenIntroduce;
//        }
//        if ([ dict[@"status"] isEqualToString:@"Y"]) {
//            siVC.statusType =kDDSocialInsuranceViewTypeInquiry;
//        }
//        
//        
//    } failure:^{
//        //
//    }];
//}

-(void)leftClick{
    NSLog(@"GEREN");
    
    [self pushLifeUserCenter];
}

#pragma mark - push

- (void)pushLifeUserCenter{
    DDLifeUserCenterVC *vc = [[DDLifeUserCenterVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES; //NAvi时隐藏tabbar
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
