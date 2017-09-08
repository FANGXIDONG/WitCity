//
//  DDPublishImageCollectionViewCell.h
//  WitCity
//
//  Created by 方冬冬 on 16/7/27.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDImageItemModel.h"

@interface DDPublishImageCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) UIImageView          *imgView;
@property (strong, nonatomic) UIButton             *deleteBtn;
@property (strong, nonatomic) DDImageItemModel     *curImageItem;
@property (copy, nonatomic) void (^deleteImageBlock) (DDImageItemModel *toDelete);

//单元格大小
+(CGSize)ccellSize;
@end
