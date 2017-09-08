//
//  YLTagsView.h
//  WitCity
//
//  Created by duyulong on 16/5/19.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLView.h"

@interface YLTagsView : YLView

@property (nonatomic, strong) NSString *title;

- (void)updateWithArray:(NSArray *)array;

@end
