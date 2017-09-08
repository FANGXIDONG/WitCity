//
//  DDEnterpriseEditTableView.h
//  WitCity
//
//  Created by 方冬冬 on 2017/7/27.
//  Copyright © 2017年 bjxybs. All rights reserved.
//

#import "YLTableView.h"
#import "DDDataModel.h"

@interface DDEnterpriseEditTableView : YLTableView
@property (nonatomic, strong) NSArray *txtArr;      //单元格左边标题数组
@property (nonatomic, strong) NSArray *typeArr;
@property (nonatomic, strong) NSArray *industryArr;
@property (nonatomic, strong) DDDataModel *dataModel;
@end
