//
//  XHCollectionView.h
//  xiaoher
//
//  Created by yulongdu on 15/9/1.
//  Copyright (c) 2015年 wenjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLMacro.h"


@interface YLCollectionView : UICollectionView

@property (nonatomic, copy) void(^allBlock)(NSDictionary *dict);

- (void)allBlockWithDict:(NSDictionary *)dict;

@end
