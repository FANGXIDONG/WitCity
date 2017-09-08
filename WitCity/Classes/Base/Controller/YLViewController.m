//
//  STMBaseViewController.m
//  STMSimpletourApp
//
//  Created by simpletour on 16/1/27.
//  Copyright © 2016年 simpletour. All rights reserved.
//

#import "YLViewController.h"
#import "UIImage+Category.h"
#import <UMMobClick/MobClick.h>

@interface YLViewController ()<CAAnimationDelegate>

@end

@implementation YLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dot.hidden = YES;
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    [self addNoneDataView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass(self.class)];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass(self.class)];
}

//pop方法
-(void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

//自定义导航条上的按钮
-(UIBarButtonItem *)buttonForNavigationBarWithAction:(SEL)action imageNamed:(NSString *)imageNamed
{
    UIButton* button= [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage reSizeImage:[UIImage imageNamed:imageNamed] toSize:CGSizeMake(20, 20)];
    [button setImage:image forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    button.tag = 999;
    UIView *view = [[UIView alloc]initWithFrame:button.bounds];
    [view addSubview:button];
    [view addSubview:self.dot];
    UIBarButtonItem *btnBar = [[UIBarButtonItem alloc]initWithCustomView:view];
    return btnBar;
}

-(UIBarButtonItem *)buttonForPublishVCNavigationBarWithAction:(SEL)action imageNamed:(NSString *)imageNamed
{
    UIButton* button= [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage reSizeImage:[UIImage imageNamed:imageNamed] toSize:CGSizeMake(20, 20)];
    [button setImage:image forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 15, 20);
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    button.tag = 999;
    UIView *view = [[UIView alloc]initWithFrame:button.bounds];
    [view addSubview:button];
    [view addSubview:self.dot];
    UIBarButtonItem *btnBar = [[UIBarButtonItem alloc]initWithCustomView:view];
    return btnBar;
}


//自定义导航条上的按钮
-(UIBarButtonItem *)buttonForNavigationBarWithAction:(SEL)action imageNamed:(NSString *)imageNamed highlightImageNamed:(NSString *)highlightImageNamed left:(BOOL)left
{
    UIButton* button= [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage reSizeImage:[UIImage imageNamed:imageNamed] toSize:CGSizeMake(20, 20)];
    UIImage *highlightImage = [UIImage reSizeImage:[UIImage imageNamed:highlightImageNamed] toSize:CGSizeMake(20, 20)];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highlightImage forState:UIControlStateHighlighted];
    if (left) {
        button.frame = CGRectMake(0, 0, 50, 50);
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    } else {
        button.frame = CGRectMake(0, 0, 50, 50);
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
    }
    
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    button.tag = 999;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [view addSubview:button];
    UIBarButtonItem *btnBar = [[UIBarButtonItem alloc]initWithCustomView:view];
    return btnBar;
}

-(UIBarButtonItem *)buttonForNavigationBarWithAction:(SEL)action imageNamed:(NSString *)imageNamed highlightImageNamed:(NSString *)highlightImageNamed  block:(void(^)(UIButton *button))block
{
    UIButton* button= [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage reSizeImage:[UIImage imageNamed:imageNamed] toSize:CGSizeMake(20, 20)];
    UIImage *highlightImage = [UIImage reSizeImage:[UIImage imageNamed:highlightImageNamed] toSize:CGSizeMake(20, 20)];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highlightImage forState:UIControlStateHighlighted];
    [button setImage:highlightImage forState:UIControlStateSelected];
    button.frame = CGRectMake(0, 0, 30, 30);
    
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    button.tag = 999;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [view addSubview:button];
    block(button);
    
    UIBarButtonItem *btnBar = [[UIBarButtonItem alloc]initWithCustomView:view];
    return btnBar;
}


//获取导航返回按钮
-(UIBarButtonItem *)backButtonForNavigationBarWithAction:(SEL)action
{
    UIImage *image = [UIImage imageNamed:@"navi_back"];
    UIBarButtonItem *btnBar = [[UIBarButtonItem alloc] initWithImage:image
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:action];
    return btnBar;
}

