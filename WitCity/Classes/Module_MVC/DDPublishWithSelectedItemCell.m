//
//  DDPublishWithSelectedItemCell.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/18.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDPublishWithSelectedItemCell.h"
#import "DDRadioButton.h"      //选择按钮
#import "YLLineBlock.h"
#import "DDRadioButtonGroupIdModel.h"

#define selectItemW   50

@interface DDPublishWithSelectedItemCell()<DDRadioButtonDelegate>
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) NSArray *itemsArr;
@property (nonatomic, strong) YLLineBlock *line;

//下面的四个
@property (nonatomic, strong) DDRadioButton *btn;
@property (nonatomic, strong) DDRadioButton *btn1;
@property (nonatomic, strong) DDRadioButton *btn2;
@property (nonatomic, strong) DDRadioButton *btn3;
//
@property (nonatomic, strong) DDRadioButton *btn_;
@property (nonatomic, strong) DDRadioButton *btn11;
@property (nonatomic, strong) DDRadioButton *btn__;
@property (nonatomic, strong) DDRadioButton *btn111;
@end

@implementation DDPublishWithSelectedItemCell


-(void)addViews{

    //groupId相同的为一组单选框,在单元格中利用groupId区分不同row的不是为同一组
    self.btn = [[DDRadioButton alloc] initWithDelegate:self groupId:@"bottom"];
    self.btn1 = [[DDRadioButton alloc] initWithDelegate:self groupId:@"bottom"];
    self.btn2 = [[DDRadioButton alloc] initWithDelegate:self groupId:@"bottom"];
    self.btn3 = [[DDRadioButton alloc] initWithDelegate:self groupId:@"bottom"];
    
    self.btn_ = [[DDRadioButton alloc] initWithDelegate:self groupId:@"top"];
    self.btn11 = [[DDRadioButton alloc] initWithDelegate:self groupId:@"top"];
    self.btn__ = [[DDRadioButton alloc] initWithDelegate:self groupId:@"middle"];
    self.btn111 = [[DDRadioButton alloc] initWithDelegate:self groupId:@"middle"];
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.line];
    [self addSubview:self.btn];
    [self addSubview:self.btn1];
    [self addSubview:self.btn2];
    [self addSubview:self.btn3];
    [self addSubview:self.btn_];
    [self addSubview:self.btn11];
    [self addSubview:self.btn__];
    [self addSubview:self.btn111];
}

-(void)layout{
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.and.right.mas_equalTo(self);
        make.height.mas_equalTo(10);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.line.mas_bottom).offset(10);
        make.bottom.mas_equalTo(self).offset(-10);
        make.left.mas_equalTo(15);
    }];
    
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.line.hidden == YES) {
            make.top.mas_equalTo(5);
            make.centerY.mas_equalTo(self);
        }else{
            make.top.mas_equalTo(self.line.mas_bottom).offset(5);
            make.centerY.mas_equalTo(self).offset(5);
        }
        make.width.mas_equalTo(selectItemW);
        make.right.mas_equalTo(-10);
    }];

    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.line.hidden == YES) {
            make.top.mas_equalTo(5);
            make.centerY.mas_equalTo(self);
        }else{
            make.top.mas_equalTo(self.line.mas_bottom).offset(5);
            make.centerY.mas_equalTo(self).offset(5);
        }
        make.width.mas_equalTo(selectItemW);
        make.right.mas_equalTo(self.btn.mas_left).offset(-10);
    }];

    [self.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.line.hidden == YES) {
            make.top.mas_equalTo(5);
            make.centerY.mas_equalTo(self);
        }else{
            make.top.mas_equalTo(self.line.mas_bottom).offset(5);
            make.centerY.mas_equalTo(self).offset(5);
        }
        make.width.mas_equalTo(selectItemW);
        make.right.mas_equalTo(self.btn1.mas_left).offset(-10);
    }];

    [self.btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.line.hidden == YES) {
            make.top.mas_equalTo(5);
            make.centerY.mas_equalTo(self);
        }else{
            make.top.mas_equalTo(self.line.mas_bottom).offset(5);
            make.centerY.mas_equalTo(self).offset(5);
        }
        make.width.mas_equalTo(selectItemW);
        make.right.mas_equalTo(self.btn2.mas_left).offset(-10);
    }];
    [self.btn_ mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.line.hidden == YES) {
            make.top.mas_equalTo(5);
            make.centerY.mas_equalTo(self);
        }else{
            make.top.mas_equalTo(self.line.mas_bottom).offset(5);
            make.centerY.mas_equalTo(self).offset(5);
        }
        make.width.mas_equalTo(selectItemW);
        make.right.mas_equalTo(-10);
    }];
    
    [self.btn11 mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.line.hidden == YES) {
            make.top.mas_equalTo(5);
            make.centerY.mas_equalTo(self);
        }else{
            make.top.mas_equalTo(self.line.mas_bottom).offset(5);
            make.centerY.mas_equalTo(self).offset(5);
        }
        make.width.mas_equalTo(selectItemW);
        make.right.mas_equalTo(self.btn_.mas_left).offset(-10);
    }];
    [self.btn__ mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.line.hidden == YES) {
            make.top.mas_equalTo(5);
            make.centerY.mas_equalTo(self);
        }else{
            make.top.mas_equalTo(self.line.mas_bottom).offset(5);
            make.centerY.mas_equalTo(self).offset(5);
        }
        make.width.mas_equalTo(selectItemW);
        make.right.mas_equalTo(-10);
    }];
    
    [self.btn111 mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.line.hidden == YES) {
            make.top.mas_equalTo(5);
            make.centerY.mas_equalTo(self);
        }else{
            make.top.mas_equalTo(self.line.mas_bottom).offset(5);
            make.centerY.mas_equalTo(self).offset(5);
        }
        make.width.mas_equalTo(selectItemW);
        make.right.mas_equalTo(self.btn__.mas_left).offset(-10);
    }];
}

