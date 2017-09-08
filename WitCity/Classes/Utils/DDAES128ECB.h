//
//  DDAES.h
//  WitCity
//
//  Created by 方冬冬 on 16/8/3.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDAES128ECB : NSObject

+(NSString *)AES128Encrypt:(NSString *)plainText key:(NSString *)key;

+(NSString *)AES128Decrypt:(NSString *)encryptText key:(NSString *)key;
@end
