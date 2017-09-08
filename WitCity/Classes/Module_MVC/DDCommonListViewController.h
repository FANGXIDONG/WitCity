//
//  DDCommonListViewController.h
//  WitCity
//
//  Created by 方冬冬 on 16/7/6.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

//求职、出租、求租、柳梧圈列表通用列表

#import "YLListViewController.h"

typedef enum : NSUInteger {
    
    kDDCommunityJobWantList =  1,    //求职
    kDDCommunityRentOutList,         //出租
    kDDCommunityRentWantList,        //出租
    kDDCommunityLWQList              //柳梧圈
    
} kDDCommunityVarious;

@interface DDCommonListViewController : YLListViewController

@property (nonatomic, copy)   NSString *naviTitle;
@property (nonatomic, assign) NSInteger categoryId;
@end
