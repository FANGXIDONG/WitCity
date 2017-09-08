//
//  DDRentDetailTableView.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/11.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDRentDetailTableView.h"
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h> //cell高度自适应
#import "DDRentDetailHeaderCell.h" 
#import "DDRentDetailInfoCell.h"
#import "DDRentDetailConfigCell.h"  
#import "DDRentDetailDecriCell.h"
#import "DDStretchableTableHeaderView.h"
#import "DDBrowserImageInfo.h"

#define StretchHeaderHeight 200

@interface DDRentDetailTableView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) DDStretchableTableHeaderView *stretchHeaderView;
@property (nonatomic, strong) DDRentoutDetailModel *rodetailModel;
@property (nonatomic, strong) UIImageView *bgImageView ;
@property (nonatomic, strong) UILabel *pageLabel;
@end

@implementation DDRentDetailTableView

static NSString *headerCell = @"headerCell";
static NSString *infoCell = @"infoCell";
static NSString *configCell = @"configCell";
static NSString *descriCell = @"descriCell";

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = YES;
        [self registerClass:[DDRentDetailHeaderCell class] forCellReuseIdentifier:headerCell];
        [self registerClass:[DDRentDetailInfoCell class] forCellReuseIdentifier:infoCell];
        [self registerClass:[DDRentDetailConfigCell class] forCellReuseIdentifier:configCell];
        [self registerClass:[DDRentDetailDecriCell class] forCellReuseIdentifier:descriCell];
        
        [self initStretchHeader];
    }
    return self;
}

- (void)initStretchHeader
{
    //背景
    _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, StretchHeaderHeight)];
    _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    _bgImageView.clipsToBounds = YES;
    _bgImageView.userInteractionEnabled = YES;
//    bgImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"placeHolder" ofType:@".jpg"]];
    
    
    //背景之上的内容
    UIView *contentView = [[UIView alloc] initWithFrame:_bgImageView.bounds];
    contentView.backgroundColor = [UIColor clearColor];
    
    [contentView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(watchPic:)]];
    
    UIButton *btnBack = [[UIButton alloc ] initWithFrame:CGRectMake(15, 30, 26, 26)];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"navi_back_black"] forState:UIControlStateNormal];
    [btnBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(btnBack_Click:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:btnBack];
    
    self.pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(contentView.frame.size.width - 90, contentView.frame.size.height - 30, 80, 20)];
    self.pageLabel.textColor = [UIColor whiteColor];
    self.pageLabel.font = [UIFont systemFontOfSize:15];
    self.pageLabel.textAlignment = NSTextAlignmentRight;
    [contentView addSubview:self.pageLabel];
    
    self.stretchHeaderView = [DDStretchableTableHeaderView new];
    [self.stretchHeaderView stretchHeaderForTableView:self withView:_bgImageView subViews:contentView];
    
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

//- - - -- ----

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat height = 0;
    NSString *cellId;
    if (indexPath.row == 0) {
        cellId = headerCell;
    }
   else if (indexPath.row == 1) {
        cellId = infoCell;
    }
   else if (indexPath.row == 2) {
        cellId = configCell;
    }
    else{
        cellId = descriCell;
    }
    height = [self fd_heightForCellWithIdentifier:cellId cacheByIndexPath:indexPath configuration:^(YLTableViewCell *cell) {
        [cell updateWithModel:self.rodetailModel];
    }];
    
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId;
    Class clazz;
    switch (indexPath.row) {
        case 0:
        {
            cellId = headerCell;
            clazz = [DDRentDetailHeaderCell class];
        }
            break;
        case 1:
        {
            cellId = infoCell;
            clazz = [DDRentDetailInfoCell class];
        }
            break;
        case 2:
        {
            cellId = configCell;
            clazz = [DDRentDetailConfigCell class];
        }
            break;
        case 3:
        {
            cellId = descriCell;
            clazz = [DDRentDetailDecriCell class];
        }
            break;
            
        default:
            break;
    }
    
    YLTableViewCell *cell =  [self createCellWithTableView:tableView indexPath:indexPath class:clazz cellId:cellId];
    [cell updateWithModel:self.rodetailModel];
    cell.sd_indexPath = indexPath;
    return cell;
}

- (YLTableViewCell *)createCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath class:(Class)clazz cellId:(NSString *)cellId
{
    YLTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    if (!cell) {
        cell = [[clazz alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)watchPic:(UITapGestureRecognizer *)tap{
    
    UIImageView* imageView = (UIImageView*)[tap view];
    NSInteger index = 0;
    NSArray *array = [self.rodetailModel.thumb mutableCopy];
    index = [array indexOfObject:imageView];
    
    DDBrowserImageInfo *browserImg = [[DDBrowserImageInfo alloc] init];
    browserImg.index = index;
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSString *str in array) {
        MWPhoto *mwphoto=[MWPhoto photoWithURL:[NSURL URLWithString:str]];
        mwphoto.caption=nil;
        [arr addObject:mwphoto];
    }
    browserImg.imageArr = arr;
    
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeLwqImageBrowser),
                             kYLModel:browserImg,
                             }];
}

- (void)updateWithModel: (DDRentoutDetailModel *)model
{
    if (model!=nil) {
        
        self.rodetailModel = model;
        NSArray *thumbArr = [self.rodetailModel.thumb mutableCopy];
        [_bgImageView sd_setImageWithURL:[NSURL URLWithString:thumbArr[0]] placeholderImage:[UIImage imageNamed:@"placeHolder.jpg"]];
        _pageLabel.text = [NSString stringWithFormat:@"1/%lu",(unsigned long)thumbArr.count];
        [self reloadData];
    }
}

-(void)btnBack_Click:(UIButton *)sender{
    
    [self allBlockWithDict:@{
                              kYLKeyForBlockType : @(kDDBlockTypeBackAction),
                              }];
}

@end



