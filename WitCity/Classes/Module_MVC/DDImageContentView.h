//
//  DDImageContentView.h
//  WitCity
//
//  Created by 方冬冬 on 16/7/21.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "YLView.h"
#import "DDLWQModel.h"

@interface DDImageContentView : YLView

@property (nonatomic, strong) UIImageView* lastImageView;
@property (nonatomic, strong) NSArray* imageArray;
@property (nonatomic, strong) DDContentImageModel* singleImage;
@end
