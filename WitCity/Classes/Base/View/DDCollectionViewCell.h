//
//  DDCollectionViewCell.h
//  WitCity
//
//  Created by 方冬冬 on 16/8/19.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLBasicViewMacro.h"
#import <SDWebImage/UIImageView+WebCache.h>

basicProtocol(XHTableViewCell)

@interface DDCollectionViewCell : UICollectionViewCell<XHTableViewCellDelegate>

basicMethodsStatement(XHTableViewCell)

@property (nonatomic, copy) void(^allBlock)(NSDictionary *dict);

- (void)allBlockWithDict:(NSDictionary *)dict;
- (void)updateWithModel:(id)obj;
@property (nonatomic, assign) BOOL isCollectCell;
@end
