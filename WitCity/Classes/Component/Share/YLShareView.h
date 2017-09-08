//
//  YLShareView.h
//  FJZ
//
//  Created by duyulong on 11/15/15.
//  Copyright © 2015 FJZ. All rights reserved.
//

#import "YLView.h"


@interface YLShareView : YLView

- (void)show;
- (void)hide;

@end



@interface YLShareItemView : YLView

- (void)updateWithTitle:(NSString *)title imageNamed:(NSString *)imageNamed;

@end