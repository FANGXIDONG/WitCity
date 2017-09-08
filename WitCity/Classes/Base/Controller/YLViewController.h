//
//  STMBaseViewController.h
//  STMSimpletourApp
//
//  Created by simpletour on 16/1/27.
//  Copyright © 2016年 simpletour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLMacro.h"
#import "YLBlockType.h"
#import "YLToast.h"
#import "YLNoneDataView.h"
#import "UINavigationBar+Awesome.h"
#import "YLNavigationController.h"

@interface YLViewController : UIViewController

@property (nonatomic, assign) YLNavigationControllerStyle naviStyle;

//消息的点
@property (nonatomic, strong) UIView *dot;

//无数据View
@property (nonatomic, strong) YLNoneDataView *noneDataView;

//空数据类型
@property (nonatomic, assign) NSInteger noneDataType;

- (void)showNoneDataView;
- (void)hiddenNoneDataView;
//pop方法
-(void)popViewController;

//自定义导航条上的按钮
-(UIBarButtonItem *)buttonForNavigationBarWithAction:(SEL)action imageNamed:(NSString *)imageNamed;

//自定义导航条上的按钮
-(UIBarButtonItem *)buttonForNavigationBarWithAction:(SEL)action imageNamed:(NSString *)imageNamed highlightImageNamed:(NSString *)highlightImageNamed left:(BOOL)left;

-(UIBarButtonItem *)buttonForNavigationBarWithAction:(SEL)action imageNamed:(NSString *)imageNamed highlightImageNamed:(NSString *)highlightImageNamed  block:(void(^)(UIButton *button))block;

//获取导航返回按钮
-(UIBarButtonItem *)backButtonForNavigationBarWithAction:(SEL)action;

//发布页面上的返回按钮，present过来
-(UIBarButtonItem *)buttonForPublishVCNavigationBarWithAction:(SEL)action imageNamed:(NSString *)imageNamed;

//自定义导航条上的文字30X30大小
-(UIBarButtonItem *)buttonForNavigationBarWithAction:(SEL)action title:(NSString *)title;

//设置控制器的导航标题title
- (void)navigationWithTitle:(NSString *)title;

//设置控制器的导航标题title和返回方式
- (void)navigationWithTitle:(NSString *)title popEvent:(SEL)action;

//设置控制器的导航标题title和右边title和点击事件
- (void)navigationWithTitle:(NSString *)title rightTitle:(NSString *)rightTitle rightEvent:(SEL)rightAction;

//设置控制器的导航标题title,返回方式右边title和点击事件
- (void)navigationWithTitle:(NSString *)title rightTitle:(NSString *)rightTitle popEvent:(SEL)action rightEvent:(SEL)rightAction;

//设置控制器的左 中 右标题 和点击事件
- (void)navigationWithLeftTitle:(NSString *)leftTitle title:(NSString *)title rightTitle:(NSString *)rightTitle leftEvent:(SEL)leftAction rightEvent:(SEL)rightAction;

//控制器push时的模态效果
- (void)pushModalWithController:(UIViewController *)controller;
//控制器pop时的模态效果
- (void)popModalViewController;

- (void)callbackWithDict:(NSDictionary *)dict;

- (void)addViews;

@end
