//
//  YLEnterpriseHomeView.h
//  WitCity
//
//  Created by simpletour on 16/5/18.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLView.h"

@interface YLEnterpriseHomeView : YLView

- (void)updateBannerWithArray:(NSArray *)array;

@end

@interface YLEnterpriseHomeItemView : YLView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageNamed;
@property (nonatomic, strong) UIColor *textColor;


@end