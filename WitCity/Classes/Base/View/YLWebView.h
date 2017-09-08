//
//  YLWebView.h
//  FJZ
//
//  Created by yulongdu on 11/10/15.
//  Copyright © 2015 FJZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLWebView : UIWebView

@property (nonatomic, copy) void(^allBlock)(NSDictionary *dict);

- (void)allBlockWithDict:(NSDictionary *)dict;


@end
