//
//  DDEnterpriseEditTableView.m
//  WitCity
//
//  Created by 方冬冬 on 2017/7/27.
//  Copyright © 2017年 bjxybs. All rights reserved.
//

#import "DDEnterpriseEditTableView.h"
#import "DDRentwantHaveTxtFieldCell.h"
#import "DDRentwantWithoutTxtFieldCell.h"
#import "DDPublishImageCell.h"
#import "DDEditDataHeaderView.h"
#import "DDEditDataFooterView.h"
#import "DDDataModel.h"

#define kHeaderViewH   60
#define kFooterViewH   80
#define kRowH    50

@interface DDEnterpriseEditTableView()<UITableViewDelegate, UITableViewDataSource,DDPickerSingleDelegate,UIActionSheetDelegate,UITextFieldDelegate>

@property (strong, nonatomic) DDUploadImageHelper *curUploadImageHelper;
@property (nonatomic, strong) DDSelectModel *typeModel;
@property (nonatomic, strong) DDSelectModel *industryModel;
@property (nonatomic, assign) NSIndexPath   * index;//点击单元格序号
@property (nonatomic, strong) DDEditDataHeaderView *headView;
@property (nonatomic, strong) DDEditDataFooterView *footView;
@property (nonatomic, strong) DDDataModel *dModel;
@property (nonatomic, strong) NSMutableArray *tArr;
@property (nonatomic, strong) NSMutableArray *iArr;
@end

@implementation DDEnterpriseEditTableView

static NSString *cellTxt = @"fieldcell";
static NSString *cellNoTxt = @"noFieldcell";
static NSString *publishCellIdentifier = @"publishImagecell";

-(DDEditDataHeaderView *)headView
{
    if(!_headView) {
        _headView = [[DDEditDataHeaderView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, kHeaderViewH)];
    }
    return _headView;
}

-(DDEditDataFooterView *)footView
{
    if(!_footView) {
        _footView = [[DDEditDataFooterView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, kFooterViewH)];
    }
    WS(wself);
    _footView.allBlock = ^(NSDictionary *dict) {
        [wself callbackWithDict:dict];
    };
    return _footView;
}


-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        _curUploadImageHelper=[DDUploadImageHelper MPUploadImageForSend:NO];
        _txtArr = @[@"注册类型",@"行业类别",@"联系人姓名",@"联系方式",@"公司地址",@""];
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = YES;
        [self registerClass:[DDRentwantHaveTxtFieldCell class] forCellReuseIdentifier:cellTxt];
        [self registerClass:[DDRentwantWithoutTxtFieldCell class] forCellReuseIdentifier:cellNoTxt];
        [self registerClass:[DDPublishImageCell class] forCellReuseIdentifier:publishCellIdentifier];
        self.tableHeaderView = self.headView;
        self.tableFooterView = self.footView;
        
        self.dModel = [[DDDataModel alloc] init];
        self.typeModel = [[DDSelectModel alloc] init];
        self.industryModel = [[DDSelectModel alloc] init];
        [ND addObserver:self selector:@selector(changeText:) name:kChangeTextFieldTextNotification object:nil];

    }
    return self;
}

-(void)dealloc
{
    [ND removeObserver:self name:kChangeVersionNotification object:nil];
}

