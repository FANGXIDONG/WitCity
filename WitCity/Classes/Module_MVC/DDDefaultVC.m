
//
//  DDDefaultVC.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/12.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDDefaultVC.h"
#import "DDLifeHttpUtil.h"
#import "DDHotLinePhoneView.h"
#import "DDPositionPersonPhone.h"
#import "AESCrypt.h"             //AES加密

#define kKey   @"xyBSnQE2FFDSEdsd"
#define kIV    @"5efd3f6060e20330"

@interface DDDefaultVC ()
{
    NSString *phone;
    NSString *hotlineUrl;
}

@property (nonatomic, strong) DDHotLinePhoneView *phoneView;
@property (nonatomic, strong) DDPositionPersonPhone *ppView;
@property (nonatomic, strong) DDPositionPersonPhone *rwPPView;
@property (nonatomic, strong) DDPositionPersonPhone *contactView;
@end

@implementation DDDefaultVC


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置进度条
    [self.navigationController.navigationBar addSubview:_progressView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    super.btnCollect.hidden = YES;
    super.btnShare.hidden = YES;
    
    [self addViews];
    
    [self navigationWithTitle:self.flag];
    
    if ([self.flag isEqualToString:@"企业通讯录"]) {
        super.btnShare.hidden = NO;
        [self navigationWithTitle:self.contactModel.company];
    }
    
    if ([self.flag isEqualToString:@"周边首页进入"]) {
        [self navigationWithTitle:@"团购详情"];
    }
    
    
    if ([self.flag isEqualToString:@"广告"]) {
        
        super.btnShare.hidden = NO;
        
        NSArray *arr  = [self.newsModel.doc componentsSeparatedByString:@","];
        if (arr.count>1) {
           [self navigationWithTitle:arr[0]];
        }
        
    }
}

-(void)addViews
{
    [self.view addSubview:self.webView];
    
    
    //创建web加载进度条
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    

    NSString *urlString;
    NSString *paraStr = [NSString stringWithFormat:@"%@&%@",[YLUserSingleton shareInstance].uid,[self unixTime]];
    NSString *encryPara = [AESCrypt encrypt:paraStr password:kKey iv:kIV];
    if ([self.flag isEqualToString:@"市民热线"]) {
        [self requestForHotLineData];
    }
   else if ([self.flag isEqualToString:@"全部订单"]) {
       
        urlString  = [NSString stringWithFormat:@"%@&encryptU_id=%@", ZUTUAN_PREPARE_ALLORDERS,encryPara];
//       NSLog(@"%@",urlString);
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    }
   else if ([self.flag isEqualToString:@"待付款"]) {
      
        urlString  = [NSString stringWithFormat:@"%@&encryptU_id=%@", ZUTUAN_PREPARE_PAY,encryPara];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    }
   else if ([self.flag isEqualToString:@"待发货"]) {

        urlString  = [NSString stringWithFormat:@"%@&encryptU_id=%@", ZUTUAN_PREPARE_SEND,encryPara];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    }
   else if ([self.flag isEqualToString:@"待确认"]) {

        urlString  = [NSString stringWithFormat:@"%@&encryptU_id=%@", ZUTUAN_PREPARE_CONFIRM,encryPara];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    }
   else if ([self.flag isEqualToString:@"待评价"]) {

        urlString  = [NSString stringWithFormat:@"%@&encryptU_id=%@", ZUTUAN_PREPARE_COMMENT,encryPara];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    }
   else if ([self.flag isEqualToString:@"退货"]) {
       
        urlString  = [NSString stringWithFormat:@"%@&encryptU_id=%@", ZUTUAN_PREPARE_RETURN,encryPara];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    }

    
    else{

        if ([self.flag isEqualToString:@"周边首页进入"]) {
            
            urlString  = [NSString stringWithFormat:@"%@&encryptU_id=%@", self.nearByModel.url,encryPara];
            NSLog(@"=====%@",urlString);
        }
        
        if ([self.flag isEqualToString:@"美食"]) {
           
            urlString  = [NSString stringWithFormat:@"%@&encryptU_id=%@", ZUTUAN_DELICIOUSFOODS,encryPara];
        }
        if ([self.flag isEqualToString:@"酒店"]) {

            urlString  = [NSString stringWithFormat:@"%@&encryptU_id=%@", ZUTUAN_HOTEL,encryPara];
            
        }
        if ([self.flag isEqualToString:@"娱乐"]) {

            urlString  = [NSString stringWithFormat:@"%@&encryptU_id=%@", ZUTAUN_ENTERPRISE,encryPara];
        }
        if ([self.flag isEqualToString:@"其他"]) {

            urlString  = [NSString stringWithFormat:@"%@&encryptU_id=%@", GROUP_PURASE,encryPara];
        }
        if ([self.flag isEqualToString:@"打车热线"]) {
            urlString = PHONE_TAXI;
        }
        if ([self.flag isEqualToString:@"火车票"]) {
            urlString = TRAIN_TICKET;
        }
        if ([self.flag isEqualToString:@"公交详情"]) {
            urlString = self.busModel.url;
        }
        if ([self.flag isEqualToString:@"充值"]) {
            urlString = CHARGE_URL;
        }
        if ([self.flag isEqualToString:@"团购"]) {
       
            urlString  = [NSString stringWithFormat:@"%@&encryptU_id=%@", GROUP_PURASE,encryPara];
            NSLog(@"团购：%@",urlString);
        }
        if ([self.flag isEqualToString:@"新闻"]) {
            urlString = self.newsModel.url;
        }
        if ([self.flag isEqualToString:@"广告"]) {
            urlString = self.newsModel.url;
        }
        if ([self.flag isEqualToString:@"体育场预定"]) {
            urlString = stadium_order;
        }
        if ([self.flag isEqualToString:@"电影票"]) {
            urlString  = [NSString stringWithFormat:@"%@&encryptU_id=%@", MOVIES_TICKETS,encryPara];
        }
        
        if ([self.flag isEqualToString:@"求职详情"]) {
            urlString = self.jsModel.url;
        }
        
        if ([self.flag isEqualToString:@"求租详情"]) {
            urlString = self.rwModel.url;
            [self.view addSubview:self.rwPPView];
        }
        if ([self.flag isEqualToString:@"职位详情"]) {
            urlString = self.rModel.url;
             [self.view addSubview:self.ppView];
        }
        if ([self.flag isEqualToString:@"企业通讯录"]) {
            urlString = self.contactModel.url;
            [self.view addSubview:self.contactView];
        }
        //含有中文需转码
        NSString * strUrl = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:strUrl];
        NSLog(@"转码后：%@",url);
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    }
}