//自定义导航条上的文字30X30大小
-(UIBarButtonItem *)buttonForNavigationBarWithAction:(SEL)action title:(NSString *)title
{
    UIButton* button= [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 45, 30);
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    UIBarButtonItem *btnBar = [[UIBarButtonItem alloc]initWithCustomView:button];
    return btnBar;
}

//设置控制器的导航标题title
- (void)navigationWithTitle:(NSString *)title
{
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH - 100, 49)];
    titlelabel.text = title;
    titlelabel.font = [UIFont systemFontOfSize:15];
    titlelabel.textColor = [UIColor whiteColor];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titlelabel;
//    self.navigationItem.title = title;
    self.navigationItem.leftBarButtonItem = [self backButtonForNavigationBarWithAction:@selector(popViewController)];
    
}

//设置控制器的导航标题title和返回方式
- (void)navigationWithTitle:(NSString *)title popEvent:(SEL)action
{
    self.navigationItem.title = title;
    self.navigationItem.leftBarButtonItem = [self backButtonForNavigationBarWithAction:action];
}

//设置控制器的导航标题title和右边title和点击事件
- (void)navigationWithTitle:(NSString *)title rightTitle:(NSString *)rightTitle rightEvent:(SEL)rightAction
{
    self.navigationItem.title = title;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:rightTitle
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:rightAction];
}

//设置控制器的导航标题title,返回方式右边title和点击事件
- (void)navigationWithTitle:(NSString *)title rightTitle:(NSString *)rightTitle popEvent:(SEL)action rightEvent:(SEL)rightAction
{
    self.navigationItem.title = title;
    self.navigationItem.leftBarButtonItem = [self backButtonForNavigationBarWithAction:action];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:rightTitle
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:rightAction];
}

//设置控制器的左 中 右标题 和点击事件
- (void)navigationWithLeftTitle:(NSString *)leftTitle title:(NSString *)title rightTitle:(NSString *)rightTitle leftEvent:(SEL)leftAction rightEvent:(SEL)rightAction
{
    self.navigationItem.title = title;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:leftTitle
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:leftAction];
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:rightTitle
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:rightAction];
    NSMutableDictionary *normal = [NSMutableDictionary dictionary];
    normal[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [rightBar setTitleTextAttributes:normal forState:UIControlStateNormal];
    
    NSMutableDictionary *disabled = [NSMutableDictionary dictionary];
//    disabled[NSForegroundColorAttributeName] = XHHexColor(XHCOLOR_GRAY6);//禁用时的按钮颜色
    [rightBar setTitleTextAttributes:disabled forState:UIControlStateDisabled];
    
    self.navigationItem.rightBarButtonItem = rightBar;
}

- (void)addNoneDataView
{
//    self.noneDataView = [[YLNoneDataView alloc]initWithFrame:self.view.bounds];
    self.noneDataView = [[YLNoneDataView alloc]initWithFrame:CGRectMake(0, 104, WINDOW_WIDTH, WINDOW_HEIGHT - 104 - 40)];
    [self.view addSubview:self.noneDataView];
}

#pragma mark - 显示无数据视图
- (void)showNoneDataView
{
    self.noneDataView.type = self.noneDataType;
    [self.view bringSubviewToFront:self.noneDataView];
}

#pragma mark - 隐藏无数据视图
- (void)hiddenNoneDataView
{
    [self.view sendSubviewToBack:self.noneDataView];
}


-(void)setNaviStyle:(YLNavigationControllerStyle)naviStyle
{
    _naviStyle = naviStyle;
    ((YLNavigationController *)self.navigationController).style = naviStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}


//控制器push时的模态效果
- (void)pushModalWithController:(UIViewController *)controller
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:controller animated:NO];
}
//控制器pop时的模态效果
- (void)popModalViewController
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromBottom;
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)callbackWithDict:(NSDictionary *)dict{}
- (void)addViews{}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

@end
