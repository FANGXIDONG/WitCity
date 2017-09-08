//
//  DDDefaultDevelopingVC.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/19.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDDefaultDevelopingVC.h"
#import "DDDevelopingView.h"

@interface DDDefaultDevelopingVC ()

@property (nonatomic, strong)DDDevelopingView *developView;
@end

@implementation DDDefaultDevelopingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"敬请期待";
    
    [self addViews];
}

-(void)addViews{
    
    
    [self.view addSubview:self.developView];
}


-(DDDevelopingView *)developView{
    
    if (!_developView) {
        _developView = [[DDDevelopingView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2)];
    }
    return _developView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