-(void)changeText:(NSNotification *)text{
    if ([text.userInfo[@"placeholder"] isEqualToString:@"（10字以内）"]) {
        self.dModel.contn = text.userInfo[@"text"];
    }
    if ([text.userInfo[@"placeholder"] isEqualToString:@"请输入联系方式"]) {
        self.dModel.contp = text.userInfo[@"text"];
    }
    if ([text.userInfo[@"placeholder"] isEqualToString:@"请输入公司地址"]) {
        self.dModel.address = text.userInfo[@"text"];
    }
    if ([text.userInfo[@"placeholder"] isEqualToString:@"填写公司简介"]) {
        self.dModel.des = text.userInfo[@"text"];
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  _txtArr.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row == 5) {
//        return 100;
//    }else{
//        return 45;
//    }¬
    CGFloat height = 0;
    if (indexPath.row == _txtArr.count ) {
        height =  [DDPublishImageCell cellHeightWithObj:self.curUploadImageHelper];
    }else{
        height = kRowH;
    }
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 1 ) {
        
        DDRentwantWithoutTxtFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:cellNoTxt forIndexPath:indexPath];
        if (!cell) {
            cell = [[DDRentwantWithoutTxtFieldCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellNoTxt];
        }
        if (indexPath.row == 0) {
            
            if (self.typeModel.name == nil) {
                cell.rightStr = self.dataModel.reg_type_name;
            }else{
                cell.rightStr = self.typeModel.name;
            }
        }
        if (indexPath.row == 1) {
            if (self.industryModel.name == nil) {
                cell.rightStr = self.dataModel.industry_name;
            }else{
                cell.rightStr = self.industryModel.name;
            }
        }
        
        cell.string = _txtArr[indexPath.row];
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        return cell;
        
    }else if (indexPath.row == _txtArr.count){
        
        DDPublishImageCell *cell = [tableView dequeueReusableCellWithIdentifier:publishCellIdentifier forIndexPath:indexPath];
        if (!cell) {
            cell = [[DDPublishImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:publishCellIdentifier];
        }
        __weak typeof(self)weakSelf = self;
        cell.backgroundColor = [UIColor whiteColor];
        cell.accessoryType    = UITableViewCellAccessoryNone;
        cell.curUploadImageHelper=self.curUploadImageHelper;
        cell.addPicturesBlock = ^(){
            [self showActionForPhoto];
        };
        cell.deleteImageBlock = ^(DDImageItemModel *toDelete){
            [weakSelf.curUploadImageHelper deleteAImage:toDelete];
            [weakSelf reloadData];
        };
        return cell;
        
    }else{
        DDRentwantHaveTxtFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTxt forIndexPath:indexPath];
        if (!cell) {
            cell = [[DDRentwantHaveTxtFieldCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTxt];
        }
        if (indexPath.row == 2||indexPath.row == 3||indexPath.row == 5){
            if (indexPath.row == 3) {
                cell.txtField.validateType = kDDTextFieldTypeTitle;
            }else{
                cell.txtField.validateType = kYLTextFieldTypeDefault;
            }
            cell.isHideLine = YES;
            cell.type = kDDCellTextFieldLineTypeNormal;
        }else{
            cell.isHideLine = YES;
            cell.txtField.keyboardType =  UIKeyboardTypeDefault;
        }
        cell.string = _txtArr[indexPath.row];
        NSArray *plArr = @[@"（10字以内）",@"请输入联系方式",@"请输入公司地址",@"填写公司简介"];
        cell.placeholerStr = plArr[indexPath.row - 2];
        
        if (self.dataModel == nil) {
            switch (indexPath.row) {
                case 2:
                {
                    cell.txtField.text = self.dModel.contn;
                }
                    break;
                case 3:
                {
                    cell.txtField.text = self.dModel.contp;
                }
                    break;
                case 4:
                {
                    cell.txtField.text = self.dModel.address;
                }
                    break;
                case 5:
                {
                    cell.txtField.text = self.dModel.des;
                }break;
                default:
                    break;
            }
        }else{
            switch (indexPath.row) {
                case 2:
                {
                    cell.txtField.text = self.dataModel.contn;
                }
                    break;
                case 3:
                {
                    cell.txtField.text = self.dataModel.contp;
                }
                    break;
                case 4:
                {
                    cell.txtField.text = self.dataModel.address;
                }
                    break;
                case 5:
                {
                    cell.txtField.text = self.dataModel.des;
                }break;
                default:
                    break;
            }
        }
        
    
        
        
        return cell;
    }
}

-(void)setTypeArr:(NSArray *)typeArr{
    _tArr = (NSMutableArray *)typeArr;
    [self reloadData];
}
-(void)setIndustryArr:(NSArray *)industryArr{
    _iArr = (NSMutableArray *)industryArr;
    [self reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 ||indexPath.row == 5) {
        
        DDRentwantHaveTxtFieldCell *custumCell= (DDRentwantHaveTxtFieldCell *)[tableView cellForRowAtIndexPath:indexPath];
        [custumCell.txtField becomeFirstResponder];
    }
    
    self.index = indexPath;
    if (indexPath.row == 0) {
        
//        NSMutableArray *arrayData = [NSMutableArray arrayWithObjects:@"电子商务",@"移动互联网",@"社交网络",@"医疗健康", nil];
        [self showPickerViewWithDataArray:_tArr title:@"请选择注册类型" titleUnit:nil];
    }
    if (indexPath.row == 1) {
        
//        NSMutableArray *arrayData = [NSMutableArray arrayWithObjects:@"电子商务",@"移动互联网",@"社交网络",@"医疗健康", nil];
        [self showPickerViewWithDataArray:_iArr title:@"请选择行业类别" titleUnit:nil];
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
- (void)pickerSingle:(DDPickerSingle *)pickerSingle selectedTitle:(DDSelectModel *)model
{
    if (self.index.row == 0) {
        self.typeModel = model;
    }
    if (self.index.row == 1) {
        self.industryModel = model;
    }
    [self reloadRowsAtIndexPaths:@[self.index] withRowAnimation:UITableViewRowAnimationFade];
}

//#pragma mark - DDPickerArea delegate
//- (void)pickerArea:(DDPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area
//{
//    NSString *text = [NSString stringWithFormat:@"%@ %@ %@", province, city, area];
//    self.areaStr = text;
//    [self reloadRowsAtIndexPaths:@[self.index] withRowAnimation:UITableViewRowAnimationFade];
//}
//弹出选择框
-(void)showActionForPhoto
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"拍照",@"从相册选择",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self];
}

#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)modalView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //拍照
    if (buttonIndex == 0) {
        [self allBlockWithDict:@{
                                 kYLKeyForBlockType : @(kDDBlockTypeCamera),
                                 }];
        
        //相册
    }else if (buttonIndex == 1){
        
        [self allBlockWithDict:@{
                                 kYLKeyForBlockType : @(kDDBlockTypeAlerm),
                                 kYLModel:self.curUploadImageHelper,
                                 }];
    }
}

#pragma mark - callback

-(void)callbackWithDict:(NSDictionary *)dict{
    

    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    switch (blockType) {
        case kDDBlockTypeDataSubmit:
        {
            
            
            if (_dataModel == nil) {
                self.dModel.reg_type = self.typeModel.id;
                self.dModel.industry = self.industryModel.id;
                self.dModel.thumb = self.curUploadImageHelper.selectedAssetURLs;
                
                [self allBlockWithDict:@{
                                         kYLKeyForBlockType : @(kDDBlockTypeDataSubmit),
                                         kYLModel:self.dModel,
                                         }];
            }else{
                self.dataModel.reg_type = self.typeModel.id;
                self.dataModel.industry = self.industryModel.id;
                self.dataModel.thumb = self.curUploadImageHelper.selectedAssetURLs;
                
                
                [self allBlockWithDict:@{
                                         kYLKeyForBlockType : @(kDDBlockTypeDataSubmit),
                                         kYLModel:self.dataModel,
                                         }];
            }
            

            
        }break;
            
        default:
            break;
    }
}

@end














