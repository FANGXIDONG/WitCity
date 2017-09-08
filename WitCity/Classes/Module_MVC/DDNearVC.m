//
//  DDNearVC.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/5.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDNearVC.h"
#import "DDLifeHomeView.h" //通用视图
#import "DDNearCollectionViewCell.h"
//#import "DDCollectionReusableView.h"
#import "DDLifeUserCenterVC.h"
#import "DDZTHomeModel.h"
#import "MJRefresh.h"
#import "DDDefaultVC.h"
#import "YLLoginManager.h"

#define kSegeHeight  6

@interface DDNearVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic ,strong) UIView *variousView ;
@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic ,strong) NSMutableArray *dataArray;
@property (nonatomic,strong)YLLoginManager *loginManager;
@end

@implementation DDNearVC

static NSString *cellIdentifier = @"collectionCell";
//static NSString *kheaderIdentifier = @"HeaderView";

//-(void)viewWillAppear:(BOOL)animated{
//    
//    [DDLifeVersionHttpEncryptUtil testBlock:^(NSDictionary *dict) {
//        //
//    } failure:^{
//        //
//    }];
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self naviSetting];
    [self addViews];
    [self refresh];
}

-(YLLoginManager *)loginManager
{
    if(!_loginManager) {
        _loginManager = [[YLLoginManager alloc]initWithController:self];
    }
    return _loginManager;
}

-(void)naviSetting{
    self.naviStyle = 1;
    self.navigationItem.title = @"周边";
    self.navigationItem.leftBarButtonItem = [self buttonForNavigationBarWithAction:@selector(leftClick) imageNamed:@"hudong_titleleft"];
}
-(void)leftClick{
    [self pushLifeUserCenter];
}

-(void)addViews{
    
    NSArray *nameArray = @[@"美食",@"酒店",@"娱乐",@"其他"];
    NSArray *imageArray = @[@"near_meishi",@"near_jiudian",@"near_yule",@"near_other"];
    
    float commonPadding = 0.0;
    float font = 0.0;
    float orginY = 0.0;
    if (IS_IPHONE_6P) {
        commonPadding = 5;
        font = 15;
        orginY = 15;
    }
    if (IS_IPHONE_6) {
        commonPadding = 7;
        font = 14;
        orginY = 15;
    }
    if (IS_IPHONE_5) {
        commonPadding = 10;
        font = 12;
        orginY = 5;
    }
    if (IS_IPHONE_4_OR_LESS) {
        commonPadding = 13;
        font = 10;
        orginY = 5;
    }
    
    float width = (WINDOW_WIDTH - 4*commonPadding)/nameArray.count;
    
    self.variousView = [[UIView alloc]initWithFrame:CGRectMake(0,0, WINDOW_WIDTH, width)];
    self.variousView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.variousView];
    
    DDLifeHomeView *iconView;
    for (int i = 0; i < nameArray.count; i ++ ) {
        iconView = [[DDLifeHomeView alloc] initWithFrame:CGRectMake((i*width)+commonPadding/2+i*commonPadding, orginY, width, self.variousView.frame.size.height) title:[nameArray objectAtIndex:i] imageName:[imageArray objectAtIndex:i] font:FONT_H(font) titleColor:[UIColor colorWithHex:YLCOLOR_DARK_GREY] titleHeight:10 index:(int)i+10];
        
        [self.variousView addSubview:iconView];
        WS(wself);
        iconView.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
    }
    
    if (!_collectionView) {
        UICollectionViewFlowLayout  *layout =  [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection =UICollectionViewScrollDirectionVertical;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 5;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.variousView.frame.size.height, WINDOW_WIDTH, CONTENT_HEIGHT- self.variousView.frame.size.height) collectionViewLayout:layout];
        [_collectionView registerClass:NSClassFromString(@"DDNearCollectionViewCell") forCellWithReuseIdentifier:cellIdentifier];
        //    [_collectionView registerClass:NSClassFromString(@"DDCollectionReusableView") forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.backgroundColor = kYLColorBakcgorund;
        [self.view addSubview:_collectionView];
        
    }
    
//    [self.collectionView addHeaderWithTarget:self action:@selector(headerRereshing)];
//     [self.collectionView addFooterWithTarget:self action:@selector(footerRereshing)];
//    [self.collectionView headerBeginRefreshing];
//    [self.collectionView footerBeginRefreshing];
//    [self.collectionView headerEndRefreshing];
//    [self.collectionView footerEndRefreshing];
    
}

