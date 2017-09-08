//
//  XHTableViewCell.h
//  xiaoher
//
//  Created by yulongdu on 15/9/1.
//  Copyright (c) 2015年 wenjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLBasicViewMacro.h"
#import <SDWebImage/UIImageView+WebCache.h>

basicProtocol(XHTableViewCell)

@interface YLTableViewCell : UITableViewCell<XHTableViewCellDelegate>

basicMethodsStatement(XHTableViewCell)

@property (nonatomic, copy) void(^allBlock)(NSDictionary *dict);

- (void)allBlockWithDict:(NSDictionary *)dict;
- (void)updateWithModel:(id)obj;
@property (nonatomic, assign) BOOL isCollectCell;

@end

