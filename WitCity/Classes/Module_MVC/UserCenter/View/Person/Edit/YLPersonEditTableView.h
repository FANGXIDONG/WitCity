//
//  YLPersonEditTableView.h
//  WitCity
//
//  Created by simpletour on 16/5/21.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLTableView.h"

typedef NS_ENUM(NSUInteger, YLPersonEditType) {
    kYLPersonEditTypeNickname,//昵称
    kYLPersonEditTypePhone,   //手机号码
    kYLPersonEditTypePassword,//密码
};


@interface YLPersonEditTableView : YLTableView

@property (nonatomic, assign) YLPersonEditType type;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *pwd;
@property (nonatomic, copy) NSString *pwdConfrim;




@end
