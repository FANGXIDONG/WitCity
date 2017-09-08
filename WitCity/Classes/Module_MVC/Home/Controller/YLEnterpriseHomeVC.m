//
//  YLEnterpriseHomeVC.m
//  WitCity
//
//  Created by simpletour on 16/5/18.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLEnterpriseHomeVC.h"
#import "YLEnterpriseHomeView.h"
#import "YLUserCenterVC.h"
#import "YLLoginVC.h"
#import "YLHomeHttpUtil.h"
#import "YLBannerModel.h"
#import "YLEnterpriseHomeListVC.h"
#import "YLBannerDetailVC.h"

#import "AppDelegate.h"

#import "YLLoginManager.h"
#import "MovieTableViewController.h"//电影票
#import "DDLifeHomeView.h"          //出行、电影票、充值封装视图
#import "DDTravelViewController.h"  //出行
#import "DDDefaultVC.h"             //静态页
#import "DDLifeHttpUtil.h"          //数据请求
#import "DDWeatherModel.h"          //天气Model
#import "DDNewsModel.h"             //新闻广告Model
#import "DDNewsAndAdsView.h"        //新闻广告视图
#import "DDLifeUserCenterVC.h"      //生活版个人中心
#import "DDRechargeViewController.h"    //充值

#define DURATION 0.7f
#define kImgWith   25
#define kLabelH    10
#define kLaSaCityId  101140101

@interface YLEnterpriseHomeVC ()

@property (nonatomic, strong) YLEnterpriseHomeView *mainView;
@property (nonatomic , strong) UIView *variousView;
@property (nonatomic, strong) YLLoginManager    *loginManager;
@end

typedef enum : NSUInteger {
    Fade = 1,                   //淡入淡出
    Push,                       //推挤
    Reveal,                     //揭开
    MoveIn,                     //覆盖
    Cube,                       //立方体
    SuckEffect,                 //吮吸
    OglFlip,                    //翻转
    RippleEffect,               //波纹
    PageCurl,                   //翻页
    PageUnCurl,                 //反翻页
    CameraIrisHollowOpen,       //开镜头
    CameraIrisHollowClose,      //关镜头
    CurlDown,                   //下翻页
    CurlUp,                     //上翻页
    FlipFromLeft,               //左翻转
    FlipFromRight,              //右翻转
    
} AnimationType;


@implementation YLEnterpriseHomeVC

#pragma mark - init
- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate]; //前面加上(AppDelegate *)消除警告
    _intVersion = appDelegate.flatInt;
    
    if (_intVersion == 0)
    {
        [self initEnterpriseArchitecture];
        
    }else{
        [self initLifeArchitecture];
    }
}
-(YLLoginManager *)loginManager
{
    if(!_loginManager) {
        _loginManager = [[YLLoginManager alloc]initWithController:self];
    }
    return _loginManager;
}

-(void)addViews
{
    [self.view addSubview:self.mainView];
}

- (void)leftClick
{
    [self pushUserCenterVC];
}

-(void)leftClickToLifeUserCenter{
    
    [self pushLifeUserCenter];
}

