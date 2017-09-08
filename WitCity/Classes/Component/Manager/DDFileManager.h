//
//  DDFileManager.h
//  WitCity
//
//  Created by 方冬冬 on 16/7/27.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAssetRepresentation.h>

@interface DDFileManager : NSObject

+ (DDFileManager *)sharedManager;

//下载存放路径
+ (NSString *)downloadPath;
//上载暂存路径
+ (NSString *)uploadPath;

//把文件先写入到APP沙盒暂存
+ (BOOL)writeUploadDataWithName:(NSString *)fileName andAsset:(ALAsset *)asset;
//把图片先写入到APP沙盒暂存
+ (BOOL)writeUploadDataWithName:(NSString *)fileName andImage:(UIImage *)image;
//删除APP沙盒暂存的文件
+ (BOOL)deleteUploadDataWithName:(NSString *)fileName;
@end
