
//
//  DDRentoutDetailViewController.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/11.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDRentoutDetailViewController.h"
#import "DDRentDetailTableView.h"   //table view
#import "DDRentoutDetailModel.h"    //出租详情model
#import "DDBrowserImageInfo.h"

@interface DDRentoutDetailViewController ()<MWPhotoBrowserDelegate>

@property (nonatomic, strong) DDRentDetailTableView *detailTableView;
//@property (nonatomic, strong) DDRentoutDetailModel *rwDetailModel;
@property (nonatomic, strong) DDBrowserImageInfo *browserImg;

@end

@implementation DDRentoutDetailViewController


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addViews];
    [self loadData];
}

-(void)addViews{
    [self.view addSubview:self.detailTableView];
   
}

-(DDRentDetailTableView *)detailTableView{
    
    if(!_detailTableView) {
        _detailTableView = [[DDRentDetailTableView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT) style:UITableViewStylePlain];
        
        WS(wself);
        _detailTableView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _detailTableView;
}

-(void)callbackWithDict:(NSDictionary *)dict{
    
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    
    switch (blockType) {
        case kDDBlockTypeBackAction:
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case kDDBlockTypeLwqImageBrowser:
        {
            _browserImg =dict[kYLModel];
            
            MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
            browser.displayActionButton = NO;
            browser.displayNavArrows = YES;
            browser.displaySelectionButtons = NO; //选择按钮
            browser.alwaysShowControls = NO;
            browser.zoomPhotosToFill = YES;
            browser.enableGrid = NO;
            browser.startOnGrid = NO;
            browser.enableSwipeToDismiss = YES;
            browser.autoPlayOnAppear = NO;
            [browser setCurrentPhotoIndex:0];
//            [browser setCurrentPhotoIndex:_browserImg.index];
        
            [self.navigationController pushViewController:browser animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark--MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    
   return self.browserImg.imageArr.count;
}
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    
//     NSArray *arr = [self.rwDetailModel.thumb mutableCopy];

    if (index < self.browserImg.imageArr.count) {
        
        return [self.browserImg.imageArr objectAtIndex:index];
    }
    return nil;
}


-(void)loadData{
    
     [DDLifeHttpUtil getRentoutDetailDataWithLease_id:self.roModel.lease_id Block:^(NSDictionary *dict) {
         
//         DDRentoutDetailModel *model = [DDRentoutDetailModel mj_objectWithKeyValues:dict];
         DDRentoutDetailModel *model = [[DDRentoutDetailModel alloc] init];
         [model setValuesForKeysWithDictionary:dict];
         
         [self.detailTableView updateWithModel:model];
         
         
     } failure:^{
         //
     }];
}

-(void)viewWillDisappear:(BOOL)animated{
     self.navigationController.navigationBar.hidden = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
















