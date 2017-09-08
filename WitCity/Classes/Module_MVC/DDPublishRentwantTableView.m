//
//  DDPublishRentwantTableView.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/12.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDPublishRentwantTableView.h"
#import "DDRentwantHaveTxtFieldCell.h"
#import "DDRentwantWithoutTxtFieldCell.h"
#import "DDPickerArea.h"
#import "DDPublishLwqButtomView.h"   //底部视图
#import "DDRentWantModel.h"

@interface DDPublishRentwantTableView()<UITableViewDelegate, UITableViewDataSource,DDPickerAreaDelegate,DDPickerSingleDelegate,UITextFieldDelegate>
@property (nonatomic, strong) NSArray *txtArr;      //单元格左边标题数组
@property (nonatomic, copy) NSString *areaStr;      //区域
@property (nonatomic, copy) NSString *moneyStr;     //租金
@property (nonatomic, copy) NSString *expectTypeStr;//期望类型
@property (nonatomic, copy) NSString *payTypeStr;   //付款方式
@property (nonatomic, assign) NSIndexPath* index;      //点击单元格序号
@property (nonatomic, strong) DDPublishLwqButtomView *bottomView;  //底部视图
@property (nonatomic, strong) DDRentWantModel *rwModel;
@end

@implementation DDPublishRentwantTableView

static NSString *cellTxt = @"fieldCell";
static NSString *cellNoTxt = @"noFieldCell";

-(DDPublishLwqButtomView *)bottomView
{
    if(!_bottomView) {
        _bottomView = [[DDPublishLwqButtomView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, kBottomHeight)];
    }
    WS(wself);
    _bottomView.allBlock = ^(NSDictionary *dict) {
        [wself callbackWithDict:dict];
    };
    return _bottomView;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        _txtArr = @[@"区域",@"租金",@"期望类型",@"标题",@"房源描述",@"联系人：",@"联系电话："];
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = YES;
        [self registerClass:[DDRentwantHaveTxtFieldCell class] forCellReuseIdentifier:cellTxt];
        [self registerClass:[DDRentwantWithoutTxtFieldCell class] forCellReuseIdentifier:cellNoTxt];
        self.tableFooterView = self.bottomView;
        self.rwModel = [[DDRentWantModel alloc] init];
        [ND addObserver:self selector:@selector(changeText:) name:kChangeTextFieldTextNotification object:nil];
    }
    return self;
}

-(void)dealloc
{
    [ND removeObserver:self name:kChangeVersionNotification object:nil];
}

