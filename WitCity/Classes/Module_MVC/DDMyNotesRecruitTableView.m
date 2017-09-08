//
//  DDMyNotesRecruitTableView.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/10.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDMyNotesRecruitTableView.h"
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h> //cell高度自适应
#import "DDSendNotesOfRecruitCell.h"

@interface DDMyNotesRecruitTableView()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation DDMyNotesRecruitTableView

static NSString *recruitcellId = @"recruitcellId";

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[DDSendNotesOfRecruitCell class] forCellReuseIdentifier:recruitcellId];
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
        return [self fd_heightForCellWithIdentifier:recruitcellId cacheByIndexPath:indexPath configuration:^(DDSendNotesOfRecruitCell *cell) {
            [cell updateWithModel:self.data[indexPath.row]];
        }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    DDSendNotesOfRecruitCell *cell =  [tableView dequeueReusableCellWithIdentifier:recruitcellId forIndexPath:indexPath];
    if (!cell) {
        cell = [[DDSendNotesOfRecruitCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:recruitcellId];
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
        case kDDBlockTypeNotesShow:
        {
            [self allBlockWithDict:@{
                                     kYLKeyForBlockType : @(kDDBlockTypeNotesShow),
                                     kYLValue:dict[kYLValue],
                                     }];
        }break;
        case kDDBlockTypeNotesHide:
        {
            [self allBlockWithDict:@{
                                     kYLKeyForBlockType : @(kDDBlockTypeNotesHide),
                                     kYLValue:dict[kYLValue],
                                     }];
        }break;
        default:
            break;
    }
}


@end
