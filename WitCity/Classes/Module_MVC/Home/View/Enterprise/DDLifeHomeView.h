//
//  DDLifeHomeView.h
//  WitCity
//
//  Created by 方冬冬 on 16/6/24.
//  Copyright © 2016年 bjxybs. All rights reserved.
//


//通用视图
//出行、电影票、充值、团购、市民热线；招聘",@"求职",@"出租",@"求租", @"柳梧圈

//上图下文字的view
#import "YLView.h"

@interface DDLifeHomeView : YLView

/* frame:view的frame
 title:label文字
 titleColor:label的颜色
 titleHeight:文字显示高度
 */
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName font:(UIFont *)font titleColor:(UIColor*)color titleHeight:(int)height index:(int)index;
@end
