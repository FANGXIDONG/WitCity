//
//  DDLifeZuTuanHttpUtil.h
//  WitCity
//
//  Created by 方冬冬 on 16/8/17.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

//调组团钟接口
/**
 *  account  合作账号
 *  token    构造令牌
 *  sysytem  系统类型   (0未知  1pc  2andriod  3iphone  4ipad  5windows phone  6symbianos)
 *  client   客户端类型 (0浏览器  1移动端)
 *  info     参数传递，若传递数组或JSON对象，需转化为字符串
 */

#import "WCBaseHttpUtil.h"

@interface DDLifeZuTuanHttpUtil : WCBaseHttpUtil

+ (void)getTestDataWithInfo:(NSString *)info page:(NSInteger)page  block:(void(^)(NSDictionary *dict))dict failure:(void(^)())failure;

@end
