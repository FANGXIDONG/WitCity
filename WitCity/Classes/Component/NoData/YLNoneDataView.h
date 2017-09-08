//
//  YLNoneDataView.h
//  style_ios
//
//  Created by duyulong on 9/26/15.
//  Copyright © 2015 nick. All rights reserved.
//

#import "YLView.h"

typedef NS_ENUM(NSInteger, YLNoneDataViewType) {
    kYLNoneDataViewTypeDefault,
    kYLNoneDataViewTypeCollect,//收藏
    kYLNoneDataViewTypeMessage,//消息
};

@interface YLNoneDataView : YLView

@property (nonatomic, assign) YLNoneDataViewType type;

@end
