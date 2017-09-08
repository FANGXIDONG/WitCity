//
//  YLAboutVC.m
//  WitCity
//
//  Created by simpletour on 16/6/20.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLAboutVC.h"
#import "YLAboutView.h"

@interface YLAboutVC ()

@property (nonatomic, strong) YLAboutView *mainView;

@end

@implementation YLAboutVC


#pragma mark - init
- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@"智慧城市"];
    [self addViews];
}

-(void)addViews
{
    [self.view addSubview:self.mainView];
}

#pragma mark - getter
-(YLAboutView *)mainView
{
    if(!_mainView) {
        _mainView  = [[YLAboutView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2)];
    }
    return _mainView;
}




@end
