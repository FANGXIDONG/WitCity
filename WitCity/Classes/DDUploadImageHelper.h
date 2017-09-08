//
//  DDUploadImageHelper.h
//  WitCity
//
//  Created by 方冬冬 on 16/7/27.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDImageItemModel.h"

@interface DDUploadImageHelper : NSObject

//不要直接操作imagesArray 在操作selectedAssetURLs时会利用KVO直接操作
@property (readwrite, nonatomic, strong) NSMutableArray *imagesArray;
@property (readwrite, nonatomic, strong) NSMutableArray *selectedAssetURLs;


- (void)addASelectedAssetURL:(NSURL *)assetURL;
- (void)deleteASelectedAssetURL:(NSURL *)assetURL;
- (void)deleteAImage:(DDImageItemModel *)imageInfo;

/**
 *  @author fangdongdong, 16-07-25 13:07:17
 *
 *  @brief  <#Description#>
 *
 *  @param isUploadProcess 是否缓存到沙盒中YES则会转到沙盒中
 *
 *  @return <#return value description#>
 */
+(DDUploadImageHelper *)MPUploadImageForSend:(BOOL)isUploadProcess;

@end