//市民热线数据请求
-(void)requestForHotLineData{
    
    [DDLifeHttpUtil getHotlineDataBlock:^(NSDictionary *dict) {
        
        phone = dict[@"phone"];
        hotlineUrl  =dict[@"url"];
        
        NSURL *url = [NSURL URLWithString:hotlineUrl];
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
        
        
        [self.view addSubview:self.phoneView];
        
    } failure:^{
        
    }];
}

#pragma mark - callback
-(void)callbackWithDict:(NSDictionary *)dict
{
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    switch (blockType) {
        case kDDBlockTypeHotlineSend:{
            //拨号
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]]];
        }break;
        case kDDBlockTypeHotlineInquire:
        {
            //拨号
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",dict[kYLValue]]]];
        }
            break;
        default:
            break;
    }
}
//getter

-(DDPositionPersonPhone *)contactView{
    
    if(!_contactView) {
        _contactView = [[DDPositionPersonPhone alloc]initWithFrame:CGRectMake(0, CONTENT_HEIGHT2 - 60, WINDOW_WIDTH, 60)];
        _contactView.phone = self.contactModel.phone;
        _contactView.person = self.contactModel.name;
        WS(wself);
        _rwPPView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _contactView;
}


-(DDPositionPersonPhone *)rwPPView{
    
    if(!_rwPPView) {
        _rwPPView = [[DDPositionPersonPhone alloc]initWithFrame:CGRectMake(0, CONTENT_HEIGHT2 - 60, WINDOW_WIDTH, 60)];
        _rwPPView.phone = self.rwModel.phone;
        _rwPPView.person = self.rwModel.person;
        WS(wself);
        _rwPPView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _rwPPView;
}

-(DDPositionPersonPhone *)ppView{
    
    if(!_ppView) {
        _ppView = [[DDPositionPersonPhone alloc]initWithFrame:CGRectMake(0, CONTENT_HEIGHT2 - 60, WINDOW_WIDTH, 60)];
        _ppView.phone = self.rModel.phone;
        _ppView.person = self.rModel.person;
        WS(wself);
        _ppView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _ppView;
}


-(DDHotLinePhoneView *)phoneView{
    
    if(!_phoneView) {
        _phoneView = [[DDHotLinePhoneView alloc]initWithFrame:CGRectMake(0, CONTENT_HEIGHT2 - 50, WINDOW_WIDTH, 50)];
        _phoneView.phone = phone;
        WS(wself);
        _phoneView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _phoneView;
}


-(UIWebView *)webView
{
    if(!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2)];
    }
    _webView.scalesPageToFit = YES;
    return _webView;
}


//时间转时间戳
-(NSString *)unixTime{
    //方法一
        NSDate *localDate = [NSDate date]; //获取当前时间
        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[localDate timeIntervalSince1970]];  //转化为UNIX时间戳
//        NSLog(@"timeSp:%@",timeSp); //时间戳的值
    
    //方法二
//    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
//    NSTimeInterval a=[dat timeIntervalSince1970]*1000;  //  *1000 是精确到毫秒，不乘就是精确到秒
//    NSString *timeSp = [NSString stringWithFormat:@"%f", a]; //转为字符型
//    NSLog(@"timeSp:%@",timeSp); //时间戳的值
    //    //简写之
    //    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[[NSDate  date] timeIntervalSince1970]];
    //
    //    //C语言的time(NULL)函数也可以
    //     NSLog(@"%ld", time(NULL));  // 这句也可以获得时间戳，跟上面一样，精确到秒
    
    return timeSp;
}




#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
    //self.title = [webView1 stringByEvaluatingJavaScriptFromString:@"document.title"];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //清空代理对象
    _webView.delegate = nil;
    [_progressView removeFromSuperview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
