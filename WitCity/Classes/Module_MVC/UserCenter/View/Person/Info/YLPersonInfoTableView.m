//
//  YLPersonInfoTableView.m
//  WitCity
//
//  Created by simpletour on 16/5/21.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLPersonInfoTableView.h"
#import "YLPersonInfoTableViewCell.h"
#import "YLUserSingleton.h"


@interface YLPersonInfoTableView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) YLUserSingleton *user;

@end

@implementation YLPersonInfoTableView

static NSString *cellId = @"PersonInfoCell";

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = kYLColorBakcgorund;
        [self registerClass:[YLPersonInfoTableViewCell class] forCellReuseIdentifier:cellId];
    }
    return self;
}

-(YLUserSingleton *)user
{
    if(!_user) {
        _user = [YLUserSingleton shareInstance];
    }
    return _user;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    switch (section) {
        case 0:{
            count = 1;
        }break;
        case 1:{
            count = 3;
        }break;
        default:
            break;
    }
    return count;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, 45)];
    view.backgroundColor = kYLColorBakcgorund;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat height = 0.0f;
    switch (section) {
        case 0:{
            height = 15;
        }break;
        case 1:{
            height = 45;
        }break;
        default:
            break;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.section == 0) ? 90 : 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YLPersonInfoTableViewCell *cell =  [[YLPersonInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    
    cell.style = kYLPersonInfoCellStyleDefault;
    NSString *text = @"";
    NSString *detail = @"";
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 0:{
                    text = @"个人头像";
                    self.avatar = cell.avatar;
                    cell.style = kYLPersonInfoCellStyleAvatar;
                    NSURL *url = [NSURL URLWithString:self.user.avatar];
                    [cell.avatar sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"u_header"]];
                }break;
                default:
                    break;
            }
        }break;
        case 1:{
            switch (indexPath.row) {
                case 0:{
                    text = @"昵称";
                    detail = self.user.name;
                }break;
                case 1:{
                    text = @"电话";
                    detail = self.user.phone;
                }break;
                case 2:{
                    text = @"修改密码";
                    detail = @" ";
                }break;
                default:
                    break;
            }
        }break;
        default:
            break;
    }
    
    cell.title = text;
    cell.detail = detail;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YLBlockType blockType = 0;
    switch (indexPath.section) {
        case 0: {
            blockType = kYLBlockTypePhotoOption;
        }break;
        case 1: {
            switch (indexPath.row) {
                case 0:{
                    blockType = kYLBlockTypePersonInfoNickname;
                }break;
                case 1:{
                    blockType = kYLBlockTypePersonInfoPhone;
                }break;
                case 2:{
                    blockType = kYLBlockTypePersonInfoChangePassword;
                }break;
                default:
                    break;
            }
        }break;
        default:
            break;
    }
    
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(blockType),
                             }];
}

#pragma mark - setter
-(void)setImage:(UIImage *)image
{
    _image = image;
    self.avatar.image = image;
}


@end
