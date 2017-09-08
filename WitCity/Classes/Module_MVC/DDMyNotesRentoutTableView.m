//
//  DDMyNotesRentoutTableView.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/10.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDMyNotesRentoutTableView.h"

#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h> //cell高度自适应

#import "DDSendNotesOfRentoutCell.h"

@interface DDMyNotesRentoutTableView()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation DDMyNotesRentoutTableView

static NSString *rentoutcellId = @"rentoutcellId";


-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    
        [self registerClass:[DDSendNotesOfRentoutCell class] forCellReuseIdentifier:rentoutcellId];
      
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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return [self fd_heightForCellWithIdentifier:rentoutcellId cacheByIndexPath:indexPath configuration:^(DDSendNotesOfRentoutCell *cell) {
            [cell updateWithModel:self.data[indexPath.row]];
        }];
    
//    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
        DDSendNotesOfRentoutCell *cell =  [tableView dequeueReusableCellWithIdentifier:rentoutcellId forIndexPath:indexPath];
//        cell.type = self.categroyId;
        if (!cell) {
            cell = [[DDSendNotesOfRentoutCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:rentoutcellId];
        }
    
        WS(ws);
        cell.allBlock = ^(NSDictionary *dict) {
            [ws allBlockWithDict:dict];
        };
    
        [cell updateWithModel:self.data[indexPath.row]];
        return cell;
}
- (YLTableViewCell *)createCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath class:(Class)clazz cellId:(NSString *)cellId
{
    YLTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    if (!cell) {
        cell = [[clazz alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    [self allBlockWithDict:@{
//                             kYLKeyForBlockType : @(kYLBlockTypeCommentDetail),
//                             kYLModel : self.data[indexPath.row]
//                             }];
}

#pragma mark - callback
-(void)callbackWithDict:(NSDictionary *)dict
{
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    
    switch (blockType) {
        case kDDBlockTypeNotesEdit:
        {
            [self allBlockWithDict:@{
                                     kYLKeyForBlockType : @(kDDBlockTypeNotesEdit),
                                     kYLModel:dict[kYLModel],
                                     }];
        }break;
        case kDDBlockTypeNotesDelete:
        {
            [self allBlockWithDict:@{
                                     kYLKeyForBlockType : @(kDDBlockTypeNotesDelete),
                                     kYLValue:dict[kYLValue],
                                     }];
        }break;
        default:
            break;
    }
}

@end
