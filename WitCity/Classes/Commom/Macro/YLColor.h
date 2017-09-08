//
//  YLColor.h
//  YLDraw
//
//  Created by simpletour on 16/1/30.
//  Copyright © 2016年 duyulong. All rights reserved.
//

#ifndef YLColor_h
#define YLColor_h

#import "YLFlatColor.h"


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define YLCOLOR(hex) [UIColor colorWithHex:hex]

//红色
#define YLCOLOR_RED                       (0xff5a5a)

//绿色
#define YLCOLOR_GREEN                     (0x00b487)

//黄色
#define YLCOLOR_YELLOW                    (0xffc105)

//灰线颜色//0xe4e4e6    //0xdddddd
#define YLCOLOR_LINE                      (0xe4e4e6)

//灰色背景
#define YLCOLOR_BACKGROUND_GRAY           (0xf0f0f0)

//3号灰色
#define YLCOLOR_GRAY3                     (0x333333)
//6号灰色
#define YLCOLOR_GRAY6                     (0x666666)
//9号灰色
#define YLCOLOR_GRAY9                     (0x999999)
//d号灰色
#define YLCOLOR_GRAYD                     (0xdddddd)


//深灰色
#define YLCOLOR_DARK_GREY                 (0x999999)

//黑色
#define YLCOLOR_BLACK                     (0x231815)

//灰色字体
#define YLCOLOR_FONT_GRAY                 (0x969696)

//登录界面背景
#define YLCOLOR_LOGIN_VIEW_BACKGROUND     (0xf1f1f1)

//灰色背景色
#define YLCOLOR_BACKGROUND_GARY           (0xf1f1f1)

//tabeview背景
#define YLCOLOR_TABLEVIEW_BACKGROUND_GARY (0xeeeeee)


#define kDDColorGrayBg   YLCOLOR(0xF0F0F0)

#define kDDColorGrayText   YLCOLOR(0x9C9C9C)
//颜色
//背景颜色
#define kYLColorBakcgorund YLCOLOR(0xedeeef)
//黑色字体
#define kYLColorFontBlack  YLCOLOR(0x0a0a0a)
//灰色字体
#define kYLColorFontGray   YLCOLOR(0x858585)
//橘黄色字体
#define kYLColorFontOrange YLCOLOR(0xfd6001)
//黄色字体
#define kYLColorFontYellow YLCOLOR(0xffc105)
//红色字体
#define kYLColorFontRed    YLCOLOR(0xff5a5a)
//蓝色字体
#define kYLColorFontBlue   YLCOLOR(0x3c44b4)
//天蓝
#define kDDColorSkyBlue    YLCOLOR(0X289FFD)
//深蓝
#define kDDColorFontDeepBlue   YLCOLOR(0x5856A2)
//黄色
#define kDDColorFontYellow   YLCOLOR(0xFFFF00)
//线条颜色
#define kYLColorLine       YLCOLOR(YLCOLOR_LINE)
//默认字体颜色
#define kDefaultFontColor  kYLColorFontBlack

//字体大小
#define FONT_H(size1) [UIFont systemFontOfSize:size1]

#endif /* YLColor_h */






