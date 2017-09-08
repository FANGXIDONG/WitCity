//
//  YLEnterpriseCellBootomView.h
//  WitCity
//
//  Created by simpletour on 16/5/19.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLView.h"

typedef NS_ENUM(NSUInteger, YLCellBootomViewType) {
    kYLCellBootomViewTypeOnlyCollect,
    kYLCellBootomViewTypeCollectAndReply,
    kYLCellBootomViewTypeCollectAndFlag,
};

@interface YLCellBootomView : YLView

@property (nonatomic, assign) YLCellBootomViewType type;
@property (nonatomic, copy) NSString *collect;
@property (nonatomic, copy) NSString *reply;
@property (nonatomic, copy) NSString *flag;
@property (nonatomic, assign) BOOL isCollect;

@end
