//
//  DDLifeHomeView.m
//  WitCity
//
//  Created by 方冬冬 on 16/6/24.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDLifeHomeView.h"

@implementation DDLifeHomeView

-(id)initWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName font:(UIFont *)font titleColor:(UIColor*)color titleHeight:(int)height index:(int)index{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *img = [UIImage imageNamed:imageName];
//        float padding = (frame.size.height - img.size.height -height-8)/2.0;
        float padding = 0;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2-img.size.width/2, padding, img.size.width, img.size.height)];
        imageView.image = img;
        imageView.userInteractionEnabled  = YES;
        [self addSubview:imageView];
        
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, img.size.height+padding+5, frame.size.width, height)];
        titleLable.text = title;
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.font = font;
        titleLable.textColor = color;
        [self addSubview:titleLable];
        
        //出行
        if (index == 0) {
            
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tripClick:)]];
        }
        //电影票
        if (index == 1) {
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(movieClick:)]];
        }
        //充值
        if (index == 2) {
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chargeClick:)]];
        }
        //团购
        if (index == 3) {
           [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(groupChraseClick:)]];
        }
        //市民热线
        if (index == 4) {
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hotlineClick:)]];
        }
        //招聘
//        if (index == 5) {
//            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(recruitClick:)]];
//        }
        //求职
        if (index == 6) {
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jobSeekClick:)]];
        }
        //出租
        if (index == 7) {
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rentOutClick:)]];
        }
        //求租
        if (index == 8) {
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rentWantClick:)]];
        }
        //柳梧圈
        if (index == 9) {
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LWQClick:)]];
        }
        //美食
        if (index == 10) {
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deliciousClick:)]];
        }
        //酒店
        if (index == 11) {
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hotelClick:)]];
        }
        //娱乐
        if (index == 12) {
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(entertainmentClick:)]];
        }
        //其他
        if (index == 13) {
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(otherClick:)]];
        }
        //待付款
        if (index == 14) {
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(readyPayyingClick:)]];
        }
        //待发货
        if (index == 15) {
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(readyShippingClick:)]];
        }
        //待确认
        if (index == 16) {
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(readyConfirmClick:)]];
        }
        //待评价
        if (index == 17) {
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(readyCommentClick:)]];
        }
        //售后
        if (index == 18) {
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(readyReturnClick:)]];
        }
      
    }
    return self;
}

//出行点击
- (void)tripClick:(UITapGestureRecognizer *)gesture
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeLifeHomeTraffic),
                             }];
}
//电影票点击
- (void)movieClick:(UITapGestureRecognizer *)gesture
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeLifeHomeMovieTicket),
                             }];
}
//充值点击
- (void)chargeClick:(UITapGestureRecognizer *)gesture
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeLifeHomeRecharege),
                             }];
}
//团购点击
- (void)groupChraseClick:(UITapGestureRecognizer *)gesture
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeLifeHomeGroupBuying),
                             }];
}
//市民热线点击
- (void)hotlineClick:(UITapGestureRecognizer *)gesture
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeLifeHomeHotline),
                             }];
}
////招聘点击
//- (void)recruitClick:(UITapGestureRecognizer *)gesture
//{
//    [self allBlockWithDict:@{
//                             kYLKeyForBlockType : @(kDDBlockTypeRecruit),
//                             }];
//}
//求职点击
- (void)jobSeekClick:(UITapGestureRecognizer *)gesture
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeJobWant),
                             }];
}
//出租点击
- (void)rentOutClick:(UITapGestureRecognizer *)gesture
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeRentOut),
                             }];
}
//求租点击
- (void)rentWantClick:(UITapGestureRecognizer *)gesture
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeRentWant),
                             }];
}
//柳梧圈点击
- (void)LWQClick:(UITapGestureRecognizer *)gesture
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeLWQ),
                             }];
}
//美食点击
- (void)deliciousClick:(UITapGestureRecognizer *)gesture
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeDelicious),
                             }];
}
//酒店点击
- (void)hotelClick:(UITapGestureRecognizer *)gesture
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeHotel),
                             }];
}
//娱乐点击
- (void)entertainmentClick:(UITapGestureRecognizer *)gesture
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeEntertainment),
                             }];
}
//其他点击
- (void)otherClick:(UITapGestureRecognizer *)gesture
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeOther),
                             }];
}

//待付款
- (void)readyPayyingClick:(UITapGestureRecognizer *)gesture
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeReadyPayying),
                             }];
}

//待发货
- (void)readyShippingClick:(UITapGestureRecognizer *)gesture
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeReadyShipping),
                             }];
}

//待确认
- (void)readyConfirmClick:(UITapGestureRecognizer *)gesture
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeReadyConfirm),
                             }];
}

//待评价
- (void)readyCommentClick:(UITapGestureRecognizer *)gesture
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeReadyComment),
                             }];
}

//退货
- (void)readyReturnClick:(UITapGestureRecognizer *)gesture
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeReadyReturn),
                             }];
}

@end























