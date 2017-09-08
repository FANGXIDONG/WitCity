//
//  YLMacro.h
//  YLDraw
//
//  Created by simpletour on 16/1/30.
//  Copyright © 2016年 duyulong. All rights reserved.
//

#ifndef YLMacro_h
#define YLMacro_h

#import "UIColor+YL.h"
#import "YLBlockType.h"
#import "YLColor.h"
#import "YLFlatColor.h"
#import "YLUtil.h"
#import "YLUserSingleton.h"

#define APPDELEGATE ((AppDelegate*)[[UIApplication sharedApplication]delegate])
#define UD  [NSUserDefaults standardUserDefaults]
#define iOS7 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=7)
#define SystemVersion [[UIDevice currentDevice] systemVersion].floatValue
#define WINDOW_BOUNDS [[UIScreen mainScreen] bounds]
#define WINDOW_WIDTH [[UIScreen mainScreen] bounds].size.width
#define WINDOW_HEIGHT (iOS7 ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.height)

//判断设备
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define SCREEN_MAX_LENGTH (MAX(WINDOW_WIDTH, WINDOW_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(WINDOW_WIDTH, WINDOW_HEIGHT))
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

//　  rand()函数：产生随机数
//　　abs()函数/labs()函数：整数的绝对值
//　　fabs()/fabsf()/fabsl()函数：浮点数的绝对值
//　　floor()/floorf()/floorl()函数：向下取整
//　　ceil()/ceilf()/ceill()函数：向上取整
//　　round()/roundf()/roundl()函数：四舍五入
//　　sqrt()/sqrtf()/sqrtl()函数：求平方根
//　　fmax()/fmaxf()/fmaxl()函数：求最大值
//　　fmin()/fminf()/fminl()函数：求最小值

//不同屏幕尺寸字体适配（320，568是因为效果图为IPHONE5 如果不是则根据实际情况修改）
#define kScreenWidthRatio  (WINDOW_WIDTH / 375.0)
#define kScreenHeightRatio (WINDOW_HEIGHT / 667.0)
#define AdaptedWidth(x)  ceilf((x) * kScreenWidthRatio)
#define AdaptedHeight(x) ceilf((x) * kScreenHeightRatio)
#define kFontSize(R)     CHINESE_SYSTEM(AdaptedWidth(R))

//弱引用/强引用  可配对引用在外面用MPWeakSelf(self)，block用MPStrongSelf(self)  也可以单独引用在外面用MPWeakSelf(self) block里面用weakself
#define DDWeakSelf(type)  __weak typeof(type) weak##type = type;
#define DDStrongSelf(type)  __strong typeof(type) type = weak##type;


#define STATE_BAR_HEIGHT      20.0f
#define NAVIGATION_BAR_HEIGHT 44.0f
#define STATE_NAVIGATION_HEIGHT (STATE_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT)
#define TAB_BAR_HEIGHT 49.0f
#define CONTENT_HEIGHT (WINDOW_HEIGHT - STATE_NAVIGATION_HEIGHT - TAB_BAR_HEIGHT)
#define CONTENT_HEIGHT2 (WINDOW_HEIGHT - STATE_NAVIGATION_HEIGHT)
#define YLOG NSLog(@"%s", __FUNCTION__)
#define YLCOLOR(hex) [UIColor colorWithHex:hex]
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;//
#define KEY_WINDOW [UIApplication sharedApplication].keyWindow
#define ND [NSNotificationCenter defaultCenter]
#define IMAGE_PLACEHOLDER ([UIImage imageNamed:@"cImagePlaceholder"])
#define HEADER_PLACEHOLDER ([UIImage imageNamed:@"u_header"])
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kWidthRatio (kScreenWidth / 320.0)
#define kHeightRatio (iPhone6P?1.0:1.0)

//[[YLUserSingleton shareInstance].outh intValue] == 1
#define kAPPUserTypeEnterprise   ([[YLUserSingleton shareInstance].outh intValue] == 1)

#define kUpdateUserInfoNotification (@"kUpdateUserInfoNotification")
#define kUpdatePushNotification (@"kUpdatePushNotification")
#define kShowDotNotification (@"kShowDotNotification")
#define kHideDotNotification (@"kHideDotNotification")
#define kOrderWaitReceiver (@"orderWaitReceiver")
#define kOrderCompleted (@"orderCompleted")
#define kChangeVersionNotification (@"kChangeVersionNotification")
#define kChangeTextFieldTextNotification (@"kChangeTextFieldTextNotification")
#define kDDWxPayNotification  (@"kDDWxPayNotification")


#define kHistoryKey [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"kHistory"]


//上传图片相关

//最大的上传图片张数
#define kupdateMaximumNumberOfImage 3

//发布图片哄定义
#define kPadding 10
#define kTitleAndtextViewHeight 150
#define kBottomHeight      150
#define kPictureHW (WINDOW_WIDTH - 5*kPadding)/4
#define kPublishImageTableCellHeight (kPictureHW + kPadding*2)
#define MaxImageCount 3
#define kDeleImageWH 25 // 删除按钮的宽高

#endif /* YLMacro_h */





