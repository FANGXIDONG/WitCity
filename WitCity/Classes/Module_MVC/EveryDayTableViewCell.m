//
//  EveryDayTableViewCell.m
//  WitCity
//
//  Created by 方冬冬 on 16/6/28.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

/**view1添加view2到其中，如果view2大于view1，或者view2的坐标不在view1的范围内，view2是盖着view1的，意思就是超出的部份也会画出来
 
 UIView有一个属性，clipsTobounds 默认情况下是NO,
 如果，我们想要view2把超出的那部份隐藏起来的话，就得改变它的父视图也就view1的clipsTobounds属性值。
 view1.clipsTobounds = YES;*/

#import "EveryDayTableViewCell.h"
#import "EveryDayModel.h"

@implementation EveryDayTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        self.clipsToBounds = YES;
        
        _picture = [[UIImageView alloc]initWithFrame:CGRectMake(0, -(WINDOW_HEIGHT/1.7 -250)/2, WINDOW_WIDTH, WINDOW_HEIGHT/1.7)];
        _picture.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView  addSubview:_picture];
        
        _coverview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, 250)];
        _coverview.backgroundColor = [UIColor colorWithWhite:0 alpha:0.33];
        [self.contentView addSubview:_coverview];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 250 / 2 - 30, WINDOW_WIDTH, 30)];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_titleLabel];
        
        _littleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 250 / 2 + 30, WINDOW_WIDTH, 30)];
        _littleLabel.font = [UIFont systemFontOfSize:14];
        _littleLabel.textAlignment = NSTextAlignmentCenter;
        _littleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_littleLabel];
        
    }
    return self;
    
}

- (void)setModel:(EveryDayModel *)model{
    
    if (_model != model) {
        
        [_picture sd_setImageWithURL:[NSURL URLWithString:model.coverForDetail] placeholderImage:nil];
        _titleLabel.text = model.title;
        // 转换时间
        NSInteger time = [model.duration integerValue];
        NSString *timeString = [NSString stringWithFormat:@"%02ld'%02ld''",time/60,time% 60];//显示的是音乐的总时间
        NSString *string = [NSString stringWithFormat:@"#%@ / %@",model.category, timeString];
        _littleLabel.text = string;
    }
    
}

- (CGFloat)cellOffset {
    
    CGRect centerToWindow = [self convertRect:self.bounds toView:self.window];
    CGFloat centerY = CGRectGetMidY(centerToWindow);
    CGPoint windowCenter = self.superview.center;
    
    CGFloat cellOffsetY = centerY - windowCenter.y;
    
    CGFloat offsetDig =  cellOffsetY / self.superview.frame.size.height *2;
    CGFloat offset =  -offsetDig * (WINDOW_HEIGHT/1.7 - 250)/2;
    
    CGAffineTransform transY = CGAffineTransformMakeTranslation(0,offset);
    
    //    self.titleLabel.transform = transY;
    //    self.littleLabel.transform = transY;
    
    self.picture.transform = transY;
    
    return offset;
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
