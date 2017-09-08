//
//  YLCommentHeaderView.h
//  WitCity
//
//  Created by simpletour on 16/5/26.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLView.h"

#define kYLCommentHeaderHeight (120)

typedef NS_ENUM(NSUInteger, YLCommetnHeaderType) {
    kYLCommetnHeaderTypeNotice,  //公告
    kYLCommetnHeaderTypeForum,   //论坛
    kDDCommetnHeaderTypeLWQ,     //柳梧圈
};

@interface YLCommentHeaderView : YLView

- (void)updateWithModel:(id)obj;
@property (nonatomic, assign) YLCommetnHeaderType type;

//@property (nonatomic, strong) NSArray* imageArray;

@end
