//
//  DDRecruitListTableView.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/6.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDRecruitListTableView.h"
#import "DDRecruitTableViewCell.h"
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h> //cell高度自适应
#import "DDJobWantTableViewCell.h"
#import "DDRentOutTableViewCell.h"
#import "DDRentWantTableViewCell.h"
#import "DDLWQTableViewCell.h"
#import "DDBrowserImageInfo.h"

//#import "DDLiuWuQuanCell.h"

//#import "UITableView+SDAutoTableViewCellHeight.h"

@interface DDRecruitListTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation DDRecruitListTableView

static NSString *recruitCell = @"recruitCell";
static NSString *jobSeekCell = @"jobSeekCell";
static NSString *rentOutCell = @"rentOutCell";
static NSString *rentWantCell = @"rentWantCell";
static NSString *lwqCell = @"lwqCell";


-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {

        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[DDRecruitTableViewCell class] forCellReuseIdentifier:recruitCell];
        [self registerClass:[DDJobWantTableViewCell class] forCellReuseIdentifier:jobSeekCell];
        [self registerClass:[DDRentOutTableViewCell class] forCellReuseIdentifier:rentOutCell];
        [self registerClass:[DDRentWantTableViewCell class] forCellReuseIdentifier:rentWantCell];
        [self registerClass:[DDLWQTableViewCell class] forCellReuseIdentifier:lwqCell];       
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
    CGFloat height = 0;
    NSString *cellId;
    Class clazz;
    if (self.flagId == 4) {
            DDLWQModel *lwModel = self.data[indexPath.row];
    
            NSArray *arr = lwModel.imageArray;
    
            if (arr.count == 0) {
                height = 65;
            }else{
                height = 150;
            }
    }else{
        
        
        if (self.flagId == 0) {
            cellId = recruitCell;
            clazz = [DDRecruitTableViewCell class];
        } else if (self.flagId == 1) {
            cellId = jobSeekCell;
            clazz = [DDJobWantTableViewCell class];
        } else if (self.flagId == 2) {
            cellId = rentOutCell;
            clazz = [DDRentOutTableViewCell class];
        } else  {
            cellId = rentWantCell;
            clazz = [DDRentWantTableViewCell class];
        }
        
        height = [self fd_heightForCellWithIdentifier:cellId cacheByIndexPath:indexPath configuration:^(YLTableViewCell *cell) {
            [cell updateWithModel:self.data[indexPath.row]];
        }];
        
    }
   
    
//    if (self.flagId == 4) {
//        
//       
//        DDLWQModel *lwModel = self.data[indexPath.row];
//        
//        NSArray *arr = lwModel.imageArray;
//       
//        if (arr.count == 0) {
//            height = 80;
//        }else{
//            height = 170;
//        }
//    

////        
////        return height;
//        
////        NSString *cellId = lwqCell;
////        height = [self fd_heightForCellWithIdentifier:cellId cacheByIndexPath:indexPath configuration:^(YLTableViewCell *cell) {
////            [cell updateWithModel:self.data[indexPath.row]];
////        }];
//
//    }else{
//        
//        if (IS_IPHONE_4_OR_LESS) {
//            height = 80;
//        }
//        if (IS_IPHONE_5) {
//            height = 90;
//        }
//        if (IS_IPHONE_6) {
//            height = 90;
//        }
//        if (IS_IPHONE_6P) {
//            height = 90;
//        }
//
//    }
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId;
    Class clazz;
    if (self.flagId == 0) {
        cellId = recruitCell;
        clazz = [DDRecruitTableViewCell class];
    } else if (self.flagId == 1) {
        cellId = jobSeekCell;
        clazz = [DDJobWantTableViewCell class];
    } else if (self.flagId == 2) {
        cellId = rentOutCell;
        clazz = [DDRentOutTableViewCell class];
    } else if (self.flagId == 3) {
        cellId = rentWantCell;
        clazz = [DDRentWantTableViewCell class];
    } else {
        cellId = lwqCell;
        clazz = [DDLWQTableViewCell class];
    }
    YLTableViewCell *cell =  [self createCellWithTableView:tableView indexPath:indexPath class:clazz cellId:cellId];
    [cell updateWithModel:self.data[indexPath.row]];
//    cell.sd_indexPath = indexPath;
    WS(wself);
    cell.allBlock = ^(NSDictionary *dict) {
        [wself callbackWithDict:dict];
    };
    return cell;
}
#pragma mark - callback
-(void)callbackWithDict:(NSDictionary *)dict
{
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    
    switch (blockType) {
        case kDDBlockTypeLwqImageBrowser:
        {
            DDBrowserImageInfo *browserImg =dict[kYLModel];
            
            [self allBlockWithDict:@{
                                     kYLKeyForBlockType : @(kDDBlockTypeLwqImageBrowser),
                                     kYLModel:browserImg,
                                     }];
        }break;
        default:
            break;
    }
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
    
//    NSLog(@"点击%@,%@",kYLKeyForBlockType,kYLModel);
    
    if (self.flagId == 0) {
        [self allBlockWithDict:@{
                                 kYLKeyForBlockType : @(kDDBlockTypeRecruit),
                                 kYLModel : self.data[indexPath.row]
                                 }];
    } else if (self.flagId == 1) {
        [self allBlockWithDict:@{
                                 kYLKeyForBlockType : @(kDDBlockTypeJobWant),
                                 kYLModel : self.data[indexPath.row]
                                 }];
    } else if (self.flagId == 2) {
        [self allBlockWithDict:@{
                                 kYLKeyForBlockType : @(kDDBlockTypeRentOut),
                                 kYLModel : self.data[indexPath.row]
                                 }];
    } else if (self.flagId == 3) {
        [self allBlockWithDict:@{
                                 kYLKeyForBlockType : @(kDDBlockTypeRentWant),
                                 kYLModel : self.data[indexPath.row]
                                 }];
    } else {
        [self allBlockWithDict:@{
                                 kYLKeyForBlockType : @(kDDBlockTypeLWQ),
                                 kYLModel : self.data[indexPath.row]
                                 }];
    }
    
   
}



@end















