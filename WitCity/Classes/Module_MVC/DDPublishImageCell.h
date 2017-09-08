//
//  DDPublishImageCell.h
//  WitCity
//
//  Created by 方冬冬 on 16/7/27.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

//#import "YLTableViewCell.h"
#import <UIKit/UIKit.h>
#import "DDImageItemModel.h"
#import "DDUploadImageHelper.h"
#import "UIView+YLPlus.h"
#import "UIView+ViewController.h"
#import "DDPublishImageCollectionViewCell.h"

@interface DDPublishImageCell : UITableViewCell<UICollectionViewDataSource, UICollectionViewDelegate,MWPhotoBrowserDelegate>

@property (strong, nonatomic) DDUploadImageHelper *curUploadImageHelper;

@property (copy, nonatomic) void(^addPicturesBlock)();
@property (copy, nonatomic) void (^deleteImageBlock)(DDImageItemModel *toDelete);

//获得最后的行高
+ (CGFloat)cellHeightWithObj:(id)obj;
@end
