//
//  XHView.h
//  xiaoher
//
//  Created by yulongdu on 15/9/1.
//  Copyright (c) 2015年 wenjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLBasicViewMacro.h"
#import "YLHttpUrl.h"
#import <SDWebImage/UIImageView+WebCache.h>

basicProtocol(YLView)

@interface YLView : UIView<YLViewDelegate>

basicMethodsStatement(YLView)

@property (nonatomic, copy) void(^allBlock)(NSDictionary *dict);

- (void)allBlockWithDict:(NSDictionary *)dict;

-(NSURL *)imageUrlWithStr:(NSString *)str;

@end

