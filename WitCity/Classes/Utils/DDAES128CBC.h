//
//  DDAES128CBC.h
//  WitCity
//
//  Created by 方冬冬 on 16/8/4.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDAES128CBC : NSObject

+ (NSString*) AES128Encrypt:(NSString *)plainText;

+ (NSString*) AES128Decrypt:(NSString *)encryptText;
@end
