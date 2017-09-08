//
//  DDTravelTableView.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/12.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDTravelTableView.h"
#import "DDTravelTableViewCell.h"
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>
#import "DDBusSectionView.h"

@interface DDTravelTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation DDTravelTableView

static NSString *cellIentifier = @"travelCell";

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = kYLColorBakcgorund;
        [self registerClass:[DDTravelTableViewCell class] forCellReuseIdentifier:cellIentifier];
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DDBusSectionView *view = [[DDBusSectionView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, kDDBusSectionHeight)];
//    view.section = section;
    NSString *title;
    NSString *imageNamed = @"";
    switch (section) {
        case 0:{
            if (_flag == 1) {
                title = @"搜索结果";
            }else{
                title = @"常用路线";
                imageNamed = @"cx_jt";
            }
            
        }break;
        default:
            break;
    }
    view.title = title;
    view.imageNamed = imageNamed;
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kDDBusSectionHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 90;
//    return [self fd_heightForCellWithIdentifier:cellId cacheByIndexPath:indexPath configuration:^(DDTravelTableViewCell *cell) {
//        [cell updateWithModel:self.data[indexPath.row]];
//    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDTravelTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellIentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[DDTravelTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIentifier];
    }
    
    WS(ws);
    cell.allBlock = ^(NSDictionary *dict) {
        [ws allBlockWithDict:dict];
    };
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [cell updateWithModel:self.data[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeLifeBus),
                             kYLModel : self.data[indexPath.row]
                             }];
}



@end
