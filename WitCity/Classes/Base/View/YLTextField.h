//
//  XHTextField.h
//  style_ios
//
//  Created by duyulong on 9/23/15.
//  Copyright © 2015 nick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLBasicViewMacro.h"

typedef NS_ENUM(NSUInteger, YLTextFieldType) {
    kYLTextFieldTypeDefault,
    kYLTextFieldTypeUsername,
    kYLTextFieldTypePassword,
    kYLTextFieldTypeVercode,
    kDDTextFieldTypeSinumber,   //医保号
    kDDTextFieldTypeSiCardnumber, //医保卡号
    kDDTextFieldTypeTitle,
    kDDTextFieldTypePosition,
    kDDTextFieldTypeIdCardNumber,  //身份证
    
};

@interface YLTextField : UITextField

@property (nonatomic, assign) YLTextFieldType validateType;

@end
