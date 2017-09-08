//
//  DDCommonView.h
//  WitCity
//
//  Created by 方冬冬 on 16/7/19.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLView.h"

typedef NS_ENUM(NSUInteger, DDCommonViewType) {
    DDCommonTypeViewWidthEqualHeight = 0,   //视图的长宽相等
    DDCommonTypeImgWidthEqualHeight,        //视图内的图片长宽相等
};
@interface DDCommonView : YLView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageNamed;

@property (nonatomic, assign) DDCommonViewType commonvViewType;
@end