-(void)changeText:(NSNotification *)text{
    if ([text.userInfo[@"placeholder"] isEqualToString:@" 30字以内"]) {
        self.rwModel.title = text.userInfo[@"text"];
    }
    if ([text.userInfo[@"placeholder"] isEqualToString:@" 期望房租，交通路线，周边配置"]) {
         self.rwModel.summary = text.userInfo[@"text"];
    }
    if ([text.userInfo[@"placeholder"] isEqualToString:@" 请输入联系人姓名"]) {
         self.rwModel.person = text.userInfo[@"text"];
    }
    if ([text.userInfo[@"placeholder"] isEqualToString:@" 请输入联系人电话"]) {
         self.rwModel.phone = text.userInfo[@"text"];
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  _txtArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    
    if (indexPath.row == 3||indexPath.row == 5) {
        height = 50
        ;
    }else{
        height = 45;
    }
     return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 1 ||indexPath.row == 2 ) {
        
        DDRentwantWithoutTxtFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:cellNoTxt forIndexPath:indexPath];
        if (!cell) {
            cell = [[DDRentwantWithoutTxtFieldCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellNoTxt];
        }
        if (indexPath.row == 0) {
            cell.rightStr = self.areaStr;
        }
        if (indexPath.row == 1) {
            cell.rightStr = self.moneyStr;
        }
        if (indexPath.row == 2) {
            cell.rightStr = self.expectTypeStr;
        }

        cell.string = _txtArr[indexPath.row];
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        return cell;
        
    }else{
        DDRentwantHaveTxtFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTxt forIndexPath:indexPath];
        if (!cell) {
            cell = [[DDRentwantHaveTxtFieldCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTxt];
        }
        if (indexPath.row == 3||indexPath.row == 5){
            if (indexPath.row == 3) {
                cell.txtField.validateType = kDDTextFieldTypeTitle;
            }else{
               cell.txtField.validateType = kYLTextFieldTypeDefault;
            }
            cell.isHideLine = NO;
            cell.type = kDDCellTextFieldLineTypeNormal;
        }else{
            cell.isHideLine = YES;
            if (indexPath.row == 6) {
                cell.txtField.keyboardType = UIKeyboardTypeNumberPad;
                cell.txtField.validateType = kYLTextFieldTypeUsername;
            }else{
               cell.txtField.keyboardType =  UIKeyboardTypeDefault;
            }
        }
       cell.string = _txtArr[indexPath.row];
        NSArray *plArr = @[@" 30字以内",@" 期望房租，交通路线，周边配置",@" 请输入联系人姓名",@" 请输入联系人电话"];
        cell.placeholerStr = plArr[indexPath.row - 3];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 3 || indexPath.row == 4 ||indexPath.row == 5 ||indexPath.row == 6 ) {

        DDRentwantHaveTxtFieldCell *custumCell= (DDRentwantHaveTxtFieldCell *)[tableView cellForRowAtIndexPath:indexPath];
        [custumCell.txtField becomeFirstResponder];
    }
    
    self.index = indexPath;
    if (indexPath.row == 0) {
    
        DDPickerArea *pickerArea = [[DDPickerArea alloc]init];
        [pickerArea setDelegate:self];
        [pickerArea setContentMode:DDPickerContentModeBottom];
        [pickerArea show];
    }
    if (indexPath.row == 1) {
       
        NSMutableArray *dataArr = [NSMutableArray array];
        NSArray * selectArr = @[@"1k以下",@"1k-1.5k",@"1.5k-2k",@"2k-3k",@"3k-5k",@"5k-8k",@"8k以上"];
        for (int i = 0; i<selectArr.count; i++) {
            DDSelectModel *model = [[DDSelectModel alloc] init];
            model.name = selectArr[i];
            [dataArr addObject:model];
        }
        [self showPickerViewWithDataArray:dataArr title:@"请选择租金" titleUnit:@"元"];
    }
    if (indexPath.row == 2) {

        NSMutableArray *dataArr = [NSMutableArray array];
        NSArray * selectArr = @[@"主卧-合租",@"次卧-合租",@"一室-整租",@"两室-整租",@"三室-整租",@"四室-整租",@"四室以上-整租"];
        for (int i = 0; i<selectArr.count; i++) {
            DDSelectModel *model = [[DDSelectModel alloc] init];
            model.name = selectArr[i];
            [dataArr addObject:model];
        }
       [self showPickerViewWithDataArray:dataArr title:@"请选择期望类型" titleUnit:nil];
    }
}
-(void)showPickerViewWithDataArray:(NSMutableArray *)arrayData title:(NSString *)title titleUnit:(NSString *)titleUnit{
    DDPickerSingle *pickerSingle = [[DDPickerSingle alloc]init];
    [pickerSingle setArrayData:arrayData];
    [pickerSingle setTitle:title];
    [pickerSingle setTitleUnit:titleUnit];
    [pickerSingle setContentMode:DDPickerContentModeBottom];
    [pickerSingle setDelegate:self];
    [pickerSingle show];
}

#pragma mark - DDPickerSingle delegate
- (void)pickerSingle:(DDPickerSingle *)pickerSingle selectedTitle:(DDSelectModel *)selectedTitle
{
    if (self.index.row == 1) {
        self.moneyStr =selectedTitle.name;
    }
    if (self.index.row == 2) {
        self.expectTypeStr =selectedTitle.name;
    }
    [self reloadRowsAtIndexPaths:@[self.index] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - DDPickerArea delegate 
- (void)pickerArea:(DDPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area
{
    NSString *text = [NSString stringWithFormat:@"%@ %@ %@", province, city, area];
    self.areaStr = text;
    [self reloadRowsAtIndexPaths:@[self.index] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - callback

-(void)callbackWithDict:(NSDictionary *)dict{
    
    self.rwModel.area = self.areaStr;
    self.rwModel.price = self.moneyStr;
    self.rwModel.type = self.expectTypeStr;

    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    switch (blockType) {
        case kDDBlockTypePublishAction:
        {
            
        [self allBlockWithDict:@{
                                 kYLKeyForBlockType : @(kDDBlockTypePublishAction),
                                 kYLModel:self.rwModel,
                                 }];
            
        }break;
            
        default:
            break;
    }
}


@end





