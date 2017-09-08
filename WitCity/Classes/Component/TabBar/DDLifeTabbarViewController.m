//
//  DDLifeTabbarViewController.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/19.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDLifeTabbarViewController.h"
#import "DDTabbar.h"
#import "FXBlurView.h"
#import "YLNavigationController.h"
#import "YLEnterpriseHomeVC.h"
#import "DDNearVC.h"
#import "DDServiceViewController.h"
#import "DDCommunityVC.h"
#import "DDPublishViewController.h" //发布-柳梧圈
#import "DDPublishRentwantVC.h"     //发布求租
#import "DDPublishJobwantVC.h"      //发布求职
#import "DDPublishRecruitVC.h"      //发布招聘
#import "DDPublishRentoutVC.h"      //发布出租
#import "DDCommonView.h"


@interface DDLifeTabbarViewController ()<DDTabbarDelegate>

@property (nonatomic, weak) UIButton *plus;
@property (nonatomic, weak) FXBlurView *blurView;
@property (nonatomic, weak) UIImageView *rentView;
@property (nonatomic, weak) UIImageView *jobView;
@property (nonatomic, weak) UIImageView *lwqView;
@property (nonatomic, weak) UIImageView *recruitView;
@property (nonatomic, weak) UIImageView *rentoutView;
@end

@implementation DDLifeTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置子控制器
    YLEnterpriseHomeVC *home = [[YLEnterpriseHomeVC alloc]init];
    [self addChildViewController:home title:@"首页" image:@"tab_sy_default" selImage:@"tab_sy_selected"];
    DDNearVC *messageCenter = [[DDNearVC alloc] init];
    [self addChildViewController:messageCenter title:@"周边" image:@"tab_zb_default" selImage:@"tab_zb_selected"];
    DDServiceViewController *discover = [[DDServiceViewController alloc] init];
    [self addChildViewController:discover title:@"服务" image:@"tab_fw_default" selImage:@"tab_fw_selected"];
    DDCommunityVC *profile = [[DDCommunityVC alloc] init];
    [self addChildViewController:profile title:@"社区" image:@"tab_sq_default" selImage:@"tab_sq_selected"];

    //更换系统自带的tabbar
    DDTabbar *tab = [[DDTabbar alloc]init];
    tab.delegate = self;
    [self setValue:tab forKey:@"tabBar"];
    
    [self customTabbarBg];
    
}

//----------------------- 设置中间发布按钮向上凸起 -------------------------------------

-(void)customTabbarBg{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -8, self.tabBar.frame.size.width, self.tabBar.frame.size.height)];
    [imageView setImage:[UIImage imageNamed:@"tab_bg"]];
    [imageView setContentMode:UIViewContentModeCenter];
    [self.tabBar insertSubview:imageView atIndex:0];
    //覆盖原生Tabbar的上横线
    [[UITabBar appearance] setShadowImage:[self createImageWithColor:[UIColor clearColor]]];
    [[UITabBar appearance] setBackgroundImage:[self createImageWithColor:[UIColor clearColor]]];
    //设置TintColor
    UITabBar.appearance.tintColor = [UIColor orangeColor];
    
}

