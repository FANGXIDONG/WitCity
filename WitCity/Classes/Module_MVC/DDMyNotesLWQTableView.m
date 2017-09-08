//
//  DDMyNotesLWQTableView.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/10.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDMyNotesLWQTableView.h"

#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h> //cell高度自适应

#import "DDSendNotesOfLWQCell.h"

@interface DDMyNotesLWQTableView()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation DDMyNotesLWQTableView

static NSString *lwqcellId = @"lwqcellId";


-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;

        [self registerClass:[DDSendNotesOfLWQCell class] forCellReuseIdentifier:lwqcellId];
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
        return [self fd_heightForCellWithIdentifier:lwqcellId cacheByIndexPath:indexPath configuration:^(DDSendNotesOfLWQCell *cell) {
            [cell updateWithModel:self.data[indexPath.row]];
        }];
    
//    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDSendNotesOfLWQCell *cell =  [tableView dequeueReusableCellWithIdentifier:lwqcellId forIndexPath:indexPath];
//    cell.type = self.categroyId;
    if (!cell) {
        cell = [[DDSendNotesOfLWQCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:lwqcellId];
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
