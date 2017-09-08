//
//  DDRentDetailConfigCell.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/11.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDRentDetailConfigCell.h"
#import "YLLineBlock.h"
#import "DDRentoutDetailModel.h"
#import "DDTagsListView.h"

@interface DDRentDetailConfigCell()

@property (nonatomic, strong) UILabel *configTitleLabel;
@property (nonatomic, strong) YLLineBlock *line;       //分割线
@property (nonatomic, strong) DDRentoutDetailModel *model;
@property (nonatomic, strong) DDTagsListView *tagView;
@end

@implementation DDRentDetailConfigCell

-(void)addViews{
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.configTitleLabel];
    [self.contentView addSubview:self.tagView];
}
-(void)layout{
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    
    [self.configTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.line.mas_bottom).offset(10);
        make.left.mas_equalTo(15);
    }];
    
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.configTitleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.configTitleLabel);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-70);
    }];
    
    
}
-(void)useStyle{
    
    self.configTitleLabel.text = @"房屋配置";
    self.configTitleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.configTitleLabel.textColor = kYLColorFontBlack;
}

-(void)updateWithModel:(id)obj{
    
    DDRentoutDetailModel *model = obj;
    self.model = model;
    
    [self.tagView setTags:[model.config mutableCopy]];
    [self.tagView fittedSize];
}


@end









