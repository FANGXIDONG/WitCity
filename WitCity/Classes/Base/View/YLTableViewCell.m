//
//  XHTableViewCell.m
//  xiaoher
//
//  Created by yulongdu on 15/9/1.
//  Copyright (c) 2015年 wenjin. All rights reserved.
//
#import "YLTableViewCell.h"

@interface YLTableViewCell ()

@end

@implementation YLTableViewCell

basicMethodsImplementWithTableViewCell(YLTableViewCell)

- (void)allBlockWithDict:(NSDictionary *)dict
{
    if(self.allBlock) {
        self.allBlock(dict);
    }
}

-(void)updateWithModel:(id)obj{}

@end
