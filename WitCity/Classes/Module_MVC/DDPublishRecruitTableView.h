//
//  DDPublishRecruitTableView.h
//  WitCity
//
//  Created by 方冬冬 on 16/8/17.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLTableView.h"
#import "DDRecruitModel.h"

@interface DDPublishRecruitTableView : YLTableView

//@property (nonatomic, copy) NSString *flag;
@property (nonatomic, strong) DDRecruitModel *recruitModel;
-(void)setUpdateRecruitDataWithModel:(DDRecruitModel *)model;
@end
