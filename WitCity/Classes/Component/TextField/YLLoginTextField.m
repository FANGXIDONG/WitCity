//
//  YLLoginTextField.m
//  FJZ
//
//  Created by simpletour on 15/12/15.
//  Copyright © 2015年 FJZ. All rights reserved.
//

#import "YLLoginTextField.h"

@interface YLLoginTextField()<UITextFieldDelegate>

@property (nonatomic, strong) UIView  *leftCustomView;
@property (nonatomic, strong) UIView  *line;

@end

@implementation YLLoginTextField


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

    self.line = [[UIView alloc]initWithFrame:CGRectMake(0, 43, WINDOW_WIDTH- 16*2, 1)];
    self.line.backgroundColor = kYLColorLine;
    [self addSubview:self.line];
}

- (void)useStyle
{
    self.leftView = self.leftCustomView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

#pragma mark - setter
-(void)setImageNamed:(NSString *)imageNamed
{
    self.leftCustomView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, 30, 44)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.leftCustomView.frame];
    [self.leftCustomView addSubview:imageView];
}

-(void)setIsHideLine:(BOOL)isHideLine
{
    self.line.hidden = isHideLine;
}


@end
