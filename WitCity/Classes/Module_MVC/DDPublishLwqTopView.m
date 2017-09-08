//
//  DDPublishLwqTopView.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/26.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDPublishLwqTopView.h"
#import "YLLineBlock.h"
@interface DDPublishLwqTopView()<UITextViewDelegate>

@property (nonatomic, strong) UITextView  *titleView;
@property (nonatomic, strong) UITextView  *contentView;
@property (nonatomic, strong) YLLineBlock  *line;
@property (nonatomic, strong) UILabel *titlePlLabel;
@property (nonatomic, strong) UILabel *contentPlLabel;

@end

@implementation DDPublishLwqTopView

-(void)addViews{
    [self addSubview:self.titleView];
    [self addSubview:self.line];
    [self addSubview:self.contentView];
    [self addSubview:self.contentPlLabel];
    [self addSubview:self.titlePlLabel];
    
    self.titleView.delegate = self;
    self.contentView.delegate = self;
}

-(void)layout{
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    [self.titlePlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(self.titleView);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.top.mas_equalTo(self.titleView.mas_bottom);
        make.height.mas_equalTo(5);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.top.mas_equalTo(self.line.mas_bottom);
        make.bottom.mas_equalTo(0);
    }];
    
    [self.contentPlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.line.mas_bottom).offset(5);
    }];
    
 }

-(void)useStyle{
    
    self.titleView.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.titlePlLabel.text = @"标题（30字以内）";
    self.titlePlLabel.textColor = kYLColorFontGray;
    self.titlePlLabel.font = [UIFont systemFontOfSize:18];
    self.titlePlLabel.hidden = [self.titleView.text length];
    
    self.contentPlLabel.text = @"内容（300字以内）";
    self.contentPlLabel.textColor = kYLColorFontGray;
    self.contentPlLabel.font = [UIFont systemFontOfSize:18];
    self.contentPlLabel.hidden = [self.contentView.text length];
}

#pragma mark - Text View Delegate
-(void)textViewDidChange:(UITextView *)textView
{
    if (textView == self.titleView) {
       self.titlePlLabel.hidden = [textView.text length];
    }
    if (textView == self.contentView) {
       self.contentPlLabel.hidden = [textView.text length];
    }
    textView.font = [UIFont systemFontOfSize:18];
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    
    if (textView == self.titleView) {
        if ([@"\n" isEqualToString:text])
        {
            if ([self.titleView.text length]) {
                [self.titleView resignFirstResponder];
            }
            else
            {
                return NO;
            }
        }
        return YES;
    }else{
        if ([@"\n" isEqualToString:text])
        {
            if ([self.contentView.text length]) {
                [self.contentView resignFirstResponder];
            }
            else
            {
                return NO;
            }
        }
        return YES;
    }

}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    
    if (textView == self.titleView)
    {
        [self allBlockWithDict:@{
                                 kYLKeyForBlockType : @(kDDBlockTypeTitleText),
                                 kYLValue:textView.text
                                 }];
    }
    if (textView == self.contentView)
    {
        [self allBlockWithDict:@{
                                 kYLKeyForBlockType : @(kDDBlockTypeContentText),
                                 kYLValue:textView.text
                                 }];
    }
    
    
}
@end














