//
//  DDUploadImageHelper.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/27.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDUploadImageHelper.h"

@interface DDUploadImageHelper()
@property(nonatomic)BOOL isUploadProcess;

@end
static DDUploadImageHelper *_mpUploadImageHelper = nil;
@implementation DDUploadImageHelper
+(DDUploadImageHelper *)MPUploadImageForSend:(BOOL)isUploadProcess
{
    _mpUploadImageHelper = [[DDUploadImageHelper alloc] init];
    _mpUploadImageHelper.isUploadProcess=isUploadProcess;
    return _mpUploadImageHelper;
}

- (void)setSelectedAssetURLs:(NSMutableArray *)selectedAssetURLs{
    NSMutableArray *needToAdd = [NSMutableArray new];
    NSMutableArray *needToDelete = [NSMutableArray new];
    [self.selectedAssetURLs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (![selectedAssetURLs containsObject:obj]) {
            [needToDelete addObject:obj];
        }
    }];
    [needToDelete enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self deleteASelectedAssetURL:obj];
    }];
    [selectedAssetURLs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (![self.selectedAssetURLs containsObject:obj]) {
            [needToAdd addObject:obj];
        }
    }];
    [needToAdd enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self addASelectedAssetURL:obj];
    }];
}


- (void)addASelectedAssetURL:(NSURL *)assetURL{
    if (!_selectedAssetURLs) {
        _selectedAssetURLs = [NSMutableArray new];
    }
    if (!_imagesArray) {
        _imagesArray = [NSMutableArray new];
    }
    
    [_selectedAssetURLs addObject:assetURL];
    
    NSMutableArray *imagesArray = [self mutableArrayValueForKey:@"imagesArray"];//为了kvo
    DDImageItemModel *imageItem = [DDImageItemModel imageWithAssetURL:assetURL isUploadProcess:self.isUploadProcess];
    [imagesArray addObject:imageItem];
}

- (void)deleteASelectedAssetURL:(NSURL *)assetURL{
    [self.selectedAssetURLs removeObject:assetURL];
    NSMutableArray *imagesArray = [self mutableArrayValueForKey:@"imagesArray"];//为了kvo
    [imagesArray enumerateObjectsUsingBlock:^(DDImageItemModel *obj, NSUInteger idx, BOOL *stop) {
        if (obj.assetURL == assetURL) {
            [imagesArray removeObject:obj];
            *stop = YES;
        }
    }];
}

- (void)deleteAImage:(DDImageItemModel *)imageInfo{
    NSMutableArray *imagesArray = [self mutableArrayValueForKey:@"imagesArray"];//为了kvo
    [imagesArray removeObject:imageInfo];
    if (imageInfo.assetURL) {
        [self.selectedAssetURLs removeObject:imageInfo.assetURL];
    }
}


@end
