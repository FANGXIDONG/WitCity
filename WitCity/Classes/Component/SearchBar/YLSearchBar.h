//
//  YLSearchBar.h
//  HYB
//
//  Created by simpletour on 16/3/31.
//  Copyright © 2016年 HYB. All rights reserved.
//

#import "YLView.h"

@interface YLSearchBar : YLView

@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSString *text;

- (void)setSearchBarIcon:(NSString *)iconName;
@end
