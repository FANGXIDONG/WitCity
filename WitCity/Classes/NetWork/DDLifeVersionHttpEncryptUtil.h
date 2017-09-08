//
//  DDLifeVersionHttpEncryptUtil.h
//  WitCity
//
//  Created by 方冬冬 on 16/8/3.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "WCBaseHttpUtil.h"


@interface DDLifeVersionHttpEncryptUtil : WCBaseHttpUtil


//-------------------- 测试AES加密 ----------------------------//
+ (void)testBlock:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

@end
