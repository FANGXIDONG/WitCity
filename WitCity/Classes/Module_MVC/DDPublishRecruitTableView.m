//
//  DDPublishRecruitTableView.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/17.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDPublishRecruitTableView.h"
#import "DDRentwantHaveTxtFieldCell.h"
#import "DDRentwantWithoutTxtFieldCell.h"
#import "DDPublishWithSelectedItemCell.h"  //
#import "DDPublishLwqButtomView.h"   //底部视图
#import "DDRadioButtonGroupIdModel.h"

#define kRowH    50

@interface DDPublishRecruitTableView()<UITableViewDelegate, UITableViewDataSource,DDPickerSingleDelegate>
@property (nonatomic, strong) NSArray *txtArr;
@property (nonatomic, assign) NSIndexPath* index;
@property (nonatomic, copy) NSString *salaryStr;
@property (nonatomic, copy) NSString *experienceStr;
@property (nonatomic, copy) NSString *eduStr;
@property (nonatomic, strong) DDPublishLwqButtomView *bottomView;
@property (nonatomic, strong) NSMutableDictionary *textDic;//保存tetField会由于表格滚动导致cell初始化导致的数据丢失
@end

@implementation DDPublishRecruitTableView

static NSString *cellTxt = @"fieldCell";
static NSString *cellNoTxt = @"noFieldCell";
static NSString *cellSelectedItem = @"cellSelectedItem";


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
-(void)setUpdateRecruitDataWithModel:(DDRecruitModel *)model
{
    _recruitModel = model;
    
    
////    NSMutableArray *dataArr = [NSMutableArray array];
//    NSDictionary *dic = @{_recruitModel.business:@"business",
//                          _recruitModel.position:@"position",
//                          _recruitModel.attact:@"attact",
//                          _recruitModel.workrequire:@"workrequire",
//                          _recruitModel.address:@"address",
//                          _recruitModel.industry:@"industry",
//                          _recruitModel.quality:@"quality",
//                          _recruitModel.size:@"size",
//                          _recruitModel.summary:@"summary",
//                          _recruitModel.person:@"person",
//                          _recruitModel.phone:@"phone"};
    
    _textDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                _recruitModel.business,@"business",
                _recruitModel.position,@"position",
                _recruitModel.attact,@"attact",
                _recruitModel.workrequire,@"workrequire",
                _recruitModel.address,@"address",
                _recruitModel.industry,@"industry",
                _recruitModel.quality,@"quality",
                _recruitModel.size,@"size",
                _recruitModel.summary,@"summary",
                _recruitModel.person,@"person",
                _recruitModel.phone,@"phone",
                nil];
    
    self.salaryStr = [DDUtils getSalaryFromStatusWithStatus:_recruitModel.salary];
    self.experienceStr = [DDUtils getExperienceFromStatusWithStatus:_recruitModel.exep];
    self.eduStr = [DDUtils getEduFromStatusWithStatus:_recruitModel.edu];
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.txtArr = @[@"职位：",@"薪资",@"经验",@"学历",@"类型",@"职位诱惑：",@"职位描述：",@"公司地址：",@"名称：",@"行业：",@"性质：",@"规模：",@"简介：",@"联系人：",@"电话："];
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = YES;
        [self registerClass:[DDRentwantHaveTxtFieldCell class] forCellReuseIdentifier:cellTxt];
        [self registerClass:[DDRentwantWithoutTxtFieldCell class] forCellReuseIdentifier:cellNoTxt];
        [self registerClass:[DDPublishWithSelectedItemCell class] forCellReuseIdentifier:cellSelectedItem];
        self.tableFooterView = self.bottomView;
//        if ([self.flag isEqualToString:@"招聘更新"]) {
//            
//        }else{
            //初始化
            self.recruitModel = [[DDRecruitModel alloc] init];
            self.recruitModel.position = @"";
            self.recruitModel.attact = @"";
            self.recruitModel.workrequire = @"";
            self.recruitModel.address = @"";
            self.recruitModel.business = @"";
            self.recruitModel.industry = @"";
            self.recruitModel.quality = @"";
            self.recruitModel.size = @"";
            self.recruitModel.summary = @"";
            self.recruitModel.person = @"";
            self.recruitModel.phone = @"";
//        }
        

      
        [ND addObserver:self selector:@selector(changeText:) name:kChangeTextFieldTextNotification object:nil];
    }
    return self;
}

-(void)dealloc
{
    [ND removeObserver:self name:kChangeVersionNotification object:nil];
}

