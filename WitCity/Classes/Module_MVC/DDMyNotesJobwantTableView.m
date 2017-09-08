//
//  DDMyNotesJobwantTableView.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/10.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDMyNotesJobwantTableView.h"
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h> //cell高度自适应

#import "DDSendNotesOfJobwantCell.h"

@interface DDMyNotesJobwantTableView()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation DDMyNotesJobwantTableView

static NSString *jobwantcellId = @"jobwantcellId";

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[DDSendNotesOfJobwantCell class] forCellReuseIdentifier:jobwantcellId];
        
        
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
        return [self fd_heightForCellWithIdentifier:jobwantcellId cacheByIndexPath:indexPath configuration:^(DDSendNotesOfJobwantCell *cell) {
            [cell updateWithModel:self.data[indexPath.row]];
        }];
    
//    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        DDSendNotesOfJobwantCell *cell =  [tableView dequeueReusableCellWithIdentifier:jobwantcellId forIndexPath:indexPath];
//        cell.type = self.categroyId;
        if (!cell) {
            cell = [[DDSendNotesOfJobwantCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:jobwantcellId];
        }

    
        WS(ws);
        cell.allBlock = ^(NSDictionary *dict) {
            [ws allBlockWithDict:dict];
        };
    
        [cell updateWithModel:self.data[indexPath.row]];
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
