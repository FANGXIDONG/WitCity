//
//  DDPublishJobwantTableView.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/17.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDPublishJobwantTableView.h"
#import "DDRentwantHaveTxtFieldCell.h"
#import "DDRentwantWithoutTxtFieldCell.h"
#import "DDPickerDate.h"
#import "DDPublishLwqButtomView.h"   //底部视图
#import "DDJobSeekModel.h"
#import "DDSelectModel.h"

#define kRowH    50

@interface DDPublishJobwantTableView()<UITableViewDelegate, UITableViewDataSource,DDPickerDateDelegate,DDPickerSingleDelegate>
@property (nonatomic, strong) NSArray *txtArr;
@property (nonatomic, assign) NSIndexPath *index;
@property (nonatomic, copy) NSString *sexStr;       //性别
@property (nonatomic, copy) NSString *eduStr;       //最高学历
@property (nonatomic, copy) NSString *birthStr;     //出生日期
@property (nonatomic, copy) NSString *experienceStr;//工作经验
@property (nonatomic, copy) NSString *workTypeStr;  //工作类型
@property (nonatomic, copy) NSString *salaryStr;    //期望薪资
@property (nonatomic, strong) DDPublishLwqButtomView *bottomView;
@property (nonatomic, strong) DDJobSeekModel *jsModel;
@property (nonatomic, strong) NSMutableDictionary *textDic;//保存tetField会由于表格滚动导致cell初始化导致的数据丢失
@end

@implementation DDPublishJobwantTableView

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
        _txtArr = @[@"姓名：",@"性别",@"毕业院校：",@"最高学历",@"出生日期",@"联系方式：",@"联系邮箱：",@"工作经验",@"公司名称：",@"起始时间：",@"工作内容：",@"期望工作：",@"工作类型",@"期望薪资"];
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = YES;
        [self registerClass:[DDRentwantHaveTxtFieldCell class] forCellReuseIdentifier:cellTxt];
        [self registerClass:[DDRentwantWithoutTxtFieldCell class] forCellReuseIdentifier:cellNoTxt];
        self.tableFooterView= self.bottomView;
        //初始化
        self.jsModel  = [[DDJobSeekModel alloc] init];
        self.jsModel.name = @"";
        self.jsModel.college = @"";
        self.jsModel.phone = @"";
        self.jsModel.email = @"";
        self.jsModel.company = @"";
        self.jsModel.wtime = @"";
        self.jsModel.work = @"";
        self.jsModel.job = @"";
        [ND addObserver:self selector:@selector(changeText:) name:kChangeTextFieldTextNotification object:nil];
    }
    return self;
}

-(void)dealloc
{
    [ND removeObserver:self name:kChangeVersionNotification object:nil];
}