-(void)changeText:(NSNotification *)text{
    
    if ([text.userInfo[@"placeholder"] isEqualToString:@"20字以内"]) {
        self.recruitModel.position = text.userInfo[@"text"];
    }
    if ([text.userInfo[@"placeholder"] isEqualToString:@"请填写职位诱惑"]) {
        self.recruitModel.attact = text.userInfo[@"text"];
    }
    if ([text.userInfo[@"placeholder"] isEqualToString:@"请填写职位描述"]) {
        self.recruitModel.workrequire = text.userInfo[@"text"];
    }
    if ([text.userInfo[@"placeholder"] isEqualToString:@"请填写公司地址"]) {
        self.recruitModel.address = text.userInfo[@"text"];
    }
    if ([text.userInfo[@"placeholder"] isEqualToString:@"请填写公司名称"]) {
        self.recruitModel.business = text.userInfo[@"text"];
    }
    if ([text.userInfo[@"placeholder"] isEqualToString:@"请填写公司行业"]) {
        self.recruitModel.industry = text.userInfo[@"text"];
    }
    if ([text.userInfo[@"placeholder"] isEqualToString:@"请填写公司性质"]) {
        self.recruitModel.quality = text.userInfo[@"text"];
    }
    if ([text.userInfo[@"placeholder"] isEqualToString:@"请填写公司规模"]) {
        self.recruitModel.size = text.userInfo[@"text"];
    }
    if ([text.userInfo[@"placeholder"] isEqualToString:@"请填写简介"]) {
        self.recruitModel.summary = text.userInfo[@"text"];
    }
    if ([text.userInfo[@"placeholder"] isEqualToString:@"请输入联系人姓名"]) {
        self.recruitModel.person = text.userInfo[@"text"];
    }
    if ([text.userInfo[@"placeholder"] isEqualToString:@"请输入联系人电话"]) {
        self.recruitModel.phone = text.userInfo[@"text"];
    }

    _textDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                self.recruitModel.position,@"position",
                self.recruitModel.attact,@"attact",
                self.recruitModel.workrequire,@"workrequire",
                self.recruitModel.address,@"address",
                self.recruitModel.business,@"business",
                self.recruitModel.industry,@"industry",
                self.recruitModel.quality,@"quality",
                self.recruitModel.size,@"size",
                self.recruitModel.summary,@"summary",
                self.recruitModel.person,@"person",
                self.recruitModel.phone,@"phone",
                nil];
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
    
    if (indexPath.row == 8) {
        height = kRowH + 40;
        
    }else{
        height = kRowH;
    }
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1 ||indexPath.row == 2 ||indexPath.row == 3 || indexPath.row == 4) {
        
        if (indexPath.row == 1 ||indexPath.row == 2 ||indexPath.row == 3) {
            DDRentwantWithoutTxtFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:cellNoTxt forIndexPath:indexPath];
//             DDRentwantWithoutTxtFieldCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            if (!cell) {
                cell = [[DDRentwantWithoutTxtFieldCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellNoTxt];
            }
            if (indexPath.row == 1) {
                cell.rightStr = self.salaryStr;
            }
            if (indexPath.row == 2) {
                cell.rightStr = self.experienceStr;
            }
            if (indexPath.row == 3) {
                cell.rightStr = self.eduStr;
            }
            
            cell.string = _txtArr[indexPath.row];
            cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
            
            return cell;
        } else{
//            DDPublishWithSelectedItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellSelectedItem forIndexPath:indexPath];
             DDPublishWithSelectedItemCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            if (!cell) {
                cell = [[DDPublishWithSelectedItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellSelectedItem];
            }
            WS(wself);
            cell.allBlock = ^(NSDictionary *dict) {
                [wself callbackWithDict:dict];
            };
            cell.string = _txtArr[indexPath.row];
            cell.itemArr = @[@"全职",@"兼职"];
            cell.isHideLine = NO;
            
            return cell;
        }
   
    }

    else{
        
        //!!取消单元格的复用，防止数据重叠，会占用一些空间
    
//        DDRentwantHaveTxtFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTxt forIndexPath:indexPath];
       DDRentwantHaveTxtFieldCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            cell = [[DDRentwantHaveTxtFieldCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTxt];
        }
        cell.string = _txtArr[indexPath.row];
    
        NSArray *plArr = @[@"20字以内",@"",@"",@"",@"",@"请填写职位诱惑",@"请填写职位描述",@"请填写公司地址",@"请填写公司名称",@"请填写公司行业",@"请填写公司性质",@"请填写公司规模",@"请填写简介",@"请输入联系人姓名",@"请输入联系人电话"];
        cell.placeholerStr = plArr[indexPath.row];
        
        NSArray *txtTextArr = @[@"position",@"",@"",@"",@"",@"attact",@"workrequire",@"address",@"business",@"industry",@"quality",@"size",@"summary",@"person",@"phone"];

        cell.txtField.text = _textDic[txtTextArr[indexPath.row]];
        if (indexPath.row == 0) {
            cell.txtField.validateType = kDDTextFieldTypePosition;
        }
        
        if (indexPath.row == 8) {
            cell.type = kDDCellTextFieldLineTypeHigher;
            cell.headStr = @"公司简介";
        }
        if (indexPath.row == 13) {
            cell.type = kDDCellTextFieldLineTypeNormal;
            cell.isHideLine = NO;
        }
        if (indexPath.row == 14) {
            cell.txtField.validateType =kYLTextFieldTypeUsername;
            cell.txtField.keyboardType = UIKeyboardTypePhonePad;
        }


        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    self.index  = indexPath;
    if (indexPath.row == 1) {
        //期望薪资(1.2K以下，2.2-3K,3.3-5K,4.5-8K,5.8-10K,6.10K以上，7.面议)

        NSMutableArray *dataArr = [NSMutableArray array];
        NSArray * selectArr = @[@"2k以下",@"2k-3k",@"3k-5k",@"5k-8k",@"8k-10k",@"10k以上",@"面议"];
        for (int i = 0; i<selectArr.count; i++) {
            DDSelectModel *model = [[DDSelectModel alloc] init];
            model.name = selectArr[i];
            [dataArr addObject:model];
        }
        [self showPickerViewWithDataArray:dataArr title:@"请选择薪资" titleUnit:@"元"];
    }
   else if (indexPath.row == 2) {
        //工作经验：1、无经验2、 1年以下3、1-3年4、3-5年5、5年以上;

       NSMutableArray *dataArr = [NSMutableArray array];
       NSArray * selectArr = @[@"无经验",@"1年以下",@"1-3年",@"3-5年",@"5年以上"];
       for (int i = 0; i<selectArr.count; i++) {
           DDSelectModel *model = [[DDSelectModel alloc] init];
           model.name = selectArr[i];
           [dataArr addObject:model];
       }
        [self showPickerViewWithDataArray:dataArr title:@"请选择工作经验" titleUnit:nil];
    }
   else if (indexPath.row == 3) {

       NSMutableArray *dataArr = [NSMutableArray array];
       NSArray * selectArr = @[@"高中",@"中专",@"大专",@"本科",@"硕士",@"博士",@"博士后",@"学历不限"];
       for (int i = 0; i<selectArr.count; i++) {
           DDSelectModel *model = [[DDSelectModel alloc] init];
           model.name = selectArr[i];
           [dataArr addObject:model];
       }
        [self showPickerViewWithDataArray:dataArr title:@"请选择最高学历" titleUnit:nil];
    }
  else  if (indexPath.row == 4) {
        
    }else{
        
        DDRentwantHaveTxtFieldCell *custumCell= (DDRentwantHaveTxtFieldCell *)[tableView cellForRowAtIndexPath:indexPath];
        [custumCell.txtField becomeFirstResponder];
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
- (void)pickerSingle:(DDPickerSingle *)pickerSingle selectedTitle:(DDSelectModel *)selectedTitle
{
    if (self.index.row == 1) {
        self.salaryStr =selectedTitle.name;
    }
    if (self.index.row == 2) {
        self.experienceStr =selectedTitle.name;
    }
    if (self.index.row == 3) {
        self.eduStr =selectedTitle.name;
    }
    [self reloadRowsAtIndexPaths:@[self.index] withRowAnimation:UITableViewRowAnimationFade];
}


#pragma mark - callback
-(void)callbackWithDict:(NSDictionary *)dict
{
    self.recruitModel.salary = self.salaryStr;
    self.recruitModel.exep = self.experienceStr;
    self.recruitModel.edu = self.eduStr;
    
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];

    switch (blockType) {
        case kDDBlockTypePublishAction:
        {

            [self allBlockWithDict:@{
                                     kYLKeyForBlockType : @(kDDBlockTypePublishAction),
                                     kYLModel:self.recruitModel,
                                     }];
        }break;
        case kDDBlockTypeRadioButtonSelectedItem:
        {
            DDRadioButtonGroupIdModel *model = dict[kYLModel];
            self.recruitModel.worktype  = model.text;
        }
            break;
        default:
            break;
    }
}



@end




