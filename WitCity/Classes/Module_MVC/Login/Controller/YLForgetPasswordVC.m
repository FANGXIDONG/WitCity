//
//  YLForgetPasswordVC.m
//  HYB
//
//  Created by simpletour on 16/3/29.
//  Copyright © 2016年 HYB. All rights reserved.
//

#import "YLForgetPasswordVC.h"
#import "YLForgetPasswordView.h"
#import "YLToast.h"
#import "YLUserHttpUtil.h"
#import "YLValidateManager.h"

@interface YLForgetPasswordVC ()

@property (nonatomic, strong) YLForgetPasswordView *mainView;
@property (nonatomic, strong) YLValidateManager *validateManager;

@end

@implementation YLForgetPasswordVC


#pragma mark - init
- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@"忘记密码"];
    [self addViews];
}

-(void)addViews
{
    [self.view addSubview:self.mainView];
}

#pragma mark - getter
-(YLForgetPasswordView *)mainView
{
    if(!_mainView) {
        _mainView = [[YLForgetPasswordView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2)];
        WS(wself);
        _mainView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _mainView;
}

-(YLValidateManager *)validateManager
{
    if(!_validateManager) {
        _validateManager = [[YLValidateManager alloc]initWithController:self];
    }
    return _validateManager;
}

#pragma mark - callback
-(void)callbackWithDict:(NSDictionary *)dict
{
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    switch (blockType) {
        case kYLBlockTypeForgetPassword :{
            YLLoginModel *model = dict[kYLModel];
            [self changePasswordWithModel:model];
        }break;
        case kYLBlockTypeMessageCode :{
            NSString *phone = dict[kYLValue];
            [self sendMsgWithPhone:phone];
        }break;
        case kYLBlockTypeLogin :{
            [self popViewController];
        }break;
        default:
            break;
    }
}

#pragma mark - server
- (void)changePasswordWithModel:(YLLoginModel *)model
{
    if ([self.validateManager validateForgetPasswordWithModel:model]) {
        [YLUserHttpUtil forgetPasswordWithUsername:model.username password:model.password msgCode:model.vercode block:^(NSDictionary *dict) {
            [YLToast showToastInKeyWindowWithText:@"密码修改成功"];
            [self popViewController];
        } failure:^{
            
        }];
    }
}

- (void)sendMsgWithPhone:(NSString *)phone
{
    if ([self.validateManager validateVercodeWithPhone:phone]) {
        [self.mainView distableStatus];
        [YLUserHttpUtil msgCodeWithUsername:phone block:^(NSDictionary *dict) {
        } failure:^{
        }];
    }
}

#pragma mark - other



@end
