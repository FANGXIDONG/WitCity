//
//  AppDelegate.m
//  WitCity
//
//  Created by simpletour on 16/5/18.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "AppDelegate.h"
#import "YLTabBarController.h"
#import "YLEnterpriseHomeVC.h"
//#import "DDSegementVC.h"
#import "DDEnterpriseVC.h"
#import "YLPolicyVC.h"
#import "YLInteractiveVC.h"
#import <UMMobClick/MobClick.h>
#import "UMessage.h"
#import "YLThirdAPIKey.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "YLLoginManager.h"
#import "YLGuideController.h"

#import "DDLifeTabbarViewController.h"
#import "DDCustomActivity.h"
#import <WXApi.h>


#import "DDLifeVersionHttpEncryptUtil.h"


#define kAPPDownLoadUrl @"https://itunes.apple.com/cn/app/id1168425086"

#pragma clang diagnostic pop

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@interface AppDelegate ()<WXApiDelegate>

@property (nonatomic, strong) YLLoginManager *loginManager;

@end

@implementation AppDelegate
@synthesize flatInt = flatInt;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //【注意】如果项目中第三方分享用的是友盟，在注册的时候要把友盟注册放在微信注册的前面执行。
    
    //注册友盟
    [UMSocialData setAppKey:UMengKey];
    //友盟统计
    
//    [MobClick startWithAppkey:UMengKey reportPolicy:BATCH   channelId:@""];
    //设置微信AppId，设置分享url
    [UMSocialWechatHandler setWXAppId:kWeChatID appSecret:kWeChatAsecret url:kWebsiteUrl];
    
    // 设置微博的AppKey、appSecret，分享url
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:kWeChatID
                                              secret:kWeChatAsecret
                                         RedirectURL:kWebsiteUrl];
    
    //设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];
    //注册Push
    [self registerUMessagePush:launchOptions];
    //日志加密模式
    [MobClick setEncryptEnabled:YES];
    
    //微信支付
    [WXApi registerApp:wechatAppID withDescription:@"微信支付"];
    
//    //检测版本更新
    //这里比较版本号不是不一样就提示更新升级。而是当前版本号如果比AppStore版备号小的时候提示弹框升级。这样做的最大好处就是苹果在审核App时不会出现提示升级
    [self updateAlert];
    
    
    
    [DDLifeVersionHttpEncryptUtil testBlock:^(NSDictionary *dict) {
        NSLog(@"o");
    } failure:^{
        //
    }];
    
    
    
    
//    NSString *string = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://itunes.apple.com/lookup?id=1168425086"] encoding:NSUTF8StringEncoding error:nil];
//    if (string!=nil  &&  [string length]>0  &&  [string rangeOfString:@"version"].length==7) {
//        [self checkAppUpdate:string];
//    }
    
    //3D TOUCH
    [self setting3DTouchModule];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    //init tabBar
    [self initAppTabBarController];
    NSLog(@"%@",[UD objectForKey:@"username"]);
    NSLog(@"%@",[UD objectForKey:@"password"]);
    if ([UD objectForKey:@"username"] && [UD objectForKey:@"password"]) {
        [self.loginManager loginWithUsername:[UD objectForKey:@"username"]password:[UD objectForKey:@"password"] block:^(NSDictionary *dict) {
        } failure:^{}];
    }
    
    if (![UD objectForKey:@"firstLogin"]) {
        YLGuideController *guideVC = [[YLGuideController alloc]init];
        self.window.rootViewController = guideVC;
    } else {
//        self.window.rootViewController = self.tbc;
    }
    
    [ND addObserver:self selector:@selector(changeVersion:) name:kChangeVersionNotification object:nil];
    
    return YES;
}

-(void)updateAlert{
    
    NSString *url = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",AppID];
    //网络请求App的信息（我们取Version就够了）
    NSURL *uurl = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:uurl
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSMutableDictionary *receiveStatusDic=[[NSMutableDictionary alloc]init];
        if (data) {
            //data是有关于App所有的信息
            NSDictionary *receiveDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if ([[receiveDic valueForKey:@"resultCount"] intValue]>0) {
                
                [receiveStatusDic setValue:@"1" forKey:@"status"];
                [receiveStatusDic setValue:[[[receiveDic valueForKey:@"results"] objectAtIndex:0] valueForKey:@"version"]   forKey:@"version"];
                
                //请求的有数据，进行版本比较
                [self performSelectorOnMainThread:@selector(receiveData:) withObject:receiveStatusDic waitUntilDone:NO];
            }else{
                
                [receiveStatusDic setValue:@"-1" forKey:@"status"];
            }
        }else{
            [receiveStatusDic setValue:@"-1" forKey:@"status"];
        }
    }];
    
    [task resume];
}
//弹窗比较
-(void)receiveData:(id)sender
{
    //获取APP自身版本号
    NSString *localVersion = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    
    NSArray *localArray = [localVersion componentsSeparatedByString:@"."];
    NSArray *versionArray = [sender[@"version"] componentsSeparatedByString:@"."];
    
    
    if ((versionArray.count == 3) && (localArray.count == versionArray.count)) {
        
        if ([localArray[0] intValue] <  [versionArray[0] intValue]) {
            [self updateVersion];
        }else if ([localArray[0] intValue]  ==  [versionArray[0] intValue]){
            if ([localArray[1] intValue] <  [versionArray[1] intValue]) {
                [self updateVersion];
            }else if ([localArray[1] intValue] ==  [versionArray[1] intValue]){
                if ([localArray[2] intValue] <  [versionArray[2] intValue]) {
                    [self updateVersion];
                }
            }
        }
    }
}
//升级提示及跳转
-(void)updateVersion{
    NSString *msg = [NSString stringWithFormat:@"又出新版本啦，快点更新吧!"];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"升级提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"下次再说" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"现在升级"style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kAPPDownLoadUrl]];
        [[UIApplication sharedApplication]openURL:url];
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    
}

