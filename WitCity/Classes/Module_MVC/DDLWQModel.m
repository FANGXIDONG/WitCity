//
//  DDLWQModel.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/6.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDLWQModel.h"
#import "GetImageSizeUtil.h"

@implementation DDLWQModel


-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.pages = dict[@"pages"];
        self.title = dict[@"title"];
        self.reply = dict[@"reply"];
        self.circle_id = dict[@"circle_id"];
        self.name = dict[@"name"];
        self.inserttime = dict[@"inserttime"];
        self.thumb = dict[@"thumb"];
        self.avatar  =dict[@"avatar"];
        self.content = dict[@"content"];
        self.url = dict[@"url"];
        
        NSArray *thumbArray = [self.thumb mutableCopy];
        
        self.imageArray = [NSMutableArray array];
        for (int i = 0; i < thumbArray.count; i++) {
            
            DDContentImageModel *model = [[DDContentImageModel alloc] init];
            model.imageUrl = thumbArray[i];
            CGSize size = [GetImageSizeUtil getImageSizeWithURL:model.imageUrl];
            model.width = size.width;
            model.height = size.height;
            [self.imageArray addObject:model];
//            NSLog(@"%f,%f",model.width,model.height);
//            NSLog(@"%@",model.imageUrl);
        }
        

    }
    return  self;
}


@end
@implementation DDContentImageModel



@end









