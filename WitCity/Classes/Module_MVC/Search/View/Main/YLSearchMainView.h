//
//  YLSearchMainView.h
//  WitCity
//
//  Created by simpletour on 16/5/20.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLView.h"

@interface YLSearchMainView : YLView

@property (nonatomic, copy) NSString *categoryId;

- (void)showResultViewWithArray:(NSArray *)array;
- (void)hideResultView;

@end