-(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


//设置中间按钮不受TintColor影响
- (void)awakeFromNib {
    [super awakeFromNib];
    NSArray *items =  self.tabBar.items;
    UITabBarItem *btnAdd = items[2];
    btnAdd.image = [btnAdd.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    btnAdd.selectedImage = [btnAdd.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}



//----------------------------------------------------------------------------

//添加子控制器
-(void)addChildViewController:(UIViewController *)childVc  title:(NSString *)title image:(NSString *)image selImage:(NSString *)selImage {
    
    //设置子控制器的TabBarButton属性
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary *AttrDic = [NSMutableDictionary dictionary];
    AttrDic[NSForegroundColorAttributeName] = [UIColor grayColor];
    [childVc.tabBarItem setTitleTextAttributes:AttrDic forState:UIControlStateNormal];
    NSMutableDictionary *selAttr = [NSMutableDictionary dictionary];
    selAttr[NSForegroundColorAttributeName] = kYLColorFontYellow;
    [childVc.tabBarItem setTitleTextAttributes:selAttr forState:UIControlStateSelected];
    //让子控制器包装一个导航控制器
    YLNavigationController *nav = [[YLNavigationController alloc]initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
}

-(void)tabBarDidClickPlusButton:(DDTabbar *)tabBar {
    
    FXBlurView *blurView = [[FXBlurView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    blurView.tintColor = [UIColor clearColor];
    self.blurView = blurView;
    [self.view addSubview:blurView];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, blurView.height - 44)];
    view.backgroundColor = [UIColor whiteColor];
    view.alpha = 0.1;
    [blurView addSubview:view];
    
    UIView *bottom = [[UIView alloc]init];
    bottom.frame = CGRectMake(0, self.view.bounds.size.height - 44, self.view.bounds.size.height, 44);
    bottom.backgroundColor = [UIColor whiteColor];
    bottom.contentMode = UIViewContentModeCenter;
    
    UIButton *plus = [UIButton buttonWithType:UIButtonTypeCustom];
    plus.frame = CGRectMake((self.view.bounds.size.width - 40) * 0.5, (TAB_BAR_HEIGHT- 40)/2*0.5, 40, 40);
    [plus setImage:[UIImage imageNamed:@"fb_x"] forState:UIControlStateNormal];
    [bottom addSubview:plus];
    
    [UIView animateWithDuration:0.2 animations:^{
        //旋转90度
        plus.transform = CGAffineTransformMakeRotation(M_PI_2);
        self.plus = plus;
    }];
    
    [plus addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    [blurView addSubview:bottom];
    
     float gapToGap = 0.0;
    if (IS_IPHONE_4_OR_LESS) {
        gapToGap = 25;
    }
    if (IS_IPHONE_5) {
        gapToGap = 30;
    }
    if (IS_IPHONE_6) {
        gapToGap = 35;
    }
    if (IS_IPHONE_6P) {
        gapToGap = 40;
    }

    float gapToSelf = 2*gapToGap;
    float width = (WINDOW_WIDTH - 2*gapToSelf - 2*gapToGap)/3;
    float height = width +30;
    float originY =CONTENT_HEIGHT2  - gapToSelf/2 - height;
    float jobOriginX = gapToSelf + width + gapToGap;
    float lwqOriginX = WINDOW_WIDTH - gapToSelf - width;
//    float rentoutOriginX = gapToSelf + width +gapToGap/2 - width/2;
//    float recruitOriginX = lwqOriginX - gapToGap/2 - width/2;
    float originTopY = originY - height;
    
    UIImageView *rentView =[self btnAnimateWithFrame:CGRectMake(gapToSelf, WINDOW_HEIGHT+44, width, height) imageName:@"fb_qiuzu" text:@"求租" animateFrame:CGRectMake(gapToSelf, originY, width, height) delay:0.3f];;
    [self setAction:rentView action:@selector(publishRentwant)];
    self.rentView = rentView;
    
    UIImageView *lwqView =[self btnAnimateWithFrame:CGRectMake(lwqOriginX, WINDOW_HEIGHT+44, width, height) imageName:@"fb_lwq" text:@"柳梧圈" animateFrame:CGRectMake(lwqOriginX, originY, width, height) delay:0.4f];
    [self setAction:lwqView action:@selector(publishLwq)];
    self.lwqView = lwqView;
    
    UIImageView *rentoutView =[self btnAnimateWithFrame:CGRectMake(jobOriginX, WINDOW_HEIGHT+44, width, height) imageName:@"sq_cz" text:@"出租" animateFrame:CGRectMake(jobOriginX, originY, width, height) delay:0.35f];
    [self setAction:rentoutView action:@selector(publishRentout)];
    self.rentoutView = rentoutView;
    
    //1-企业，2-个人用户
    if ([[YLUserSingleton shareInstance].uid intValue] == 1) {
        UIImageView *jobView =[self btnAnimateWithFrame:CGRectMake(jobOriginX, WINDOW_HEIGHT+44, width, height) imageName:@"fb_qiuzhi" text:@"求职" animateFrame:CGRectMake(jobOriginX, originTopY, width, height) delay:0.25f];
        [self setAction:jobView action:@selector(publishJobwant)];
        self.jobView = jobView;
       
    }else{
        UIImageView *recruitView =[self btnAnimateWithFrame:CGRectMake(jobOriginX, WINDOW_HEIGHT+44, width, height) imageName:@"sq_zp" text:@"招聘" animateFrame:CGRectMake(jobOriginX, originTopY, width, height) delay:0.2f];;
        [self setAction:recruitView action:@selector(publishRecruit)];
        self.recruitView = recruitView;
    }
}

//按钮出来动画
-(UIImageView *)btnAnimateWithFrame:(CGRect)frame imageName:(NSString *)imageName text:(NSString *)text animateFrame:(CGRect)aniFrame delay:(CGFloat)delay {
    
    UIImageView *btnContainer = [[UIImageView alloc]init];
    btnContainer.frame  = frame;
    
//    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btnContainer.frame.size.width, btnContainer.frame.size.width)];
    imageV.image = [UIImage imageNamed:imageName];
    [btnContainer addSubview:imageV];
    
    UILabel *word = [[UILabel alloc]initWithFrame:CGRectMake(0, imageV.frame.size.height + 5, btnContainer.frame.size.width, 25)];
    [word setText:text];
    [word setTextAlignment:NSTextAlignmentCenter];
    [word setFont:[UIFont systemFontOfSize:14]];
    [word setTextColor:[UIColor blackColor]];

    [btnContainer addSubview:word];
    
    [self.blurView addSubview:btnContainer];
    
    [UIView animateWithDuration:0.5 delay:delay usingSpringWithDamping:0.6 initialSpringVelocity:0.05 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        btnContainer.frame  = aniFrame;
        
    } completion:^(BOOL finished) {
        
    }];
    return btnContainer;
}


//设置按钮方法
-(void)setAction:(UIImageView *)imageView action:(SEL)action{
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:action];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:gesture];
}

-(void)publishRentout{
    
    [self closeClick];
    DDPublishRentoutVC *publishRentout = [[DDPublishRentoutVC alloc]init];
    YLNavigationController *nav = [[YLNavigationController alloc]initWithRootViewController:publishRentout];
    nav.style = 1;
    [self presentViewController:nav animated:YES completion:nil];
}
-(void)publishRecruit{

    [self closeClick];
    DDPublishRecruitVC *publishRecruit = [[DDPublishRecruitVC alloc]init];
    YLNavigationController *nav = [[YLNavigationController alloc]initWithRootViewController:publishRecruit];
    nav.style = 1;
    [self presentViewController:nav animated:YES completion:nil];
}

//发布求职
-(void)publishJobwant{
    [self closeClick];
    DDPublishJobwantVC *publishLwq = [[DDPublishJobwantVC alloc]init];
    YLNavigationController *nav = [[YLNavigationController alloc]initWithRootViewController:publishLwq];
    nav.style = 1;
    [self presentViewController:nav animated:YES completion:nil];
}

//发布求租
-(void)publishRentwant{
    [self closeClick];
    DDPublishRentwantVC *publishLwq = [[DDPublishRentwantVC alloc]init];
    YLNavigationController *nav = [[YLNavigationController alloc]initWithRootViewController:publishLwq];
    nav.style = 1;
    [self presentViewController:nav animated:YES completion:nil];
}

//发布-柳梧圈
-(void)publishLwq {
    
    [self closeClick];
    DDPublishViewController *publishLwq = [[DDPublishViewController alloc]init];
    YLNavigationController *nav = [[YLNavigationController alloc]initWithRootViewController:publishLwq];
    nav.style = 1;
    [self presentViewController:nav animated:YES completion:nil];
}


//关闭动画
-(void)btnCloseAnimateWithFrame:(CGRect)rect delay:(CGFloat)delay btnView:(UIImageView *)btnView{
    
    [UIView animateWithDuration:0.3 delay:delay usingSpringWithDamping:0.6 initialSpringVelocity:0.05 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        btnView.frame  = rect;
        
    } completion:^(BOOL finished) {
        
    }];
}



//关闭按钮
-(void)closeClick {
    
    [UIView animateWithDuration:0.6 animations:^{
        
        self.plus.transform = CGAffineTransformMakeRotation(-M_PI_2);
        
        [self btnCloseAnimateWithFrame:CGRectMake(180, 700, 71, 100) delay:0.25 btnView:self.jobView];
        [self btnCloseAnimateWithFrame:CGRectMake(120, 700, 71, 100) delay:0.3 btnView:self.rentView];
        [self btnCloseAnimateWithFrame:CGRectMake(273, 700, 71, 100) delay:0.1 btnView:self.lwqView];
        [self btnCloseAnimateWithFrame:CGRectMake(152, 700, 71, 100) delay:0.15 btnView:self.rentoutView];
        [self btnCloseAnimateWithFrame:CGRectMake(41, 700, 71, 100) delay:0.2 btnView:self.recruitView];
        
    } completion:^(BOOL finished) {

        [self.rentView removeFromSuperview];
        [self.jobView removeFromSuperview];
        [self.lwqView removeFromSuperview];
        [self.recruitView removeFromSuperview];
        [self.rentoutView removeFromSuperview];
        [self.blurView removeFromSuperview];
    }];
    
    
}

@end