-(void)dealloc
{
    [ND removeObserver:self name:kChangeVersionNotification object:nil];
}

-(void)setting3DTouchModule{
    
    //3D TOUCH在iOS9.0以后可使用
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0){
        
        //添加3D touch
        //栏目1
        UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare];
        UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc] initWithType:@"com.dd.share" localizedTitle:@"分享”智慧柳梧“" localizedSubtitle:nil icon:icon1 userInfo:nil];
        //    application.shortcutItems = @[item1];
        NSArray *shortItems = [[NSArray alloc] initWithObjects: item1, nil];
        [[UIApplication sharedApplication] setShortcutItems:shortItems];
    }
}

#pragma mark -  3D Touch 代理方法
-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    //    //根据Item对应的type标识处理对应的点击操作
    //    NSString *itemType = shortcutItem.type;
    //    if([itemType isEqualToString:@"com.dd.share"]){
    
    //调系统分享
    NSString *title = @"";
    NSString *content = @"智慧柳梧是西藏柳梧地区内容最丰富、最具权威的移动手机应用。";
    UIImage *image = [UIImage imageNamed:@"app_icon"];
    NSURL *url = [NSURL URLWithString:kAPPDownLoadUrl];
    NSArray *activityItems = @[title, content, image, url];
    DDCustomActivity *customActivity = [[DDCustomActivity alloc] initWithImage:image atURL:url atTitle:title atShareContentArray:activityItems];
    
    NSArray *apps = @[customActivity];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:apps];
    activityVC.excludedActivityTypes = @[UIActivityTypeMessage, UIActivityTypeCopyToPasteboard];
    [self.window.rootViewController presentViewController:activityVC animated:YES completion:nil];
    
    //    }
    
}

#pragma mark - 比较当前版本与新上线版本比较

-(void)checkAppUpdate:(NSString *)appInfo{
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString *appInfo1 = [appInfo substringFromIndex:[appInfo rangeOfString:@"\"version\":"].location+10];
    appInfo1 = [[appInfo1 substringToIndex:[appInfo1 rangeOfString:@","].location] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    /**
     *  如果当前版本与发布的版本不相同，则提示更新；如果相等，那么当前就是最新版本
     */
    
    if (![appInfo1 isEqualToString:version]) {
        
        NSLog(@"新版本：%@，当前版本%@",appInfo1,version);
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"新版本 %@ 已发布!",appInfo1] delegate:self cancelButtonTitle:@"暂不更新" otherButtonTitles:nil, nil];
        alert.delegate = self;
        [alert addButtonWithTitle:@"前往更新"];
        [alert show];
        alert.tag = 20;
    }
    else{
        
        //        [[[UIAlertView alloc] initWithTitle:nil message:@"已是最高版本" delegate:self.class cancelButtonTitle:@"知道了" otherButtonTitles:nil] show];
        
    }
}

#pragma mark - UIAlertView代理方法

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    NSLog(@"%ld",(long)buttonIndex);
    
    if (buttonIndex == 0) {
        //退出程序
        //        [self exitApplication];
    }
    if (buttonIndex == 1) {
        
        //这里添加了多线程，消除警告
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            //            NSURL *appStoreUrl = [NSURL URLWithString:[NSString stringWithFormat:kAppStore_APPVersionUrl,APP_ID]];
            
            NSString *appStoreUrl = kAPPDownLoadUrl;
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStoreUrl]];
            NSLog(@"链接--%@",appStoreUrl);
        });
    }
    
}
-(void)changeVersion:(NSNotification *)text{
    
    if ([text.userInfo[@"intVersions"] isEqualToString:@"0"]){
        
        flatInt = 0;
        [self initAppTabBarController];
    }else{
        flatInt = 1;
        [self initLifeAppTabBarController];
    }
}

//生活版tabbar
-(void)initLifeAppTabBarController{

    DDLifeTabbarViewController *lifeTabVC = [[DDLifeTabbarViewController alloc] init];
    self.window.rootViewController =lifeTabVC;
    
    self.loginManager = [[YLLoginManager alloc]initWithController:lifeTabVC];
}

