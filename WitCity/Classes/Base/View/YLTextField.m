//
//  XHTextField.m
//  style_ios
//
//  Created by duyulong on 9/23/15.
//  Copyright © 2015 nick. All rights reserved.
//

#import "YLTextField.h"

@interface YLTextField ()<UITextFieldDelegate>

@end

@implementation YLTextField

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        self.delegate = self;
        [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self) {
        NSInteger length = [self maxLengthWithType:self.validateType];
        if (textField.text.length > length) {
            textField.text = [textField.text substringToIndex:length];
        }
    }
}

- (NSInteger)maxLengthWithType:(YLTextFieldType)type
{
    NSInteger length = 999;
    switch (type) {
        case kYLTextFieldTypeDefault:{
        }break;
        case kYLTextFieldTypeUsername:{
            length = 11;
        }break;
        case kYLTextFieldTypePassword:{
            length = 20;
        }break;
        case kYLTextFieldTypeVercode:{
            length = 6;
        }break;
        case kDDTextFieldTypeSinumber:
        {
            length = 10;
        }break;
        case kDDTextFieldTypeSiCardnumber:
        {
            length = 19;
        }break;
        case kDDTextFieldTypeTitle:
        {
            length = 30;
        }break;
        case kDDTextFieldTypePosition:
        {
            length = 20;
        }
            break;
        case kDDTextFieldTypeIdCardNumber:
        {
            length = 18;
        }
            break;
        default:
            break;
    }
    return length;
}

@end