- (void)gotoLeftVersion
{
    AnimationType animationType = 5;
    NSString *subtypeString;
    switch (_subtype) {
        case 0:
            subtypeString = kCATransitionFromLeft;
            break;
        case 1:
            subtypeString = kCATransitionFromBottom;
            break;
        case 2:
            subtypeString = kCATransitionFromRight;
            break;
        case 3:
            subtypeString = kCATransitionFromTop;
            break;
        default:
            break;
    }
    _subtype += 1;
    if (_subtype > 3) {
        _subtype = 0;
    }

    switch (animationType) {
        case Fade:
            [self transitionWithType:kCATransitionFade WithSubtype:subtypeString ForView:self.view];
            break;
            
        case Push:
            [self transitionWithType:kCATransitionPush WithSubtype:subtypeString ForView:self.view];
            break;
            
        case Reveal:
            [self transitionWithType:kCATransitionReveal WithSubtype:subtypeString ForView:self.view];
            break;
            
        case MoveIn:
            [self transitionWithType:kCATransitionMoveIn WithSubtype:subtypeString ForView:self.view];
            break;
            
        case Cube:
            [self transitionWithType:@"cube" WithSubtype:subtypeString ForView:self.view];
            break;
            //
        case SuckEffect:
            [self transitionWithType:@"suckEffect" WithSubtype:subtypeString ForView:self.view];
            
            break;
            
        case OglFlip:
            [self transitionWithType:@"oglFlip" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case RippleEffect:
            [self transitionWithType:@"rippleEffect" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case PageCurl:
            [self transitionWithType:@"pageCurl" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case PageUnCurl:
            [self transitionWithType:@"pageUnCurl" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case CameraIrisHollowOpen:
            [self transitionWithType:@"cameraIrisHollowOpen" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case CameraIrisHollowClose:
            [self transitionWithType:@"cameraIrisHollowClose" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case CurlDown:
            [self animationWithView:self.view WithAnimationTransition:UIViewAnimationTransitionCurlDown];
            break;
            
        case CurlUp:
            [self animationWithView:self.view WithAnimationTransition:UIViewAnimationTransitionCurlUp];
            break;
            
        case FlipFromLeft:
            [self animationWithView:self.view WithAnimationTransition:UIViewAnimationTransitionFlipFromLeft];
            break;
            
        case FlipFromRight:
            [self animationWithView:self.view WithAnimationTransition:UIViewAnimationTransitionFlipFromRight];
            break;
            
        default:
            break;
    }

    if (_intVersion == 0)
    {

        [self initLifeArchitecture];
    }
    else
    {
        [self initEnterpriseArchitecture];
    }
    
    //监听版本变化
    NSString *strVersion = [NSString stringWithFormat:@"%d",_intVersion];
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:strVersion,@"intVersions", nil];
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:kChangeVersionNotification object:nil userInfo:dict];
    [ND postNotification:notification];
}

-(void)initEnterpriseArchitecture{
    
    NSArray *views = [self.view subviews];
    for (UIView *v in views) {
        [v removeFromSuperview];
    }
    _intVersion = 0;
    self.naviStyle = 0;
    self.navigationItem.title = @"企业版";
    self.navigationItem.leftBarButtonItem = [self buttonForNavigationBarWithAction:@selector(leftClick) imageNamed:@"hudong_titleleft"];
    self.navigationItem.rightBarButtonItem = [self rightBar];
    [self addViews];
    [self loadBannerData];
    NSLog(@"去生活版");
}


-(void)initLifeArchitecture{
    NSArray *views = [self.view subviews];
    for (UIView *v in views) {
        [v removeFromSuperview];
    }
    _intVersion = 1;
    self.naviStyle = 1;
    self.navigationItem.title = @"生活版";
    self.navigationItem.leftBarButtonItem = [self buttonForNavigationBarWithAction:@selector(leftClickToLifeUserCenter) imageNamed:@"hudong_titleleft"];
    self.navigationItem.rightBarButtonItem = [self rightBar];
    [self addLifeViews];
    [self loadNewsAndAdsData];
    NSLog(@"去企业版");
}



- (UIBarButtonItem *)rightBar
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (_intVersion == 0) {
        [btn setTitle:@"去生活版" forState:UIControlStateNormal];
        [btn setTitleColor:kYLColorFontYellow forState:UIControlStateNormal];
    }else{
        [btn setTitle:@"去企业版" forState:UIControlStateNormal];
        [btn setTitleColor:kDDColorFontDeepBlue forState:UIControlStateNormal];
    }
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.frame = CGRectMake(0, 0, 80, 40);
    [btn addTarget:self action:@selector(gotoLeftVersion) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return barItem;
}


#pragma CATransition动画实现
- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    //设置运动时间
    animation.duration = DURATION;
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        //设置子类
        animation.subtype = subtype;
    }
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    [view.layer addAnimation:animation forKey:@"animation"];
}

#pragma UIView实现动画
- (void) animationWithView : (UIView *)view WithAnimationTransition : (UIViewAnimationTransition) transition
{
    [UIView animateWithDuration:DURATION animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:view cache:YES];
    }];
}

