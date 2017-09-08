//
//  CustomView.m
//  WitCity
//
//  Created by 方冬冬 on 16/6/28.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (instancetype)initWithFrame:(CGRect)frame Width:(CGFloat)width LabelString:(id)labelString collor:(UIColor *)collor{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        CGFloat totalWidth = self.frame.size.width;
        CGFloat totalHeight = self.frame.size.height;
        
        _button = [UIButton buttonWithType:(UIButtonTypeSystem)];
        
        _button.frame = CGRectMake(0, 0, width, totalHeight);
        
        _button.tintColor = collor;
        
        [self addSubview:_button];
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(width, 0, totalWidth - width, totalHeight)];
        
        _label.textColor = collor;
        
        NSString *string = [NSString stringWithFormat:@"%@",labelString];
        
        _label.text = string;
        
        NSLog(@"%@",string);
        
        _label.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:_label];
        
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    
    self.label.text =[NSString stringWithFormat:@"%@",title];
}

- (void)setColor:(UIColor *)color {
    
    self.button.tintColor = color;
    self.label.textColor = color;
}


@end
