//
//  YLCommentUserInfoView.h
//  WitCity
//
//  Created by simpletour on 16/5/26.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLView.h"
#import "YLCommentModel.h"

#define kYLCommentUserInfoHeight (50)

@interface YLCommentUserInfoView : YLView

- (void)updateWithModel:(id)obj;

- (void)updateWithLwqModel:(id)obj;

- (void)updateWithCommentModel:(YLCommentModel *)model;

@end
