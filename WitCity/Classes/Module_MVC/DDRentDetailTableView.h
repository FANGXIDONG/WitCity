//
//  DDRentDetailTableView.h
//  WitCity
//
//  Created by 方冬冬 on 16/8/11.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLTableView.h"
#import "DDRentoutDetailModel.h"

@interface DDRentDetailTableView : YLTableView
- (void)updateWithModel: (DDRentoutDetailModel *)model;
@end