//添加生活版的视图
-(void)addLifeViews{
    
    NSArray *nameArray = @[@"出行",@"电影票",@"充值",@"团购",@"市民热线"];
    NSArray *imageArray = @[@"index_cx",@"index_dyp",@"index_cz",@"index_tg",@"index_smrx"];
    
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
    
    float width = (WINDOW_WIDTH - 5*commonPadding)/nameArray.count;
    
    self.variousView = [[UIView alloc]initWithFrame:CGRectMake(0,0, WINDOW_WIDTH, width+20)];
    self.variousView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.variousView];

    DDLifeHomeView *iconView;
    for (int i = 0; i < nameArray.count; i ++ ) {
        iconView = [[DDLifeHomeView alloc] initWithFrame:CGRectMake((i*width)+commonPadding/2+i*commonPadding, orginY, width, self.variousView.frame.size.height) title:[nameArray objectAtIndex:i] imageName:[imageArray objectAtIndex:i] font:FONT_H(font) titleColor:[UIColor colorWithHex:YLCOLOR_DARK_GREY] titleHeight:10 index:(int)i];

        [self.variousView addSubview:iconView];
        WS(wself);
        iconView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
}

-(void)loadNewsAndAdsData{
    
    
    
    
    float imgHeight =(CONTENT_HEIGHT - self.variousView.frame.size.height -self.variousView.frame.origin.y) / 2;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        
        [DDLifeHttpUtil getNewsAndAdsBlock:^(NSDictionary *dict) {
            
            NSArray *array = [DDNewsModel mj_objectArrayWithKeyValuesArray:dict];
            
            [DDLifeHttpUtil getWeatherWithCityId:kLaSaCityId Block:^(NSDictionary *dict) {
                
          DDWeatherModel *wModel = [DDWeatherModel mj_objectWithKeyValues:dict];

                //更新至主线程
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    
                    for (int i= 0 ; i < array.count; i++) {
                        DDNewsModel *naModel  =array[i];
                        DDNewsAndAdsView *naView = [[DDNewsAndAdsView alloc] initWithFrame:CGRectMake(0,self.variousView.frame.origin.y+self.variousView.frame.size.height+ i*(imgHeight+1), WINDOW_WIDTH, imgHeight) newsAndAdsmodel:naModel weatherModel:wModel];
                        [self.view addSubview:naView];
                        WS(wself);
                        naView.allBlock = ^(NSDictionary *dict) {
                            [wself callbackWithDict:dict];
                        };
                    }
                    
                });
        
            } failure:^{
                //更新至主线程
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    
//                    
//                    for (int i= 0 ; i < 2; i++) {
//                        DDNewsModel *naModel  =array[i];
//                        DDNewsAndAdsView *naView = [[DDNewsAndAdsView alloc] initWithFrame:CGRectMake(0,self.variousView.frame.origin.y+self.variousView.frame.size.height+ i*(imgHeight+1), WINDOW_WIDTH, imgHeight) newsAndAdsmodel:naModel weatherModel:nil];
//                        [self.view addSubview:naView];
//                        WS(wself);
//                        naView.allBlock = ^(NSDictionary *dict) {
//                            [wself callbackWithDict:dict];
//                        };
//                    }
//                    
//                });
            }];
            
            
     
        
            
        } failure:^{
            //
        }];
        
        
        
  
    });
}




