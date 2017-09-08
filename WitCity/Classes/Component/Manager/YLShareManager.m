//
//  YLShareManager.m
//  HYB
//
//  Created by duyulong on 16/4/30.
//  Copyright © 2016年 HYB. All rights reserved.
//

#import "YLShareManager.h"
#import "YLToast.h"

@interface YLShareManager ()

@property (nonatomic, strong) UIViewController *controller;

@end

@implementation YLShareManager

-(instancetype)initWithController:(UIViewController *)controller
{
    self = [super init];
    if (self) {
        self.controller = controller;
    }
    return self;
}

-(void)shareWithNameKey:(NSString *)nameKey model:(YLModel *)model block:(void(^)())block
{
    YLNewsModel *ylmodel;
    DDNewsModel *ddmodel;
    DDEnterpriseContactModel *contactModel;
    
    if ([model isKindOfClass:[DDEnterpriseContactModel class]]) {
        contactModel = (DDEnterpriseContactModel *)model;
        
        NSString *title = [NSString stringWithFormat:@"企业%@，法人代表%@，联系电话%@",contactModel.company,contactModel.name,contactModel.phone];
        NSString *url = contactModel.url;
        
        UIImage *image = [UIImage imageNamed:@"app_icon"];
        [UMSocialData defaultData].extConfig.wechatSessionData.title = title;
        [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
        [UMSocialData defaultData].extConfig.wechatTimelineData.title = title;
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
        [UMSocialData defaultData].extConfig.qqData.url = url;
        [UMSocialData defaultData].extConfig.qzoneData.url = url;
        
        [[UMSocialDataService defaultDataService] postSNSWithTypes:@[nameKey] content:title image:image location:nil urlResource:nil presentedController:self.controller completion:^(UMSocialResponseEntity *response) {
            if(response.responseCode == UMSResponseCodeSuccess) {
                block();
            }
        }];
    }
    if ([model isKindOfClass:[YLNewsModel class]]) {
        ylmodel = (YLNewsModel *)model;
        
        NSString *title = ylmodel.title;
        NSString *url = ylmodel.url;
        
        UIImage *image = [UIImage imageNamed:@"app_icon"];
        [UMSocialData defaultData].extConfig.wechatSessionData.title = title;
        [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
        [UMSocialData defaultData].extConfig.wechatTimelineData.title = title;
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
        [UMSocialData defaultData].extConfig.qqData.url = url;
        [UMSocialData defaultData].extConfig.qzoneData.url = url;
        
        [[UMSocialDataService defaultDataService] postSNSWithTypes:@[nameKey] content:title image:image location:nil urlResource:nil presentedController:self.controller completion:^(UMSocialResponseEntity *response) {
            if(response.responseCode == UMSResponseCodeSuccess) {
                block();
            }
        }];
    }
    if ([model isKindOfClass:[DDNewsModel class]]) {
        ddmodel = (DDNewsModel *)model;
        
//        @"http://uc-baobab.wdjcdn.com/1469196647893_8318_854x480.mp4?t=1470128942&k=23f92b384b50b101";
        
        NSString *title = ddmodel.doc;
        NSString *url = ddmodel.url;
        
        UIImage *image = [UIImage imageNamed:@"app_icon"];
        [UMSocialData defaultData].extConfig.wechatSessionData.title = title;
        [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
        [UMSocialData defaultData].extConfig.wechatTimelineData.title = title;
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
        [UMSocialData defaultData].extConfig.qqData.url = url;
        [UMSocialData defaultData].extConfig.qzoneData.url = url;
        
        [[UMSocialDataService defaultDataService] postSNSWithTypes:@[nameKey] content:title image:image location:nil urlResource:nil presentedController:self.controller completion:^(UMSocialResponseEntity *response) {
            if(response.responseCode == UMSResponseCodeSuccess) {
                block();
            }
        }];
        
    }

}

-(void)didCloseUIViewController:(UMSViewControllerType)fromViewControllerType
{
    NSLog(@"didClose is %d",fromViewControllerType);
}

//下面得到分享完成的回调
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    NSLog(@"didFinishGetUMSocialDataInViewController with response is %@",response);
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess) {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}


@end
