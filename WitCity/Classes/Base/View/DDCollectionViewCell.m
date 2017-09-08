//
//  DDCollectionViewCell.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/19.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDCollectionViewCell.h"

@interface DDCollectionViewCell()

@end

@implementation DDCollectionViewCell
basicMethodsImplementWithView(DDCollectionViewCell)

- (void)allBlockWithDict:(NSDictionary *)dict
{
    if(self.allBlock) {
        self.allBlock(dict);
    }
}

-(void)updateWithModel:(id)obj{}
@end
