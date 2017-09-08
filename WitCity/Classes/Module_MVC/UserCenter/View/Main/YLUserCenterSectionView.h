//
//  YLUserCenterSectionView.h
//  WitCity
//
//  Created by simpletour on 16/5/21.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLView.h"

#define kYLUserCenterSectionHeight (60)

@interface YLUserCenterSectionView : YLView

@property (nonatomic, assign) NSInteger section;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageNamed;
@property (nonatomic, copy) NSString *value;

@end
