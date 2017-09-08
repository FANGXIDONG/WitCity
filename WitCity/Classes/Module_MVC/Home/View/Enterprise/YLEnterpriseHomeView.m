//
//  YLEnterpriseHomeView.m
//  WitCity
//
//  Created by simpletour on 16/5/18.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLEnterpriseHomeView.h"
#import "YLBannerView.h"


@interface YLEnterpriseHomeView ()

@property (nonatomic, strong) YLBannerView *bannerView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) YLEnterpriseHomeItemView *itemBusiness;//工商管理
@property (nonatomic, strong) YLEnterpriseHomeItemView *itemTax;//企业纳税
@property (nonatomic, strong) YLEnterpriseHomeItemView *itemBuild;//建设管理
@property (nonatomic, strong) YLEnterpriseHomeItemView *itemEconomy;//经济发展
@property (nonatomic, strong) YLEnterpriseHomeItemView *itemOpen;//开办设计

@end

@implementation YLEnterpriseHomeView

-(void)addViews
{
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.bannerView];
    [self.scrollView addSubview:self.itemBusiness];
    [self.scrollView addSubview:self.itemTax];
    [self.scrollView addSubview:self.itemBuild];
    [self.scrollView addSubview:self.itemEconomy];
    [self.scrollView addSubview:self.itemOpen];
}

-(void)layout
{
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.mas_equalTo(0);
        make.width.mas_equalTo(WINDOW_WIDTH);
        make.height.mas_equalTo(kBannerViewHeight);
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(WINDOW_WIDTH);
        make.bottom.mas_equalTo(0);
    }];
    
    [self.itemTax mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bannerView.mas_bottom).offset(16);
        make.right.mas_equalTo(self).offset(-16);
        make.width.mas_equalTo(self).multipliedBy(0.5);
        make.height.mas_equalTo(100);
    }];
    
    [self.itemBuild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.width.and.height.mas_equalTo(self.itemTax);
        make.top.mas_equalTo(self.itemTax.mas_bottom).offset(16);
    }];
    
    [self.itemBusiness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.itemTax);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(self.itemTax.mas_left).offset(-16);
        make.bottom.mas_equalTo(self.itemBuild);
    }];
    
    [self.itemOpen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.itemBuild.mas_bottom).offset(16);
        make.right.mas_equalTo(self.itemTax);
        make.width.mas_equalTo((WINDOW_WIDTH - (16 * 3)) / 2.0f);
        make.height.mas_equalTo(130);
    }];
    
    
    [self.itemEconomy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.width.and.height.mas_equalTo(self.itemOpen);
        make.left.mas_equalTo(16);
    }];
}

-(void)useStyle
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.scrollView.contentSize = CGSizeMake(WINDOW_WIDTH, 600);
    });
    
    self.itemBusiness.title = @"工商管理";
    self.itemTax.title = @"企业纳税";
    self.itemBuild.title = @"建设管理";
    self.itemEconomy.title = @"经济发展";
    self.itemOpen.title = @"开办设立";
    
    self.itemBusiness.backgroundColor = [UIColor colorWithHex:0x1f277c];
    self.itemTax.backgroundColor = [UIColor colorWithHex:0x3141d2];
    self.itemBuild.backgroundColor = [UIColor colorWithHex:0x6775ff];
    self.itemEconomy.backgroundColor = [UIColor colorWithHex:0x629dff];
    self.itemOpen.backgroundColor = [UIColor colorWithHex:0xb5d1ff];
    
    self.itemBusiness.imageNamed = @"sy_gsgl_03";
    self.itemTax.imageNamed = @"sy_qyns_03";
    self.itemBuild.imageNamed = @"sy_jsgl_03";
    self.itemEconomy.imageNamed = @"sy_jjfz_03";
    self.itemOpen.imageNamed = @"sy_kbsl_03";
    self.itemEconomy.textColor = kYLColorFontBlue;
    self.itemOpen.textColor = kYLColorFontBlue;
    
    [self.itemBusiness addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(businessClick:)]];
    [self.itemTax addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taxClick:)]];
    [self.itemBuild addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buildClick:)]];
    [self.itemEconomy addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(economyClick:)]];
    [self.itemOpen addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openClick:)]];
    
    WS(ws);
    self.bannerView.allBlock = ^(NSDictionary *dict) {
        [ws allBlockWithDict:dict];
    };
}

//工商管理点击
- (void)businessClick:(UITapGestureRecognizer *)gesture
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kYLBlockTypeHomeBusiness),
                             }];
}

//企业纳税点击
- (void)taxClick:(UITapGestureRecognizer *)gesture
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kYLBlockTypeHomeTax),
                             }];
}

//建设管理点击
- (void)buildClick:(UITapGestureRecognizer *)gesture
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kYLBlockTypeHomeBuild),
                             }];
}

//经济发展点击
- (void)economyClick:(UITapGestureRecognizer *)gesture
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kYLBlockTypeHomeEconomy),
                             }];
}

//开办设立点击
- (void)openClick:(UITapGestureRecognizer *)gesture
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kYLBlockTypeHomeOpen),
                             }];
}


- (void)updateBannerWithArray:(NSArray *)array
{
    [self.bannerView updateWithArray:array];
}

@end


#define kImageViewSize (40)

@interface YLEnterpriseHomeItemView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *lblTitle;

@end

@implementation YLEnterpriseHomeItemView

-(void)addViews
{
    [self addSubview:self.imageView];
    [self addSubview:self.lblTitle];
}

-(void)layout
{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self).offset(-10);
        make.centerX.mas_equalTo(self);
        make.width.and.height.mas_equalTo(kImageViewSize);
    }];
    
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.top.mas_equalTo(self.imageView.mas_bottom).offset(5);
    }];
}

-(void)useStyle
{
    self.userInteractionEnabled = YES;
    self.lblTitle.textColor = [UIColor whiteColor];
    self.lblTitle.font = [UIFont systemFontOfSize:15];
    self.lblTitle.textAlignment = NSTextAlignmentCenter;
}

-(void)setTitle:(NSString *)title
{
    self.lblTitle.text = title;
}

-(void)setImageNamed:(NSString *)imageNamed
{
    self.imageView.image = [UIImage imageNamed:imageNamed];
}

-(void)setTextColor:(UIColor *)textColor
{
    self.lblTitle.textColor = textColor;
}

@end


