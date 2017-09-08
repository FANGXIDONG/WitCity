//
//  DDConfirmRechargeVC.m
//  WitCity
//
//  Created by 方冬冬 on 2016/12/2.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDConfirmRechargeVC.h"
#import "DDConfirmRechargeView.h"
#import "DDPayReq.h"
#import <WXApi.h>

@interface DDConfirmRechargeVC ()
@property (nonatomic, strong) DDConfirmRechargeView *crView;
@property (nonatomic, strong) DDPayReq *payReq;
@end

@implementation DDConfirmRechargeVC

#pragma mark 监听通知
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    //检测是否装了微信软件
    if ([WXApi isWXAppInstalled])
    {
        //监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:kDDWxPayNotification object:nil];
    }
}

#pragma mark - 事件
- (void)getOrderPayResult:(NSNotification *)notification
{
    NSLog(@"userInfo: %@",notification.userInfo);
    
    if ([notification.object isEqualToString:@"success"])
    {  
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"支付成功" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self popViewController];
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:NO completion:nil];
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"支付失败" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self popViewController];
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:NO completion:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@"订单详情"];
    [self addViews];
    [self getWxRequestParameters];
}

-(void)addViews{
    [self.view addSubview:self.crView];
}

-(DDConfirmRechargeView *)crView{
    if(!_crView) {
        _crView = [[DDConfirmRechargeView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2)];
        WS(wself);
        _crView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _crView;
}
#pragma mark - callback
-(void)callbackWithDict:(NSDictionary *)dict
{
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    switch (blockType) {
        case kDDBlockTypeWechatPayConfirmPay:{
            [self WXPay];
        }break;
    }
}
//获得拉起微信支付的参数(生成预支付订单)
-(void)getWxRequestParameters
{
    //单位是分
    int penny =[_rModel.money intValue]*100;
    NSString *money = [NSString stringWithFormat:@"%d",penny];
    [YLToast showToastWithView:self.crView.bgView text:@"加载中"];
    [DDLifeHttpUtil createRechargePrepayidWithUid:[YLUserSingleton shareInstance].uid Body:@"西藏智慧柳梧-话费充值" money:money phone:_rModel.phone prodid:_rModel.prodid filltype:@"KC" incretype:@"phoneincrement" block:^(NSDictionary *dict) {
        [YLToast hiddenToastWithView:self.crView.bgView];
        _payReq = [DDPayReq mj_objectWithKeyValues:dict];
        [self.crView setValuesWith:_payReq request:_rModel];
    } failure:^{
    }];
}
//拉起微信支付
-(void)WXPay{
    PayReq *req   = [[PayReq alloc] init];
    req.openID    = _payReq.appid;
    req.partnerId = _payReq.partnerid;
    req.prepayId  = _payReq.prepayid;
    req.package   = _payReq.package;
    req.nonceStr  = _payReq.noncestr;
    req.timeStamp = [_payReq.timestamp intValue];   //时间戳要转换成int型，不然微信返回签名错误
    req.sign      = _payReq.sign;
    //发送请求到微信，等待微信返回onResp
    [WXApi sendReq:req];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end


















