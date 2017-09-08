//
//  DDDefaultVC.h
//  WitCity
//
//  Created by 方冬冬 on 16/7/12.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLDetailVC.h"
#import "DDBusListModel.h"
#import "DDNewsModel.h"
#import "DDRecruitModel.h"
#import <NJKWebViewProgressView.h> //进度条视图
#import <NJKWebViewProgress.h>     //进度条对象

@interface DDDefaultVC : YLDetailVC<UIWebViewDelegate,NJKWebViewProgressDelegate>
{
    //进度条的view
    NJKWebViewProgressView *_progressView;
    //进度条对象
    NJKWebViewProgress *_progressProxy;
}
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic , copy) NSString *flag;

@end