//-(void)headerRereshing{
//    [super refresh ];
//}
//
//-(void)footerRereshing{
//    [super load];
//}

#pragma mark - callback
-(void)callbackWithDict:(NSDictionary *)dict
{
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    
    switch (blockType) {
            case kDDBlockTypeDelicious:
        {
            NSLog(@"M美食");
            [self pushToDefaultVC:@"美食"];
            
        }break;
            case kDDBlockTypeHotel:
        {
            NSLog(@"酒店");
            [self pushToDefaultVC:@"酒店"];
        }break;
            case kDDBlockTypeEntertainment:
        {
            NSLog(@"娱乐");
            [self pushToDefaultVC:@"娱乐"];
            
        }break;
            case kDDBlockTypeOther:
        {
            NSLog(@"其他");
            [self pushToDefaultVC:@"其他"];
        }break;
    }
}

#pragma mark - push

-(void)pushToDefaultVC:(NSString *)flag
{
    [self.loginManager pushCheckedLoginWithPopToRoot:NO block:^{
        DDDefaultVC *defaultVc = [[DDDefaultVC alloc] init];
        defaultVc.flag = flag;
        defaultVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:defaultVc animated:YES];
    }];
}

#pragma mark - server
-(void)loadWithPage:(NSInteger)page append:(BOOL)append
{
    
    [DDLifeZuTuanHttpUtil getTestDataWithInfo:@"" page:page block:^(NSDictionary *dict) {
        
        NSArray *array = dict[@"data"];
        self.dataArray = [DDZTHomeModel mj_objectArrayWithKeyValuesArray:array];
        
        [self showDataWithTableView:nil dataList:_dataArray withFlag:0  append:append];
        
        [self.collectionView reloadData];
        
    } failure:^{
        //
    }];
}


#pragma mark - push

- (void)pushLifeUserCenter{
    DDLifeUserCenterVC *vc = [[DDLifeUserCenterVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES; //NAvi时隐藏tabbar
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - UICollectionView dataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
//    return 10;
}

//#pragma mark - 集合视图头与脚的复用
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    
//    UICollectionReusableView *reusableview = nil;
//    if (kind == UICollectionElementKindSectionHeader)
//    {
//        DDCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier forIndexPath:indexPath];
//        
//        headerView.backgroundColor =kYLColorFontRed;
//        
////        [headerView.iv setImageWithURL:[NSURL URLWithString:_bigImgUrl] placeholderImage:[UIImage imageNamed:@"ic_page"]];
//        reusableview = headerView;
//    }
////    if (kind == UICollectionElementKindSectionFooter) {
////        DDCollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView" forIndexPath:indexPath];
////        [footView.footView setImageWithURL:[NSURL URLWithString:_footImgUrl] placeholderImage:[UIImage imageNamed:@"ic_page"]];
////        reusableview = footView;
////    }
//    return reusableview;
//}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    DDNearCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [cell updateWithModel:_dataArray[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((WINDOW_WIDTH-15)/2, (WINDOW_WIDTH-15)/2);
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);//分别为上、左、下、右
}
////返回头headerView的大小
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    CGSize size={WINDOW_WIDTH,150};
//    return size;
//}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.loginManager pushCheckedLoginWithPopToRoot:NO block:^{
        
        DDDefaultVC  *detail = [[DDDefaultVC alloc] init];
        detail.nearByModel = _dataArray[indexPath.row];
        detail.hidesBottomBarWhenPushed = YES;
        detail.flag = @"周边首页进入";
        [self.navigationController pushViewController:detail animated:YES];
    }];
}

/**
 *  添加每个cell出现时的3D动画  author by fangdongdong
 */
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0){
    
    CATransform3D rotation;//3D旋转
    rotation = CATransform3DMakeTranslation(0 ,50 ,20);
    //        rotation = CATransform3DMakeRotation( M_PI_4 , 0.0, 0.7, 0.4);
    //逆时针旋转
    
    rotation = CATransform3DScale(rotation, 0.9, .9, 1);
    
    rotation.m34 = 1.0/ -600;
    
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = rotation;
    
    [UIView beginAnimations:@"rotation" context:NULL];
    //旋转时间
    [UIView setAnimationDuration:0.6];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end





