-(void)useStyle{
    
    self.nameLabel.textColor = kYLColorFontBlack;
    self.nameLabel.font = [UIFont systemFontOfSize:16];
    
    [_btn setTitleColor:kYLColorFontBlack forState:UIControlStateNormal];
    [_btn.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [_btn1 setTitleColor:kYLColorFontBlack forState:UIControlStateNormal];
    [_btn1.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [_btn2 setTitleColor:kYLColorFontBlack forState:UIControlStateNormal];
    [_btn2.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [_btn3 setTitleColor:kYLColorFontBlack forState:UIControlStateNormal];
    [_btn3.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
    
    [_btn_ setTitleColor:kYLColorFontBlack forState:UIControlStateNormal];
    [_btn_.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [_btn11 setTitleColor:kYLColorFontBlack forState:UIControlStateNormal];
    [_btn11.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [_btn__ setTitleColor:kYLColorFontBlack forState:UIControlStateNormal];
    [_btn__.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [_btn111 setTitleColor:kYLColorFontBlack forState:UIControlStateNormal];
    [_btn111.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
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

#pragma mark - DDRadioButtonDelegate

-(void)didSelectedRadioButton:(DDRadioButton *)radio groupId:(NSString *)groupId
{
    NSLog(@"点击%@",radio.titleLabel.text);
    DDRadioButtonGroupIdModel *model = [[DDRadioButtonGroupIdModel alloc] init];
    model.groupId = groupId;
    model.text = radio.titleLabel.text;
    
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeRadioButtonSelectedItem),
                             kYLModel:model,
                             
                             }];
//    if ([radio.titleLabel.text isEqualToString:@"余额"]) {
//        //        NSLog(@"余额");
////        self.inquireType = @"0";
//    }
//    if ([radio.titleLabel.text isEqualToString:@"近两笔消费"]) {
//        //        NSLog(@"近两笔消费");
////        self.inquireType = @"1";
//    }
}


-(void)setItemArr:(NSArray *)itemArr{
    
    self.itemsArr = itemArr;
    
    if (self.itemsArr.count == 2)
    {
        
        NSString *firstStr = itemArr[0];
        if ([firstStr isEqualToString:@"整租"]) {
            [self.btn_ setTitle:itemArr[1] forState:UIControlStateNormal];
            [self.btn11 setTitle:itemArr[0] forState:UIControlStateNormal];
            [self.btn11 setChecked:YES];
            self.btn__.hidden = YES;
            self.btn111.hidden = YES;
        }else{
            [self.btn__ setTitle:itemArr[1] forState:UIControlStateNormal];
            [self.btn111 setTitle:itemArr[0] forState:UIControlStateNormal];
            [self.btn111 setChecked:YES];
            self.btn_.hidden = YES;
            self.btn11.hidden = YES;
        }
        self.btn.hidden = YES;
        self.btn1.hidden = YES;
        self.btn2.hidden = YES;
        self.btn3.hidden = YES;
       
    }
   else if (self.itemsArr.count == 4)
    {
        [self.btn setTitle:itemArr[3] forState:UIControlStateNormal];
        [self.btn1 setTitle:itemArr[2] forState:UIControlStateNormal];
        [self.btn2 setTitle:itemArr[1] forState:UIControlStateNormal];
        [self.btn3 setTitle:itemArr[0] forState:UIControlStateNormal];
        [self.btn3 setChecked:YES];
        self.btn__.hidden = YES;
        self.btn111.hidden = YES;
        self.btn_.hidden = YES;
        self.btn11.hidden = YES;
    }else{
        self.btn.hidden = YES;
        self.btn1.hidden = YES;
        self.btn2.hidden = YES;
        self.btn3.hidden = YES;
        self.btn_.hidden = YES;
        self.btn11.hidden = YES;
        self.btn__.hidden = YES;
        self.btn111.hidden = YES;
    }
}
@end

















