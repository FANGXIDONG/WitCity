//
//  YLPersonEditVC.h
//  WitCity
//
//  Created by simpletour on 16/5/21.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLViewController.h"
#import "YLPersonEditTableView.h"

@interface YLPersonEditVC : YLViewController

@property (nonatomic, assign) YLPersonEditType type;
@property (nonatomic, copy) void(^allBlock)(NSDictionary *dict);


@end
