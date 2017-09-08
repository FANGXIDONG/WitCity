//
//  DDLifeUserCenterTableView.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/18.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDLifeUserCenterTableView.h"
#import "DDLifeUserCenterSectionView.h"
#import "DDLifeUserCenterTableViewCell.h"
#import "DDLifeHomeView.h"
#import "DDStretchableTableHeaderView.h"
#import "DDLifeUserCenterHeaderView.h"

#define kHeaderHeight  70

@interface DDLifeUserCenterTableView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)DDLifeHomeView *commonView;
@property (nonatomic, strong)DDStretchableTableHeaderView *stretchHeaderView;
@property (nonatomic,strong)DDLifeUserCenterHeaderView *headerView;
@end

@implementation DDLifeUserCenterTableView

static NSString *cellIdentifier = @"UserCell";


-(DDLifeUserCenterHeaderView *)headerView
{
    if(!_headerView) {
        _headerView = [[DDLifeUserCenterHeaderView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, kHeaderHeight)];
        WS(wself);
        _headerView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    return _headerView;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = kYLColorBakcgorund;
        [self registerClass:[DDLifeUserCenterTableViewCell class] forCellReuseIdentifier:cellIdentifier];
         [self initStretchHeader];
        
        [ND addObserver:self selector:@selector(changeVersion:) name:kUpdateUserInfoNotification object:nil];
    }
    return self;
}

-(void)dealloc
{
    [ND removeObserver:self name:kUpdateUserInfoNotification object:nil];
}

-(void)changeVersion:(NSNotification *)text{
    
    if ([text.userInfo[@"updateInfo"] isEqualToString:@"更新资料"]){
        [self.headerView updateUserInfo];
    }else{
        
    }
}


- (void)initStretchHeader
{
    //背景
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kHeaderHeight)];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.clipsToBounds = YES;
    bgImageView.userInteractionEnabled = YES;
    bgImageView.backgroundColor = kYLColorFontYellow;
    
    //背景之上的内容
    UIView *contentView = [[UIView alloc] initWithFrame:bgImageView.bounds];
    contentView.backgroundColor = [UIColor clearColor];
    
    [contentView addSubview:self.headerView];
    
    self.stretchHeaderView = [DDStretchableTableHeaderView new];
    [self.stretchHeaderView stretchHeaderForTableView:self withView:bgImageView subViews:contentView];
    
     [self.headerView updateUserInfo];
}
- (void)updateUserInfo
{
    [self.headerView updateUserInfo];
}


#pragma mark - stretchableTable delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.stretchHeaderView scrollViewDidScroll:scrollView];
}

- (void)viewDidLayoutSubviews
{
    [self.stretchHeaderView resizeView];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    switch (section) {
        case 0:{
            count = 1;
        }break;
        case 1:
        {
            count = 1;
        }break;
        default:{
            count = 0;
        }break;
    }
    return count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DDLifeUserCenterSectionView *view = [[DDLifeUserCenterSectionView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, kDDLifeUserCenterSectionHeight)];
    view.section = section;
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerViewClick:)]];
    
    view.style = kDDLifeUserCenterSectionStyleDefault;
    NSString *title;
    NSString *imageNamed = @"";
    switch (section) {
        case 0:{
            title = @"我的订单";
            imageNamed = @"lifeUser_orders";
            view.style = kDDLifeUserCenterSectionStyleDescpription;
            view.lblDescpription.text = @"查看全部订单";
        }break;
        case 1:{
            title = @"我的发帖";
            imageNamed = @"lifeUser_wdft";
        }break;
//        case 2:{
//            title = @"外卖订单";
//            imageNamed = @"lifeUser_waimai";
//        }break;
        default:
        {
            title = @"设置";
            imageNamed =@"lifeUser_setting";
        }
            break;
    }
    view.title = title;
    view.imageNamed = imageNamed;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.0;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            height = 55;
        }
    }
    else{
        height = 44;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kDDLifeUserCenterSectionHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDLifeUserCenterTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[DDLifeUserCenterTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.section == 0) {

        NSArray * _titleArray = @[@"待付款",@"待发货",@"待确认",@"待评价",@"退货/售后"];
        NSArray * _imageArray = @[@"lifeUser_daifukuan",@"lifeUser_daifahuo",@"lifeUser_daiqueren",@"lifeUser_daipingjia",@"lifeUser_tuikuan"];
        
        float width = (WINDOW_WIDTH - 50)/_titleArray.count;
        
        for (int i = 0; i < _titleArray.count; i ++ ) {
            _commonView = [[DDLifeHomeView alloc] initWithFrame:CGRectMake((i*width)+5+i*10, 5, width, self.frame.size.height-10) title:[_titleArray objectAtIndex:i] imageName:[_imageArray objectAtIndex:i] font:FONT_H(10) titleColor:[UIColor colorWithHex:YLCOLOR_DARK_GREY] titleHeight:8 index:(int)i + 14];
            
            [cell addSubview:_commonView];
            WS(wself);
            _commonView.allBlock = ^(NSDictionary *dict) {
                [wself callbackWithDict:dict];
            };
        }
    }
    if (indexPath.section == 1) {

        cell.title = @"我的消息";
        cell.imageNamed = @"lifeUser_message";
        cell.arroImg = @"u_arrow";
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



-(void)callbackWithDict:(NSDictionary *)dict
{

    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    
     [self allBlockWithDict:@{kYLKeyForBlockType: @(blockType)}];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YLBlockType blockType = 0;
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
                case 0:
            {
            }
                break;
                
            default:
                break;
        }
         [self allBlockWithDict:@{kYLKeyForBlockType: @(blockType)}];
    }
    if (indexPath.section == 1) {
        switch (indexPath.row) {
                case 0:
            {
                blockType = kDDBlockTypeMyMessage;
            }
                break;
                
            default:
                break;
        }
         [self allBlockWithDict:@{kYLKeyForBlockType: @(blockType)}];
    }

}


- (void)headerViewClick:(UITapGestureRecognizer *)gesture
{
    DDLifeUserCenterSectionView *view = (DDLifeUserCenterSectionView *)gesture.view;
    NSInteger section = view.section;
    YLBlockType blockType;
    switch (section) {
        case 0:{
            blockType = kDDBlockTypeMyOrders;
        }break;
        case 1:{
            blockType = kDDBlockTypeMySends;
        }break;
//        case 2:{
//            blockType = kDDBlockTypeMyTakeOuts;
//        }break;
        default:
        {
            blockType = kDDBlockTypeMySetting;
        }
            break;
    }
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(blockType)
                             }];
}

@end
