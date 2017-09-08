//
//  YLCommentHeaderView.m
//  WitCity
//
//  Created by simpletour on 16/5/26.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLCommentHeaderView.h"
#import "YLCommentUserInfoView.h"
#import "YLNewsModel.h"
#import "DDLWQModel.h"
//#import "SDPhotoBrowser.h"

#define kPredicateImageHeight  150

@interface YLCommentHeaderView ()

@property (nonatomic, assign)float height;
@property (nonatomic, assign)float allImgHeight;

@property (nonatomic, strong) YLCommentUserInfoView *userView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *lblDetail;

@property (nonatomic, strong) UILabel *lwqTitleLabel;
@property (nonatomic, strong) UILabel *lwqDetailLabel;
@property (nonatomic, strong) UIImageView *imageView1;
@property (nonatomic, strong) UIImageView *imageView2;
@property (nonatomic, strong) UIImageView *imageView3;
@end

@implementation YLCommentHeaderView

-(void)addViews
{
    [self addSubview:self.userView];
    [self addSubview:self.imageView];
    [self addSubview:self.lblDetail];
    
    [self addSubview:self.lwqTitleLabel];
    [self addSubview:self.lwqDetailLabel];
    [self addSubview:self.imageView1];
    [self addSubview:self.imageView2];
    [self addSubview:self.imageView3];
}


-(void)layout
{
    [self.userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(0);
        make.height.mas_equalTo(kYLCommentUserInfoHeight);
    }];
    
    [self.lwqTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(self.userView.mas_bottom);
    }];
        
    [self.lwqDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.lwqTitleLabel);
        make.top.mas_equalTo(self.lwqTitleLabel.mas_bottom).offset(10);
    }];
    
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.lblDetail);
        make.top.mas_equalTo(self.userView.mas_bottom).offset(10);
        make.height.mas_equalTo(kPredicateImageHeight);
    }];
    
    [self.lblDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(self.imageView.mas_bottom);
    }];
    
}

-(void)useStyle
{
    self.backgroundColor = [UIColor whiteColor];
    self.lblDetail.font = [UIFont systemFontOfSize:18];
    self.lblDetail.textColor = kYLColorFontBlack;
    self.lblDetail.numberOfLines = 0;
    
    self.lwqTitleLabel.font = [UIFont systemFontOfSize:18];
    self.lwqTitleLabel.textColor = kYLColorFontBlack;
    self.lwqTitleLabel.numberOfLines = 0;
    
    self.lwqDetailLabel.font = [UIFont systemFontOfSize:14];
    self.lwqDetailLabel.textColor = kYLColorFontGray;
    self.lwqDetailLabel.numberOfLines = 0;
}


- (void)updateWithModel:(id)obj
{
    if (self.type == kDDCommetnHeaderTypeLWQ) {
        
        DDLWQModel *model = obj;
        self.lwqTitleLabel.text = model.title;
        self.lwqDetailLabel.text = model.content;
        [self.userView updateWithLwqModel:obj];

        NSArray *thumbArr = [model.thumb mutableCopy];
        
        _allImgHeight = 0;
        for (int i= 0; i<model.imageArray.count; i++) {
            
            DDContentImageModel *imageModel  = model.imageArray[i];
            
            CGFloat padding = imageModel.width >=  imageModel.height ? 16:64;
            CGFloat width = self.frame.size.width - padding*2;
            CGFloat scale = imageModel.width / imageModel.height;
            _height = width / scale;
            
            _allImgHeight = _allImgHeight + _height;
            
            NSLog(@"%f",_allImgHeight);
            
            if (thumbArr.count == 1)
            {
            
                    [self.imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(padding);
                        make.right.mas_equalTo(-padding);
                        make.height.mas_equalTo(_height);
                        make.top.mas_equalTo(self.lwqDetailLabel.mas_bottom).offset(10);
                    }];
                
                [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:thumbArr[0]]];
               
            }
            
            if (thumbArr.count == 2)
            {
                if (i==0) {
                    [self.imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(padding);
                        make.right.mas_equalTo(-padding);
                        make.height.mas_equalTo(_height);
                        make.top.mas_equalTo(self.lwqDetailLabel.mas_bottom).offset(10);
                    }];
                }
                if (i==1) {
                    [self.imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(padding);
                        make.right.mas_equalTo(-padding);
                        make.height.mas_equalTo(_height);
                        make.top.mas_equalTo(self.imageView1.mas_bottom).offset(10);
                    }];
                    
                }
                [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:thumbArr[0]]];
                [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:thumbArr[1]]];
              
            }
            
            
            
            
            if (thumbArr.count == 3)
            {
                if (i==0) {
                    [self.imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(padding);
                        make.right.mas_equalTo(-padding);
                        make.height.mas_equalTo(_height);
                        make.top.mas_equalTo(self.lwqDetailLabel.mas_bottom).offset(10);
                    }];
                }
                if (i==1) {
                    [self.imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(padding);
                        make.right.mas_equalTo(-padding);
                        make.height.mas_equalTo(_height);
                        make.top.mas_equalTo(self.imageView1.mas_bottom).offset(10);
                    }];

                }
                if (i==2) {
                    [self.imageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(padding);
                        make.right.mas_equalTo(-padding);
                        make.height.mas_equalTo(_height);
                        make.top.mas_equalTo(self.imageView2.mas_bottom).offset(10);
                    }];
                }
                
                [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:thumbArr[0]]];
                [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:thumbArr[1]]];
                [self.imageView3 sd_setImageWithURL:[NSURL URLWithString:thumbArr[2]]];
            
            }

            
            
//            else {
//                [self.imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.height.mas_equalTo(0);
//                }];
//                [self.imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.height.mas_equalTo(0);
//                }];
//                [self.imageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.height.mas_equalTo(0);
//                }];
//            }
        }

        [self resetLayoutWithNum:thumbArr.count];
    }else{
        YLNewsModel *model = obj;
        self.lblDetail.text = model.content;
        if (self.type == kYLCommetnHeaderTypeForum) {
            [self.userView updateWithModel:obj];
        }
        if (model.thumb.length > 0) {
            NSURL *url = [NSURL URLWithString:model.thumb];
            [self.imageView sd_setImageWithURL:url];
        } else {
            [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0);
            }];
        }
        [self resetLayoutWithNum:100];
    }
    
}

- (void)resetLayoutWithNum:(NSInteger)num
{
    [self layoutIfNeeded];
    if (num == 100) {
        CGRect frame = self.frame;
        frame.size.height = CGRectGetMaxY(self.lblDetail.frame) + 10;
        self.frame = frame;
    }else{
        CGRect frame = self.frame;
        frame.size.height = CGRectGetMaxY(self.lwqDetailLabel.frame) +10 + _allImgHeight +num*10;
        self.frame = frame;
    }
   
}


-(void)setType:(YLCommetnHeaderType)type
{
    switch (type) {
        case kYLCommetnHeaderTypeNotice:{
            [self.userView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0);
            }];
            self.userView.hidden = YES;
        }break;
        case kYLCommetnHeaderTypeForum:{
        }break;
        default:
            break;
    }
    _type = type;
}



@end
