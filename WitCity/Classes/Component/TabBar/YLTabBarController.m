//
//  YLTabBarController.m
//  TongHua
//
//  Created by simpletour on 16/2/29.
//  Copyright © 2016年 RY. All rights reserved.
//

#import "YLTabBarController.h"

#define kItemTag (200)

#define kYLTabBarKey (@"kYLTabBarKey")
#define kYLTabBarValue (@"kYLTabBarValue")

typedef NS_ENUM(NSUInteger, YLTabBarBlockType) {
    kYLTabBarBlockTypeCenterButton,
    kYLTabBarBlockTypeItemSelected,
};

@interface YLTabBarController ()

@property (nonatomic, strong) YLTabBarView *mainView;

@end

@implementation YLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(!_mainView) {
        [self addViews];
    }
}

-(void)addViews
{
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [self.tabBar addSubview:self.mainView];
}

-(YLTabBarView *)mainView
{
    if(!_mainView) {
        _mainView = [[YLTabBarView alloc]initWithFrame:self.tabBar.bounds];
        _mainView.backgroundColor = [UIColor whiteColor];
        [_mainView updateWithTitles:self.itemTitles defaultIcons:self.defaultIcons selectedIcons:self.selectedIcons count:self.viewControllers.count];
        _mainView.defaultColor = self.defaultColor;
        _mainView.selectedColor = self.selectedColor;
        WS(wself);
        _mainView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _mainView;
}

-(void)callbackWithDict:(NSDictionary *)dict
{
    NSInteger blockType = [dict[kYLTabBarKey] integerValue];
    switch (blockType) {
        case kYLTabBarBlockTypeCenterButton:{//中间按钮
//            NSLog(@"中间按钮点击");
        }break;
        case kYLTabBarBlockTypeItemSelected:{//选项选中
            NSInteger value = [dict[kYLTabBarValue] integerValue];
            self.selectedIndex = value;
        }break;
        default:
            break;
    }
}
@end

//#define kImageViewSize (40)
#define kImageViewSize (0)

@interface YLTabBarView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) YLTabBarItemView *selectedItem;
@property (nonatomic, strong) UIView *line;

@end


@implementation YLTabBarView

-(void)addViews
{
    [self addSubview:self.imageView];
    [self addSubview:self.line];
}

-(void)layout
{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
        make.width.and.height.mas_equalTo(kImageViewSize);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}

-(void)useStyle
{
//    self.imageView.image = [UIImage imageNamed:@"tAdd"];
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick:)]];
    self.line.backgroundColor = kYLColorLine;

}

- (void)layoutWithTitles:(NSArray *)titles defaultIcons:(NSArray *)defaultIcons selectedIcons:(NSArray *)selectedIcons count:(NSInteger)count
{
    YLTabBarItemView *itemLast;
    
    for (NSInteger i=0; i<count; i++) {
        YLTabBarItemView *item = [YLTabBarItemView new];
        [self addSubview:item];
        
        item.defaultColor = self.defaultColor;
        item.selectedColor = self.selectedColor;
        
        item.tag = kItemTag + i;
        
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            if(!itemLast) {
                make.left.mas_equalTo(0);
//            } else if (i == (count / 2)) {
//                make.left.mas_equalTo(self.imageView.mas_right);
            } else {
                make.left.mas_equalTo(itemLast.mas_right);
            }
            make.width.mas_equalTo(self).multipliedBy(1.0f / count).offset(-(kImageViewSize / 2.0f));
            make.top.and.bottom.mas_equalTo(0);
        }];
        
        [item updateWithTitle:titles[i] defaultIcon:defaultIcons[i] selectedIcon:selectedIcons[i]];
        [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemViewClick:)]];
        
        itemLast = item;
        
        if(0 == i) {
            item.selected = YES;
            self.selectedItem = item;
        }
    }
}

-(void)setDefaultColor:(UIColor *)defaultColor
{
    
    _defaultColor = defaultColor;
    [self itemViewPropertyWithBlock:^(YLTabBarItemView *item) {
        item.defaultColor = defaultColor;
    }];
}

-(void)setSelectedColor:(UIColor *)selectedColor
{
    _selectedColor = selectedColor;
    [self itemViewPropertyWithBlock:^(YLTabBarItemView *item) {
        item.selectedColor = selectedColor;
    }];
}

- (void)itemViewPropertyWithBlock:(void(^)(YLTabBarItemView *item))block
{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[YLTabBarItemView class]]) {
            block((YLTabBarItemView *)view);
        }
    }
}




- (void)updateWithTitles:(NSArray *)titles defaultIcons:(NSArray *)defaultIcons selectedIcons:(NSArray *)selectedIcons count:(NSInteger)count
{
    [self layoutWithTitles:titles defaultIcons:defaultIcons selectedIcons:selectedIcons count:count];
}


-(void)imageViewClick:(UITapGestureRecognizer *)gesture
{
    [self allBlockWithDict:@{
                             kYLTabBarKey : @(kYLTabBarBlockTypeCenterButton),
                             }];
}

-(void)itemViewClick:(UITapGestureRecognizer *)gesture
{
    [self allBlockWithDict:@{
                             kYLTabBarKey : @(kYLTabBarBlockTypeItemSelected),
                             kYLTabBarValue : @(gesture.view.tag - kItemTag)
                             }];
    YLTabBarItemView *item = (YLTabBarItemView *)gesture.view;
    self.selectedItem.selected = NO;
    item.selected = YES;
    self.selectedItem = item;
}


@end



@interface YLTabBarItemView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel     *lblTitle;


@end


@implementation YLTabBarItemView

-(void)addViews
{
    [self addSubview:self.imageView];
    [self addSubview:self.lblTitle];
}

-(void)layout
{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(5);
        make.width.and.height.mas_equalTo(25);
    }];
    
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.top.mas_equalTo(self.imageView.mas_bottom);
        make.bottom.mas_equalTo(0);
    }];
}

-(void)useStyle
{
    self.lblTitle.textAlignment = NSTextAlignmentCenter;
    self.lblTitle.font = [UIFont systemFontOfSize:13];
}

- (void)updateWithTitle:(NSString *)title defaultIcon:(UIImage *)defaultIcon selectedIcon:(UIImage *)selectedIcon
{
    self.lblTitle.text = title;
    self.imageView.image = defaultIcon;
    self.imageView.highlightedImage = selectedIcon;
}

-(void)setSelected:(BOOL)selected
{
    _selected = selected;
    self.imageView.highlighted = selected;
    self.lblTitle.highlighted = selected;
}

-(void)setDefaultColor:(UIColor *)defaultColor
{
    _defaultColor = defaultColor;
    self.lblTitle.textColor = defaultColor;
}

-(void)setSelectedColor:(UIColor *)selectedColor
{
    _selectedColor = selectedColor;
    self.lblTitle.highlightedTextColor = selectedColor;
}

@end