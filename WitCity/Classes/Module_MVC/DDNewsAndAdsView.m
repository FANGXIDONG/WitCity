//
//  DDNewsAndAdsView.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/14.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDNewsAndAdsView.h"

#define kWeatherViewHeight  80/239.5 * self.imageView.frame.size.height

@interface DDNewsAndAdsView()
@property (nonatomic, strong) UIImageView *imageView;    //图片
@property (nonatomic ,strong) UIImageView *dateImgView;  //本地的日期图片
@property (nonatomic ,strong) UILabel *newsTitleLabel;   //新闻标题
@property (nonatomic ,strong) UILabel *adsTitleTopLabel; //广告标题
@property (nonatomic ,strong) UILabel *adsTitleBottomLabel;//广告标题
@property (nonatomic, strong) DDNewsModel *model;
@property (nonatomic ,strong) DDWeatherView *weatherView;   //天气视图

@end

@implementation DDNewsAndAdsView

- (instancetype)initWithFrame:(CGRect)frame newsAndAdsmodel:(DDNewsModel *)naModel weatherModel:(DDWeatherModel *)wModel{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.userInteractionEnabled = YES;
        [self addSubview:_imageView];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:naModel.thumb]];
        
        self.model = naModel;

        self.dateImgView = [[UIImageView alloc] init];
        self.newsTitleLabel = [[UILabel alloc] init];
        self.adsTitleTopLabel = [[UILabel alloc] init];
        self.adsTitleBottomLabel = [[UILabel alloc] init];
        
        if (wModel == nil) {
            [self.weatherView removeFromSuperview];
        }else{
           self.weatherView = [[DDWeatherView alloc] initWithFrame:CGRectMake(50, 25, WINDOW_WIDTH - 50*2, kWeatherViewHeight) model:wModel]; 
        }
        
//        NSLog(@"%f",self.weatherView.frame.size.height);
     
      //新闻
        if ([naModel.category intValue] == 1)
        {
            self.dateImgView.image = [UIImage imageNamed:@"sy_news"];
            [_imageView addSubview:_dateImgView];
            
            [_imageView addSubview:self.weatherView];
            
            [self.dateImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(20);
                make.bottom.mas_equalTo(-10);
                make.width.and.height.mas_equalTo(20);
            }];
            
            if (![naModel.doc  isEqual: @""]){
                self.newsTitleLabel.text = naModel.doc;
                self.newsTitleLabel.font = [UIFont systemFontOfSize:14];
                self.newsTitleLabel.textColor = [UIColor whiteColor];
                [_imageView addSubview:_newsTitleLabel];
                
                [self.newsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(self.dateImgView.mas_right).offset(10);
                    make.bottom.mas_equalTo(-12);
                    make.right.mas_equalTo(-30);
                }];
            }


            [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(newsClick:)]];
        }
        //广告
        if ([naModel.category intValue] == 2)
        {

            if (![naModel.doc  isEqual: @""]) {
                NSArray *adsTitleArr = [naModel.doc componentsSeparatedByString:@","];
                self.adsTitleTopLabel.text = adsTitleArr[0];
                self.adsTitleTopLabel.font = [UIFont systemFontOfSize:25];
                self.adsTitleTopLabel.textColor = [UIColor whiteColor];
                self.adsTitleTopLabel.textAlignment = NSTextAlignmentCenter;
                [_imageView addSubview:_adsTitleTopLabel];
                
                self.adsTitleBottomLabel.text = adsTitleArr[1];
                self.adsTitleBottomLabel.font = [UIFont boldSystemFontOfSize:25];
                self.adsTitleBottomLabel.textColor = [UIColor whiteColor];
                self.adsTitleBottomLabel.textAlignment = NSTextAlignmentCenter;
                [_imageView addSubview:_adsTitleBottomLabel];
                
                [self.adsTitleTopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.and.right.mas_equalTo(0);
                    //                make.top.mas_equalTo(self.frame.size.height /2 -10);
                    make.centerY.mas_equalTo(-10);
                    
                }];
                [self.adsTitleBottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.and.right.mas_equalTo(self.adsTitleTopLabel);
                    make.top.mas_equalTo(self.adsTitleTopLabel.mas_bottom).offset(5);
                }];
            }

            [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(adsClick:)]];
        }
    }
    return self;
}

//新闻点击
- (void)newsClick:(UITapGestureRecognizer *)gesture
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeLifeHomeNews),
                             kYLModel:self.model,
                             }];
}
//广告点击
- (void)adsClick:(UITapGestureRecognizer *)gesture
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeLifeHomeAds),
                             kYLModel:self.model,
                             }];
}
@end









