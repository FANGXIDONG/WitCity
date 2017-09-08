//
//  GetImageSizeUtil.h
//  WitCity
//
//  Created by 方冬冬 on 16/7/25.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

//获取从网络获取图片的大小

#import <Foundation/Foundation.h>

@interface GetImageSizeUtil : NSObject

+(CGSize)getImageSizeWithURL:(id)imageURL;
@end
