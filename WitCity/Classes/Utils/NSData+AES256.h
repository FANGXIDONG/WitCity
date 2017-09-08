//
//  NSData+AES256.h
//  cn
//
//  Created by 方冬冬 on 15/12/11.
//  Copyright © 2015年 方冬冬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
@interface NSData (AES256)
-(NSData *) aes256_encrypt:(NSString *)key;
-(NSData *) aes256_decrypt:(NSString *)key;
@end