//企业版tabbar
-(void)initAppTabBarController
{
    
    YLEnterpriseHomeVC *ehcc = [[YLEnterpriseHomeVC alloc]init];

    DDEnterpriseVC *ecc = [[DDEnterpriseVC alloc]init];
    YLPolicyVC *pcc = [[YLPolicyVC alloc]init];
    YLInteractiveVC *icc = [[YLInteractiveVC alloc]init];
    self.tbc = [[YLTabBarController alloc] init];
    
    YLNavigationController *ehcn = [[YLNavigationController alloc]initWithRootViewController:ehcc];
    YLNavigationController *ecn = [[YLNavigationController alloc]initWithRootViewController:ecc];
    YLNavigationController *pcn = [[YLNavigationController alloc] initWithRootViewController:pcc];
    YLNavigationController *icn = [[YLNavigationController alloc] initWithRootViewController:icc];
    
    self.tbc.itemTitles = @[@"首页", @"企业", @"政策", @"互动"];
    self.tbc.defaultIcons = @[[UIImage imageNamed:@"th_default"],
                              [UIImage imageNamed:@"te_default"],
                              [UIImage imageNamed:@"tp_default"],
                              [UIImage imageNamed:@"ti_default"],
                              ];
    
    self.tbc.selectedIcons = @[[UIImage imageNamed:@"th_selected"],
                               [UIImage imageNamed:@"te_selected"],
                               [UIImage imageNamed:@"tp_selected"],
                               [UIImage imageNamed:@"ti_selected"],
                               ];
    
    self.tbc.defaultColor = [UIColor blackColor];
    self.tbc.selectedColor = kYLColorFontBlue;
    self.tbc.viewControllers = @[ehcn, ecn, pcn, icn];
    
    self.window.rootViewController = self.tbc;
    
    self.loginManager = [[YLLoginManager alloc]initWithController:ehcc];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


///**
// 这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
// */
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
//    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
//}
//
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
//    return [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
//}

/**
 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
 */
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UMSocialSnsService  applicationDidBecomeActive];
}

#pragma mark - push
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *pdvicetToken =[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                              stringByReplacingOccurrencesOfString: @">" withString: @""]
                             stringByReplacingOccurrencesOfString: @" " withString: @""];
    NSLog(@"pdvicetToken = %@", pdvicetToken);
    [UMessage registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    [UMessage didReceiveRemoteNotification:userInfo];
}


/**
 *  注册push消息
 */
- (void)registerUMessagePush:(NSDictionary *)launchOptions
{
    [UMessage startWithAppkey:UMengKey launchOptions:launchOptions];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    if(SystemVersion > 8.0) {
        //register remoteNotification types （iOS 8.0及其以上版本）
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"Accept";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"category1";//这组动作的唯一标示
        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        
        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                     categories:[NSSet setWithObject:categorys]];
        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
        
    } else {
        //register remoteNotification types (iOS 8.0以下)
        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
         |UIRemoteNotificationTypeSound
         |UIRemoteNotificationTypeAlert];
    }
#else
    
    //register remoteNotification types (iOS 8.0以下)
     [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
     |UIRemoteNotificationTypeSound
     |UIRemoteNotificationTypeAlert];
    
#endif
    //for log
    [UMessage setLogEnabled:YES];
}


//
//前面的两个方法被iOS9弃用了，如果是Xcode7.2网上的话会出现无法进入进入微信的onResp回调方法，就是这个原因。本来我是不想写着两个旧方法的，但是一看官方的demo上写的这两个，我就也写了。。。。

//9.0前的方法，为了适配低版本 保留
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    if ([[url scheme] isEqualToString:wechatAppID]) {
        return [WXApi handleOpenURL:url delegate:self];
    }else{
        return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    if ([[url scheme] isEqualToString:wechatAppID]) {
        return [WXApi handleOpenURL:url delegate:self];
    }else{
        return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
    }
}

//9.0后的方法
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    //这里判断是否发起的请求为微信支付，如果是的话，用WXApi的方法调起微信客户端的支付页面（://pay 之前的那串字符串就是你的APPID，）
    return  [WXApi handleOpenURL:url delegate:self];
}


//微信SDK自带的方法，处理从微信客户端完成操作后返回程序之后的回调方法,显示支付结果的
-(void) onResp:(BaseResp*)resp
{
    NSString * wxPayResult;
    //启动微信支付的response
    NSString *payResoult = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case 0:
                payResoult = @"支付结果：成功！";
                wxPayResult = @"success";
                break;
            case -1:
                payResoult = @"支付结果：失败！";
                wxPayResult = @"faile";
                break;
            case -2:
                payResoult = @"用户已经退出支付！";
                wxPayResult = @"cancel";
                break;
            default:
                payResoult = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                wxPayResult = @"faile";
                break;
        }
        
    }
    //发出通知 从微信回调回来之后,发一个通知,让请求支付的页面接收消息,并且展示出来,或者进行一些自定义的展示或者跳转
    NSNotification * notification = [NSNotification notificationWithName:kDDWxPayNotification object:wxPayResult];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

@end