-(void)changeText:(NSNotification *)text{
  
    if ([text.userInfo[@"placeholder"] isEqualToString:@"请输入你的姓名"]) {
        self.jsModel.name = text.userInfo[@"text"];
    }
    if ([text.userInfo[@"placeholder"] isEqualToString:@"请输入毕业院校"]) {
        self.jsModel.college = text.userInfo[@"text"];
        
    }
    if ([text.userInfo[@"placeholder"] isEqualToString:@"请输入你的联系方式"]) {
        self.jsModel.phone = text.userInfo[@"text"];
       
    }
    if ([text.userInfo[@"placeholder"] isEqualToString:@"请输入你的联系邮箱"]) {
        self.jsModel.email = text.userInfo[@"text"];
        
    }
    if ([text.userInfo[@"placeholder"] isEqualToString:@"请输入公司名称"]) {
        self.jsModel.company = text.userInfo[@"text"];
        
    }
    if ([text.userInfo[@"placeholder"] isEqualToString:@"请输入工作时间"]) {
        self.jsModel.wtime = text.userInfo[@"text"];
        
    }
    if ([text.userInfo[@"placeholder"] isEqualToString:@"请简述工作内容"]) {
        self.jsModel.work = text.userInfo[@"text"];
        
    }
    if ([text.userInfo[@"placeholder"] isEqualToString:@"请输入你想从事的工作"]) {
        self.jsModel.job = text.userInfo[@"text"];
        
    }
    _textDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.jsModel.name,@"name",self.jsModel.college,@"college",self.jsModel.phone,@"phone",self.jsModel.email,@"email", self.jsModel.company,@"company",self.jsModel.wtime,@"wtime",self.jsModel.work,@"work",self.jsModel.job,@"job",nil];
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
    
    if (indexPath.row == 11) {
        height = kRowH + 40
        ;
    }else{
        height = kRowH;
    }
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1 || indexPath.row == 3 ||indexPath.row == 4 ||indexPath.row == 7 ||indexPath.row == 12 || indexPath.row == 13) {
        
        DDRentwantWithoutTxtFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:cellNoTxt forIndexPath:indexPath];
        if (cell==nil) {
            cell  = [[DDRentwantWithoutTxtFieldCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellNoTxt];
        }
        if (indexPath.row == 1) {
            cell.rightStr = self.sexStr;
        }
        if (indexPath.row == 3) {
            cell.rightStr = self.eduStr;
        }
        if (indexPath.row == 4) {
            cell.rightStr = self.birthStr;
        }
        if (indexPath.row == 7) {
            cell.rightStr = self.experienceStr;
        }
        if (indexPath.row == 12) {
            cell.rightStr = self.workTypeStr;
        }
        if (indexPath.row == 13) {
            cell.rightStr = self.salaryStr;
        }
        cell.string = _txtArr[indexPath.row];
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
        
    }else{
//        DDRentwantHaveTxtFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTxt forIndexPath:indexPath];
        DDRentwantHaveTxtFieldCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell==nil) {
            cell = [[DDRentwantHaveTxtFieldCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTxt];
        }
        if (indexPath.row == 8||indexPath.row == 11){
            if (indexPath.row == 11) {
                cell.type = kDDCellTextFieldLineTypeHigher;
                cell.headStr = @"添加更多工作经历";
            }else{
                cell.type = kDDCellTextFieldLineTypeNormal;
            }
        }else{
            cell.isHideLine = YES;
        }
        cell.string = _txtArr[indexPath.row];
        NSString *plStr;
        if (indexPath.row == 0) {
            plStr = @"请输入你的姓名";
            if (![_textDic[@"name"] isEqualToString:@""]) {
                  cell.txtField.text = _textDic[@"name"];
            }
          
        }else if (indexPath.row == 2){
            plStr = @"请输入毕业院校";
            if (![_textDic[@"college"] isEqualToString:@""]) {
                cell.txtField.text = _textDic[@"college"];
            }
        }
        else if (indexPath.row == 5){
            plStr = @"请输入你的联系方式";
            if (![_textDic[@"phone"] isEqualToString:@""]) {
                cell.txtField.text = _textDic[@"phone"];
            }
            cell.txtField.validateType = kYLTextFieldTypeUsername;
            cell.txtField.keyboardType = UIKeyboardTypeNumberPad;
        }
        else if (indexPath.row == 6){
            plStr = @"请输入你的联系邮箱";
            if (![_textDic[@"email"] isEqualToString:@""]) {
                cell.txtField.text = _textDic[@"email"];
            }
        }
        else if (indexPath.row == 8){
            plStr = @"请输入公司名称";
            if (![_textDic[@"company"] isEqualToString:@""]) {
                cell.txtField.text = _textDic[@"company"];
            }
        }
        else if (indexPath.row == 9){
            plStr = @"请输入工作时间";
            if (![_textDic[@"wtime"] isEqualToString:@""]) {
                cell.txtField.text = _textDic[@"wtime"];
            }
        }
        else if (indexPath.row == 10){
            plStr = @"请简述工作内容";
            if (![_textDic[@"work"] isEqualToString:@""]) {
                cell.txtField.text = _textDic[@"work"];
            }
        }
        else if (indexPath.row == 11){
            plStr = @"请输入你想从事的工作";
            if (![_textDic[@"job"] isEqualToString:@""]) {
                cell.txtField.text = _textDic[@"job"];
            }
        }
        cell.placeholerStr = plStr;
        
        return cell;
    }
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0 || indexPath.row == 2 ||indexPath.row == 5 ||indexPath.row == 6 || indexPath.row == 8 || indexPath.row == 9 ||indexPath.row == 10 ||indexPath.row == 11 ) {
        
        DDRentwantHaveTxtFieldCell *custumCell= (DDRentwantHaveTxtFieldCell *)[tableView cellForRowAtIndexPath:indexPath];
        [custumCell.txtField becomeFirstResponder];
    } else   if (indexPath.row == 4) {
        //出生日期
        DDPickerDate *pickerDate = [[DDPickerDate alloc ] init];
        [pickerDate setDelegate:self];
        [pickerDate show];
    }else{
        
        
        NSString *unitTitle;
        NSMutableArray *dataArr = [NSMutableArray array];
        
        self.index = indexPath;
        
        if (indexPath.row == 1) {
            //性别
            
            NSArray * selectArr = @[@"男",@"女"];
            for (int i = 0; i<selectArr.count; i++) {
                DDSelectModel *model = [[DDSelectModel alloc] init];
                model.name = selectArr[i];
                [dataArr addObject:model];
            }
            
            unitTitle = @"请选择性别";
        }
        
        if (indexPath.row == 3) {
            //最高学历1高中2中专3大专4本科5硕士6博士7博士后8学历不限
            
            NSArray * selectArr = @[@"男",@"女"];
            for (int i = 0; i<selectArr.count; i++) {
                DDSelectModel *model = [[DDSelectModel alloc] init];
                model.name = selectArr[i];
                [dataArr addObject:model];
            }
            unitTitle = @"请选择最高学历";
        }
        
        
        if (indexPath.row == 7) {
            //工作经验：1、无经验2、 1年以下3、1-3年4、3-5年5、5年以上;
            
            NSArray * selectArr = @[@"男",@"女"];
            for (int i = 0; i<selectArr.count; i++) {
                DDSelectModel *model = [[DDSelectModel alloc] init];
                model.name = selectArr[i];
                [dataArr addObject:model];
            }
            unitTitle = @"请选择工作经验";
            
        }
        
        if (indexPath.row == 12) {
            //工作类型
            
            NSArray * selectArr = @[@"男",@"女"];
            for (int i = 0; i<selectArr.count; i++) {
                DDSelectModel *model = [[DDSelectModel alloc] init];
                model.name = selectArr[i];
                [dataArr addObject:model];
            }
            unitTitle = @"请选择工作类型";
        }
        if (indexPath.row == 13) {
            //期望薪资(1.2K以下，2.2-3K,3.3-5K,4.5-8K,5.8-10K,6.10K以上，7.面议)
            
            NSArray * selectArr = @[@"男",@"女"];
            for (int i = 0; i<selectArr.count; i++) {
                DDSelectModel *model = [[DDSelectModel alloc] init];
                model.name = selectArr[i];
                [dataArr addObject:model];
            }
            unitTitle = @"请选择期望薪资";
        }else{
        }
        
        
         [self showPickerViewWithDataArray:dataArr title:unitTitle titleUnit:nil];
        
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

#pragma mark - DDPickerDelegate 


- (void)pickerSingle:(DDPickerSingle *)pickerSingle selectedTitle:(DDSelectModel *)selectedTitle
{
    if (self.index.row == 1) {
        self.sexStr =selectedTitle.name;
    }
    if (self.index.row== 3) {
        self.eduStr =selectedTitle.name;
    }
    if (self.index.row== 7) {
        self.experienceStr =selectedTitle.name;
    }
    if (self.index.row == 12) {
        self.workTypeStr =selectedTitle.name;
    }
    if (self.index.row == 13) {
        self.salaryStr =selectedTitle.name;
    }
    [self reloadRowsAtIndexPaths:@[self.index] withRowAnimation:UITableViewRowAnimationFade];
}

-(void)pickerDate:(DDPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day{
    
    self.birthStr = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)year,(long)month,(long)day];
    [self reloadRowsAtIndexPaths:@[self.index] withRowAnimation:UITableViewRowAnimationFade];
    
}


#pragma mark - callback
-(void)callbackWithDict:(NSDictionary *)dict
{
    self.jsModel.gender = self.sexStr;
    self.jsModel.edu = self.eduStr;
    self.jsModel.birth = self.birthStr;
    self.jsModel.exep = self.experienceStr;
//    self.jsModel.history =
    self.jsModel.workType = self.workTypeStr;
    self.jsModel.salary = self.salaryStr;
    
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];

    switch (blockType) {
        case kDDBlockTypePublishAction:
        {

            [self allBlockWithDict:@{
                                     kYLKeyForBlockType : @(kDDBlockTypePublishAction),
                                     kYLModel:self.jsModel,
                                     }];
        }break;
        default:
            break;
    }
}


@end






