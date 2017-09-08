
//
//  DDPublishImageCollectionViewCell.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/27.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDPublishImageCollectionViewCell.h"
#import "YLMacro.h"

@implementation DDPublishImageCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if (!_imgView) {
            _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kPictureHW, kPictureHW)];
            _imgView.contentMode = UIViewContentModeScaleAspectFill;
            _imgView.clipsToBounds = YES;
            _imgView.layer.masksToBounds = YES;
            _imgView.layer.cornerRadius = 2.0;
            [self.contentView addSubview:_imgView];
        }
        
        if (!_deleteBtn) {
            _deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(kPictureHW-20, 0, 20, 20)];
            [_deleteBtn setImage:[UIImage imageNamed:@"btn_right_delete_image"] forState:UIControlStateNormal];
            _deleteBtn.backgroundColor = [UIColor blackColor];
            _deleteBtn.layer.cornerRadius = CGRectGetWidth(_deleteBtn.bounds)/2;
            _deleteBtn.layer.masksToBounds = YES;
            
            [_deleteBtn addTarget:self action:@selector(deleteBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:_deleteBtn];
        }
    }
    return self;
}

//attention by fangdongdong
-(void)setCurImageItem:(DDImageItemModel *)curImageItem
{
    _curImageItem=curImageItem;
    if (_curImageItem) {
        RAC(self.imgView, image) = [RACObserve(self.curImageItem, thumbnailImage) takeUntil:self.rac_prepareForReuseSignal];
        _deleteBtn.hidden = NO;
    }
    else
    {
        _imgView.image = [UIImage imageNamed:@"btn_addPicture_BgImage"];
        if (_deleteBtn) {
            _deleteBtn.hidden = YES;
        }
    }
}

- (void)deleteBtnClicked:(id)sender{
    if (_deleteImageBlock) {
        _deleteImageBlock(_curImageItem);
    }
}
+(CGSize)ccellSize{
    return CGSizeMake(kPictureHW,kPictureHW);
}

@end
