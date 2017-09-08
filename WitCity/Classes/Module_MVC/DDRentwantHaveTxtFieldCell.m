//
//  DDRentwantHaveTxtFieldCell.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/12.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDRentwantHaveTxtFieldCell.h"
#import "YLLineBlock.h"

@interface DDRentwantHaveTxtFieldCell()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) YLLineBlock *line;
@property (nonatomic, strong) UILabel *label;

@end

@implementation DDRentwantHaveTxtFieldCell

-(void)addViews {
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.txtField];
    [self.line addSubview:self.label];
}

-(void)layout{
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.line);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(self.line);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.line.mas_bottom).offset(10);
        make.bottom.mas_equalTo(self).offset(-10);
        make.left.mas_equalTo(15);
    }];
    [self.txtField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.nameLabel);
        make.top.mas_equalTo(self.nameLabel);
        make.left.mas_equalTo(self.nameLabel.mas_right).offset(5);
        make.right.mas_equalTo(-10);
    }];
    self.txtField.delegate = self;
}
-(void)useStyle{
    self.nameLabel.textColor = kYLColorFontBlack;
    self.nameLabel.font = [UIFont systemFontOfSize:16];
    self.txtField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.txtField.textColor = kYLColorFontGray;
    self.txtField.textAlignment = NSTextAlignmentRight;
}

-(void)setPlaceholerStr:(NSString *)placeholerStr{
    self.txtField.placeholder = placeholerStr;
    [self.txtField setValue:kYLColorFontGray forKeyPath:@"_placeholderLabel.textColor"];
    [self.txtField setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    
}
-(void)setString:(NSString *)string {
    self.nameLabel.text = string;
}
-(void)setIsHideLine:(BOOL)isHideLine{
    if (isHideLine== YES) {
        self.line.hidden = YES;
    }else{
        self.line.hidden = NO;
    }
}

-(void)setHeadStr:(NSString *)headStr{
    
    if (self.label.hidden == NO) {
        self.label.text = headStr;
    }
}

-(void)setType:(kDDCellTextFieldLineType)type{
    
    switch (type) {
        case kDDCellTextFieldLineTypeNormal:{
            [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self);
                make.left.and.right.mas_equalTo(self);
                make.height.mas_equalTo(10);
            }];
            self.label.hidden = YES;
        }break;
        case kDDCellTextFieldLineTypeHigher:{
            [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self);
                make.left.and.right.mas_equalTo(self);
                make.height.mas_equalTo(40);
            }];
//            self.label.text = @"公司简介";
            self.label.textColor = kYLColorFontOrange;
            self.label.font = [UIFont systemFontOfSize:15];
        }break;
            
        default:
            break;
    }
    _type = type;
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.txtField) {
        NSString *textStr = textField.text;
        //监听
        NSString *text = [NSString stringWithFormat:@"%@%@",textStr,string];
        NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:text,@"text",textField.placeholder,@"placeholder", nil];
        //创建通知
        NSNotification *notification =[NSNotification notificationWithName:kChangeTextFieldTextNotification object:nil userInfo:dict];
        [ND postNotification:notification];
    }
    return YES;
    
}

@end