#pragma mark - getter
-(YLEnterpriseHomeView *)mainView
{
    if(!_mainView) {
        _mainView = [[YLEnterpriseHomeView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2)];
        WS(wself);
        _mainView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _mainView;
}

#pragma mark - callback
-(void)callbackWithDict:(NSDictionary *)dict
{
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    
    switch (blockType) {
        case kYLBlockTypeBannerClick:{
            YLBannerModel *model = dict[kYLModel];
            [self pushBannerDetailWithModel:model];
        }break;
        case kYLBlockTypeHomeBusiness:{//工商管理
            [self pushEnterpriseListVCWithCategoryId:@"9" title:@"工商管理"];
        }break;
        case kYLBlockTypeHomeTax:{//企业纳税
            [self pushEnterpriseListVCWithCategoryId:@"8" title:@"企业纳税"];
        }break;
        case kYLBlockTypeHomeBuild:{//建设管理
            [self pushEnterpriseListVCWithCategoryId:@"7" title:@"建设管理"];
        }break;
        case kYLBlockTypeHomeEconomy:{//经济发展
            [self pushEnterpriseListVCWithCategoryId:@"6" title:@"经济发展"];
        }break;
        case kYLBlockTypeHomeOpen:{//开办设立
            [self pushEnterpriseListVCWithCategoryId:@"5" title:@"开办设立"];
        }break;
        case kDDBlockTypeLifeHomeNews:
        {
            [self pushUrlDefaultDetailVCWithModel:dict[kYLModel] flag:@"新闻"];
            
        }break;
        case kDDBlockTypeLifeHomeAds:
        {
            [self pushUrlDefaultDetailVCWithModel:dict[kYLModel] flag:@"广告"];

        }break;
        case kDDBlockTypeLifeHomeTraffic:
        {
            [self pushToTravel];  //出行
        }break;
        case kDDBlockTypeLifeHomeMovieTicket:
        {
//            MovieTableViewController *mVC = [[MovieTableViewController alloc] init];
//            mVC.hidesBottomBarWhenPushed     =YES;
//            [self.navigationController pushViewController:mVC animated:YES];
            
            [self pushUrlDefaultDetailVCWithModel:nil flag:@"电影票"];
        }break;
        case kDDBlockTypeLifeHomeRecharege:{
            [self pushToRecharge];  //充值
        }break;
        case kDDBlockTypeLifeHomeGroupBuying:
        {
            
            [self pushUrlDefaultDetailVCWithModel:nil flag:@"团购"];
        }break;
        case kDDBlockTypeLifeHomeHotline:
        {
            [self pushUrlDefaultDetailVCWithModel:nil flag:@"市民热线"];
        }break;
        default:
            break;
    }
}

- (void)pushUrlDefaultDetailVCWithModel:(DDNewsModel *)model flag:(NSString *)flag;
{
    [self.loginManager pushCheckedLoginWithPopToRoot:NO block:^{
        DDDefaultVC *mVC = [[DDDefaultVC alloc] init];
        mVC.flag = flag;
        mVC.newsModel = model;
        mVC.hidesBottomBarWhenPushed     =YES;
        [self.navigationController pushViewController:mVC animated:YES];
    }];
}
-(void)pushToTravel{
    [self.loginManager pushCheckedLoginWithPopToRoot:NO block:^{
        DDTravelViewController *mVC = [[DDTravelViewController alloc] init];
        mVC.hidesBottomBarWhenPushed     =YES;
        [self.navigationController pushViewController:mVC animated:YES];
        }];
}

#pragma mark - server
//获取banner
- (void)loadBannerData
{
    //后去banner
    [YLHomeHttpUtil bannerWithBlock:^(NSDictionary *dict) {
        NSArray *array = [YLBannerModel mj_objectArrayWithKeyValuesArray:dict];
        [self.mainView updateBannerWithArray:array];
    } failure:^{
        
    }];
}

#pragma mark - push
-(void)pushToRecharge{
    [self.loginManager pushCheckedLoginWithPopToRoot:NO block:^{
        DDRechargeViewController *rechargeVC = [[DDRechargeViewController alloc] init];
        rechargeVC.hidesBottomBarWhenPushed  = YES;
        [self.navigationController pushViewController:rechargeVC animated:YES];
    }];
}
- (void)pushUserCenterVC
{
    YLUserCenterVC *vc = [[YLUserCenterVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES; //NAvi时隐藏tabbar
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushLifeUserCenter{
    DDLifeUserCenterVC *vc = [[DDLifeUserCenterVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES; //NAvi时隐藏tabbar
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushEnterpriseListVCWithCategoryId:(NSString *)categoryId title:(NSString *)title
{
    YLEnterpriseHomeListVC *vc = [[YLEnterpriseHomeListVC alloc]init];
    vc.categoryId = categoryId;
    vc.naviTitle = title;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushLoginVC
{
    YLLoginVC *vc = [[YLLoginVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)pushBannerDetailWithModel:(YLBannerModel *)model
{
    YLBannerDetailVC *vc = [[YLBannerDetailVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}




@end



