//
//  YLRegisterVC.m
//  HYB
//
//  Created by simpletour on 16/3/29.
//  Copyright © 2016年 HYB. All rights reserved.
//

#import "YLRegisterVC.h"
#import "YLRegisterView.h"
#import "YLUserHttpUtil.h"
#import "YLToast.h"
#import "YLValidateManager.h"

@interface YLRegisterVC ()

@property (nonatomic, strong) YLRegisterView *mainView;
@property (nonatomic, strong) YLValidateManager *validateManager;

@end

@implementation YLRegisterVC


#pragma mark - init
- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationWithTitle:@"注册"];
    [self addViews];
}

-(void)addViews
{
    [self.view addSubview:self.mainView];
}

#pragma mark - getter
-(YLRegisterView *)mainView
{
    if(!_mainView) {
        _mainView = [[YLRegisterView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2)];
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
        case kYLBlockTypeRegister:{
            YLLoginModel *model = dict[kYLModel];
            [self registerWithModel:model];
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
- (void)registerWithModel:(YLLoginModel *)model
{
    if ([self.validateManager validateForgetPasswordWithModel:model]) {
        [YLUserHttpUtil registerWithUsername:model.username password:model.password msgCode:model.vercode type:model.userType nickname:model.nickname block:^(NSDictionary *dict) {
            [YLToast showToastInKeyWindowWithText:@"注册成功"];
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
