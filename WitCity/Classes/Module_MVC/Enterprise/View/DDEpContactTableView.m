//
//  DDEpContactTableView.m
//  WitCity
//
//  Created by 方冬冬 on 2017/1/3.
//  Copyright © 2017年 bjxybs. All rights reserved.
//

#import "DDEpContactTableView.h"
#import "DDEpContactCell.h"
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h> //cell高度自适应
#import "DDEpCategoryModel.h"
#import "DDEnterpriseContactModel.h"

@interface DDEpContactTableView()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation DDEpContactTableView

static NSString *cellId = @"contacts";

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[DDEpContactCell class] forCellReuseIdentifier:cellId];
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.data.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DDEpCategoryModel *model = self.data[section];
     return model.value.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self fd_heightForCellWithIdentifier:cellId cacheByIndexPath:indexPath configuration:^(DDEpContactCell *cell) {
        DDEpCategoryModel *model  = self.data[indexPath.section];
        DDEnterpriseContactModel *contactModel = [DDEnterpriseContactModel mj_objectWithKeyValues:model.value[indexPath.row]];
        [cell updateWithModel:contactModel];
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDEpContactCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[DDEpContactCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    WS(ws);
    cell.allBlock = ^(NSDictionary *dict) {
        [ws allBlockWithDict:dict];
    };
    DDEpCategoryModel *model  = self.data[indexPath.section];
    DDEnterpriseContactModel *contactModel = [DDEnterpriseContactModel mj_objectWithKeyValues:model.value[indexPath.row]];
    [cell updateWithModel:contactModel];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    DDEpCategoryModel *model  = self.data[section];
    UIView *headeriew = [[UIView alloc]init];
    headeriew.backgroundColor = kYLColorBakcgorund;
    UILabel *character = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 20, 20)];
    character.text = model.letter;
    character.textColor = kYLColorFontBlack;
    [headeriew  addSubview:character];
    return headeriew;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DDEpCategoryModel *model  = self.data[indexPath.section];
    DDEnterpriseContactModel *contactModel = [DDEnterpriseContactModel mj_objectWithKeyValues:model.value[indexPath.row]];
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeEnterpriseContactDeatil),
                             kYLModel : contactModel
                             }];
}

//右边字母索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    NSMutableArray *toBeReturned = [[NSMutableArray alloc]init];
    
    for(char c = 'A';c<='Z';c++)
        
        [toBeReturned addObject:[NSString stringWithFormat:@"%c",c]];
    
    return toBeReturned;
}

////索引列点击事件
//-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//
//{
//    
//    NSLog(@"===%@  ===%ld",title,(long)index);
//    
//    //点击索引，列表跳转到对应索引的行
//    [tableView
//     scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index+4]
//     atScrollPosition:UITableViewScrollPositionTop animated:YES];
//    return index+4;
//}


@end
