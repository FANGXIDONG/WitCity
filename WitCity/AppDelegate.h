//
//  AppDelegate.h
//  WitCity
//
//  Created by simpletour on 16/5/18.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLTabBarController;
@class YLEnterpriseHomeVC;
@class YLEnterpriseVC;
@class YLPolicyVC;
@class YLInteractiveVC;
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    int flatInt; //构造函数中声明
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) YLTabBarController *tbc;
//@property (nonatomic, strong) YLEnterpriseHomeVC *ehc;
//@property (nonatomic, strong) YLEnterpriseVC *ec;
//@property (nonatomic, strong) YLPolicyVC *pc;
//@property (nonatomic, strong) YLInteractiveVC *ic;

@property (nonatomic ,assign) int flatInt;//传值

@end

