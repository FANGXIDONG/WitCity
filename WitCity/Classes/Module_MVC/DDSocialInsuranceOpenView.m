//
//  DDSocialInsuranceOpenView.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/1.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDSocialInsuranceOpenView.h"
#import "DDTextFieldWithLabel.h"
#import "DDTextFieldWithSelectedItem.h"
#import "DDSINumberModel.h"

@interface DDSocialInsuranceOpenView()<UITextFieldDelegate,DDPickerSingleDelegate>

@property (nonatomic, strong) DDTextFieldWithLabel *phoneTxt;
@property (nonatomic, strong) DDTextFieldWithSelectedItem *SINumberTxt;
@property (nonatomic, strong) UIButton *openBtn;
@property (nonatomic, strong) NSArray *selectedArr;
@property (nonatomic, strong) UIPickerView *pickerView ;
@property (nonatomic, strong) DDSINumberModel *model;
@end

@implementation DDSocialInsuranceOpenView

-(void)addViews {
    [self addSubview:self.phoneTxt];
    [self addSubview:self.SINumberTxt];
    [self addSubview:self.openBtn];
}

-(void)layout{
    
    [self.phoneTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.SINumberTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneTxt.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    WS(wself);
    self.SINumberTxt.delegate = self;
    self.SINumberTxt.allBlock = ^(NSDictionary *dict) {
        [wself callbackWithDict:dict];
    };
    
    [self.openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.SINumberTxt.mas_bottom).offset(80);
        make.height.mas_equalTo(50);
    }];
}

-(void)callbackWithDict:(NSDictionary *)dict{
    
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    
    switch (blockType) {
            //
        case kDDPopPickerViewAction:
        {
            self.model = dict[kYLModel];
    
            NSMutableArray *dataArr = [NSMutableArray array];
            self.selectedArr = @[@"医保号",@"医保卡号"];
            for (int i = 0; i<_selectedArr.count; i++) {
                DDSelectModel *model = [[DDSelectModel alloc] init];
                model.name = _selectedArr[i];
                [dataArr addObject:model];
            }
            
            DDPickerSingle *pickerSingle = [[DDPickerSingle alloc]init];
            [pickerSingle setArrayData:(NSMutableArray *)_selectedArr];
            [pickerSingle setTitle:@"请选择查询项目"];
            [pickerSingle setContentMode:DDPickerContentModeCenter];
            [pickerSingle setDelegate:self];
            [pickerSingle show];
        }
            break;
        default:
            break;
    }
}
- (void)pickerSingle:(DDPickerSingle *)pickerSingle selectedTitle:(DDSelectModel *)selectedTitle
{
//    NSString *text = [NSString stringWithFormat:@"%@ 人民币", selectedTitle];
    self.SINumberTxt.string = selectedTitle.name;
}



-(void)useStyle{
    
    self.backgroundColor = kYLColorBakcgorund;
    
    self.phoneTxt.placeholder  = [YLUserSingleton shareInstance].phone;
    self.phoneTxt.enabled = NO;
    self.phoneTxt.string = @"手机号";
    
    self.SINumberTxt.placeholder = @"请输入医保号或医保卡号";
    self.SINumberTxt.keyboardType = UIKeyboardTypeNumberPad;
    self.SINumberTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.SINumberTxt.string = @"医保号";
    self.SINumberTxt.delegate = self;
    
    self.model = [[DDSINumberModel alloc ] init];
    self.model.flag = @"医保号";
    

    self.openBtn.backgroundColor = kDDColorSkyBlue;
    [self.openBtn setTitle:@"开通" forState:UIControlStateNormal];
    [self.openBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.openBtn addTarget:self action:@selector(openSIAction:) forControlEvents:UIControlEventTouchUpInside  ];
    self.openBtn.layer.cornerRadius = 5;
    self.openBtn.layer.masksToBounds = YES;
}

-(void)openSIAction:(UIButton *)sender{
    
    //quanshuzi
    if ([self.SINumberTxt deptNumInputShouldNumber]) {
       [YLToast showToastInKeyWindowWithText:@"请输入合法字符"];
        return;
    }
    if ([self.SINumberTxt.text  isEqual: @""]) {
        [YLToast showToastInKeyWindowWithText:@"医保号或医保卡号不能为空"];
        return;
    }

    if ([self.model.flag isEqualToString:@"医保号"]) {
        self.model.siNumber = self.SINumberTxt.text;
    }
    if ([self.model.flag isEqualToString:@"医保卡号"]) {
        self.model.sicardNumber = self.SINumberTxt.text;
    }
    
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeSocialInsurnceOpenConfirmed),
                             kYLModel:self.model,
                             }];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (_pickerView) {
        [_pickerView removeFromSuperview];
    }
    
    
}

@end










