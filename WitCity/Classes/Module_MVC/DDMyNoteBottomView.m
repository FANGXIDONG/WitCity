//
//  DDMyNoteBottomView.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/29.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDMyNoteBottomView.h"
#import "YLHorizontalButton.h"
#import "UILabel+YLPadding.h"

@interface DDMyNoteBottomView()
@property (nonatomic, strong) UIView             *line;
@property (nonatomic, strong) UIView             *lineBlock;
@property (nonatomic, strong) UILabel            *lblFlag;
@property (nonatomic, strong) YLHorizontalButton *btnEdit;
@property (nonatomic, strong) YLHorizontalButton *btnDelete;
@property (nonatomic, copy) NSString *editStr;
@property (nonatomic, copy) NSString *deleteStr;
@end

@implementation DDMyNoteBottomView


-(void)addViews
{
    [self addSubview:self.lblFlag];
    [self addSubview:self.btnEdit];
    [self addSubview:self.btnDelete];
    [self addSubview:self.line];
    [self addSubview:self.lineBlock];
}

-(void)layout
{
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.lineBlock mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    
    [self.lblFlag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self).offset(-5);
        make.left.mas_equalTo(16);
        //        make.right.mas_equalTo(self.btnCollect.mas_left).offset(-10);
    }];
    
    [self.btnDelete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.lblFlag);
        make.right.mas_equalTo(-16);
        make.size.mas_equalTo(CGSizeMake(65, 25));
    }];
    
    [self.btnEdit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.and.width.and.height.mas_equalTo(self.btnDelete);
        make.right.mas_equalTo(self.btnDelete.mas_left);
    }];
}

-(void)useStyle
{
    self.lblFlag.backgroundColor = kYLColorFontOrange;
    self.lblFlag.textColor = [UIColor whiteColor];
    self.lblFlag.font = [UIFont systemFontOfSize:13];
    self.lblFlag.layer.masksToBounds = YES;
    self.lblFlag.layer.cornerRadius = 4;
    self.lblFlag.hidden = YES;
    self.line.backgroundColor = kYLColorLine;
    self.lineBlock.backgroundColor = kYLColorLine;
//    [self.btnEdit setImage:[UIImage imageNamed:@"mynotes_edit"] forState:UIControlStateNormal];
//    [self.btnEdit setImage:[UIImage imageNamed:@"mynotes_edit"] forState:UIControlStateHighlighted];
//    [self.btnEdit setImage:[UIImage imageNamed:@"mynotes_edit"] forState:UIControlStateSelected];
//    [self.btnDelete setImage:[UIImage imageNamed:@"mynotes_delete"] forState:UIControlStateNormal];
    
    [self.btnEdit setTitleColor:kYLColorFontBlue forState:UIControlStateNormal];
    [self.btnDelete setTitleColor:kYLColorFontRed forState:UIControlStateNormal];
    self.btnEdit.titleLabel.font = [UIFont systemFontOfSize:12];
    self.btnDelete.titleLabel.font = [UIFont systemFontOfSize:12];
    
    self.btnEdit.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 0, 0);
    self.btnDelete.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 0, 0);
//    [self.btnEdit addTarget:self action:@selector(btnCollectClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.btnDelete addTarget:self action:@selector(btnReplyClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.lblFlag setEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
}

//- (void)btnCollectClick:(UIButton *)button
//{
//    YLBlockType blockType = button.selected ? kYLBlockTypeCollectCancel : kYLBlockTypeCollectAdd;
//    NSInteger val = button.currentTitle.integerValue;
//    NSInteger value = button.selected ? (val - 1) : (val + 1);
//    [button setTitle:[NSString stringWithFormat:@"%ld", (long)value] forState:UIControlStateNormal];
//    button.selected = !button.selected;
//    
//    [self allBlockWithDict:@{
//                             kYLKeyForBlockType : @(blockType),
//                             }];
//}
//
//- (void)btnReplyClick:(UIButton *)button
//{
//    [self allBlockWithDict:@{
//                             kYLKeyForBlockType : @(kDDBlockTypeMyNotesEdit),
//                             }];
//}

