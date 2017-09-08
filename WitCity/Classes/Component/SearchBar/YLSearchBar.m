//
//  YLSearchBar.m
//  HYB
//
//  Created by simpletour on 16/3/31.
//  Copyright © 2016年 HYB. All rights reserved.
//

#import "YLSearchBar.h"

@interface YLSearchBar ()<UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation YLSearchBar

-(void)addViews
{
    [self addSubview:self.searchBar];
}

-(void)layout
{
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

-(void)useStyle
{
    self.backgroundColor = [UIColor clearColor];
    self.searchBar.tintColor=[UIColor blueColor];   //设置光标颜色，不设置不显示光标
//    self.searchBar.barTintColor = kYLColorFontBlue;
//    self.searchBar.layer.borderColor = kYLColorFontBlue.CGColor;
//    self.searchBar.layer.borderWidth = 1.0f;
    self.searchBar.backgroundImage = [UIImage new];
    self.searchBar.delegate = self;
    self.searchBar.showsCancelButton = YES;
    self.searchBar.placeholder = @"请输入搜索内容";
    [self.searchBar becomeFirstResponder];
}

#pragma mark - delegate
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kYLBlockTypeSearchBarCancel)
                             }];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length <= 0) {
        [self allBlockWithDict:@{
                                 kYLKeyForBlockType : @(kYLBlockTypeSearchBarClear)
                                 }];
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kYLBlockTypeSearchBarSearch),
                             kYLValue : searchBar.text
                             }];
}

#pragma mark - setter
-(void)setPlaceholder:(NSString *)placeholder
{
    self.searchBar.placeholder = placeholder;
}

-(void)setText:(NSString *)text
{
    self.searchBar.text = text;
}

-(NSString *)text
{
    return self.searchBar.text;
}

- (void)setSearchBarIcon:(NSString *)iconName {
    [self.searchBar setImage:[UIImage imageNamed:iconName] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
}

@end
