//
//  DDTextFieldWithLabel.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/16.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDTextFieldWithLabel.h"

@interface DDTextFieldWithLabel()

@property (nonatomic, strong) UIView  *leftCustomView;
@property (nonatomic, strong) UIView  *line;
@property (nonatomic, strong) UILabel *label;
//@property (nonatomic, strong) UIImageView  *selectImg;
@end
@implementation DDTextFieldWithLabel
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self addViews];
        [self useStyle];
        self.font = [UIFont systemFontOfSize:15];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addViews
{
    self.line = [[UIView alloc]initWithFrame:CGRectMake(0, 43, WINDOW_WIDTH, 1)];
    self.line.backgroundColor = kYLColorLine;
    [self addSubview:self.line];
    
//    if (self.type == kDDTextFieldWithoutSelectedItem)
//    {
        self.leftCustomView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, 60, 44)];
        self.label = [[UILabel alloc]initWithFrame:self.leftCustomView.frame];
        self.label.font = [UIFont systemFontOfSize:15];
        [self.leftCustomView addSubview:self.label];
//    }
//    if (self.type == kDDTextFieldWithSelectedItem)
//    {
//        self.leftCustomView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, 100, 44)];
//        self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
//        self.label.font = [UIFont systemFontOfSize:15];
//        [self.leftCustomView addSubview:self.label];
//        self.selectImg = [[UIImageView alloc] initWithFrame:CGRectMake(65, 7, 30, 30)];
//        self.selectImg.image = [UIImage imageNamed:@"si_up"];
//        [self.leftCustomView addSubview:self.selectImg];
// 
//    }else{
//        
//    }
}

- (void)useStyle
{
    self.leftView = self.leftCustomView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

#pragma mark - setter

-(void)setString:(NSString *)string{
    
    self.label.text = string;

}

-(void)setIsHideLine:(BOOL)isHideLine
{
    self.line.hidden = isHideLine;
}

@end