//-(NSString *)editString
//{
//    return  self.btnEdit.currentTitle;
//}
//
//-(NSString *)deleteString
//{
//    return self.btnDelete.currentTitle;
//}

//-(void)setEditString:(NSString *)editString {
//    [self.btnEdit setTitle:editString forState:UIControlStateNormal];
//}
//
-(void)setDeleteString:(NSString *)deleteString{
    [self.btnDelete setTitle:deleteString forState:UIControlStateNormal];
}

-(void)setType:(DDNotesBottomType)type{
    
    switch (type) {
        case kDDNotesBottomOnlyDelete:
        {//只有删除（柳梧圈）
            self.btnEdit.hidden = YES;
            [self.btnDelete setImage:[UIImage imageNamed:@"mynotes_delete"] forState:UIControlStateNormal];
            [self.btnDelete setTitle:@"删除" forState:UIControlStateNormal];
            [self.btnDelete addTarget:self action:@selector(deleteLWQNotes:) forControlEvents:UIControlEventTouchUpInside];
        }break;
        case kDDNotesBottomEditAndStatus:
        {//编辑和显示（招聘求职）
            [self.btnEdit setImage:[UIImage imageNamed:@"mynotes_edit"] forState:UIControlStateNormal];
            [self.btnDelete setImage:[UIImage imageNamed:@"note_show"] forState:UIControlStateNormal];
            [self.btnDelete setImage:[UIImage imageNamed:@"note_hide"] forState:UIControlStateHighlighted];
            [self.btnDelete setImage:[UIImage imageNamed:@"note_hide"] forState:UIControlStateSelected];
            
            [self.btnEdit setTitle:@"编辑" forState:UIControlStateNormal];
//            [self.btnDelete setTitle:@"显示" forState:UIControlStateNormal];
            
            [self.btnEdit addTarget:self action:@selector(editPosition:) forControlEvents:UIControlEventTouchUpInside];
            [self.btnDelete addTarget:self action:@selector(showHideNotes:) forControlEvents:UIControlEventTouchUpInside];
        }break;
        case kDDNotesBottomEditAndDelete:
        {//编辑和删除（求租出租）
            [self.btnEdit setImage:[UIImage imageNamed:@"mynotes_edit"] forState:UIControlStateNormal];
            [self.btnDelete setImage:[UIImage imageNamed:@"mynotes_delete"] forState:UIControlStateNormal];
            [self.btnEdit setTitle:@"编辑" forState:UIControlStateNormal];
            [self.btnDelete setTitle:@"删除" forState:UIControlStateNormal];
            
            [self.btnEdit addTarget:self action:@selector(editRent:) forControlEvents:UIControlEventTouchUpInside];
            [self.btnDelete addTarget:self action:@selector(deleteRentNotes:) forControlEvents:UIControlEventTouchUpInside];
        }break;
        default:
            break;
    }
    _type = type;
}

-(void)deleteLWQNotes:(UIButton *)sender{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeNotesDelete),
                             }];
}
-(void)editPosition:(UIButton *)sender{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeNotesEdit),
                             }];
}
-(void)showHideNotes:(UIButton *)sender{
    YLBlockType blockType = sender.selected ? kDDBlockTypeNotesHide : kDDBlockTypeNotesShow;
    if (sender.selected) {
        [sender setTitle:@"显示" forState:UIControlStateNormal];
    }else{
        [sender setTitle:@"隐藏" forState:UIControlStateNormal];
    }
    sender.selected = !sender.selected;

    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(blockType),
                             }];
}
-(void)editRent:(UIButton *)sender{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeNotesEdit),
                             }];
}
-(void)deleteRentNotes:(UIButton *)sender{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeNotesDelete),
                             }];
}
@end








