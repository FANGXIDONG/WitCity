//
//  DDPublishRentoutTableView.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/17.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDPublishRentoutTableView.h"
#import "DDRentwantHaveTxtFieldCell.h"
#import "DDPublishWithSelectedItemCell.h"
#import "DDPublishImageCell.h"
#import "DDPublishLwqButtomView.h"   //底部视图
#import "DDRentoutDetailModel.h"
#import "DDRadioButtonGroupIdModel.h"

#define kRowH    50

@interface DDPublishRentoutTableView()<UITableViewDelegate, UITableViewDataSource,UIActionSheetDelegate>

@property (strong, nonatomic) DDUploadImageHelper *curUploadImageHelper;
@property (nonatomic, strong) DDPublishLwqButtomView *bottomView;
@property (nonatomic, strong) DDRentoutDetailModel *roModel;
@property (nonatomic, strong) NSMutableDictionary *textDic;//保存tetField会由于表格滚动导致cell初始化导致的数据丢失
@end

@implementation DDPublishRentoutTableView

static NSString *cellTxt = @"fieldCell";
static NSString *cellSelectedTxt = @"noFieldCell";
static NSString *publishCellIdentifier = @"publishImageCell";

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
        
        //初始化
        _curUploadImageHelper=[DDUploadImageHelper MPUploadImageForSend:NO];
        _txtArr = @[@"标题：",@"价格：",@"地址：",@"类型",@"来源",@"厅室",@"楼层：",@"房屋配置：",@"房屋描述：",@"联系人：",@"电话："];
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = YES;
        [self registerClass:[DDRentwantHaveTxtFieldCell class] forCellReuseIdentifier:cellTxt];
        [self registerClass:[DDPublishWithSelectedItemCell class] forCellReuseIdentifier:cellSelectedTxt];
        [self registerClass:[DDPublishImageCell class] forCellReuseIdentifier:publishCellIdentifier];
        self.tableFooterView = self.bottomView;
//        self.contentSize = CGSizeMake(WINDOW_WIDTH, _txtArr.count*kRowH + kBottomHeight);
        //初始化
        self.roModel = [[DDRentoutDetailModel alloc] init];
        self.roModel.title = @"";
        self.roModel.price = @"";
        self.roModel.address = @"";
        self.roModel.floor = @"";
        self.roModel.config = @"";
        self.roModel.summary = @"";
        self.roModel.person = @"";
        self.roModel.phone = @"";
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
        self.roModel.title = text.userInfo[@"text"];
    }
    if ([text.userInfo[@"placeholder"] isEqualToString:@"请填写出租价格"]) {
        self.roModel.price = text.userInfo[@"text"];
    }
    if ([text.userInfo[@"placeholder"] isEqualToString:@"请填写详细地址"]) {
        self.roModel.address = text.userInfo[@"text"];
    }
    if ([text.userInfo[@"placeholder"] isEqualToString:@"请填写房屋所在楼层"]) {
        self.roModel.floor = text.userInfo[@"text"];
    }
    if ([text.userInfo[@"placeholder"] isEqualToString:@"最多十项"]) {
        self.roModel.config = text.userInfo[@"text"];
    }
    if ([text.userInfo[@"placeholder"] isEqualToString:@"从房屋介绍，交通周边方面"]) {
        self.roModel.summary = text.userInfo[@"text"];
    }
    if ([text.userInfo[@"placeholder"] isEqualToString:@"请输入联系人姓名"]) {
        self.roModel.person = text.userInfo[@"text"];
    }
    if ([text.userInfo[@"placeholder"] isEqualToString:@"请输入联系人电话"]) {
        self.roModel.phone = text.userInfo[@"text"];
    }
    _textDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                self.roModel.title,@"title",
                self.roModel.price,@"price",
                self.roModel.address,@"address",
                self.roModel.floor,@"floor",
                self.roModel.config,@"config",
                self.roModel.summary,@"summary",
                self.roModel.person,@"person",
                self.roModel.phone,@"phone",
                nil];
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
    if (indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5) {
        
        DDPublishWithSelectedItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellSelectedTxt forIndexPath:indexPath];
        if (!cell) {
            cell = [[DDPublishWithSelectedItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellSelectedTxt];
        }
        WS(wself);
        cell.allBlock = ^(NSDictionary *dict) {
            [wself callbackWithDict:dict];
        };
        cell.string = _txtArr[indexPath.row];
        if (indexPath.row == 3) {
//            cell.groupId = @"类型";
            cell.itemArr = @[@"整租",@"合租"];
        }else if (indexPath.row == 4){
//            cell.groupId = @"来源";
            cell.itemArr = @[@"中介",@"房东"];
            cell.isHideLine = YES;
            
        }else if (indexPath.row == 5){
//            cell.groupId = @"厅室";
            cell.itemArr = @[@"1",@"2",@"3",@"4以上"];
            cell.isHideLine = YES;
        }
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

    }
    
    else{
        
//        DDRentwantHaveTxtFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTxt forIndexPath:indexPath];
        DDRentwantHaveTxtFieldCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[DDRentwantHaveTxtFieldCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTxt];
        }
        cell.string = _txtArr[indexPath.row];
        if (indexPath.row == 0) {
            cell.txtField.validateType = kDDTextFieldTypePosition;
        }else if (indexPath.row == 1){
            cell.txtField.keyboardType = UIKeyboardTypeNumberPad;
        }
      else  if (indexPath.row == 7){
            cell.type = kDDCellTextFieldLineTypeNormal;
        }
      else  if (indexPath.row == 10){
          cell.txtField.keyboardType = UIKeyboardTypePhonePad;
          cell.txtField.validateType = kYLTextFieldTypeUsername;
      }
      else{
            cell.isHideLine = YES;
        }
        NSArray *plArr = @[@"20字以内",@"请填写出租价格",@"请填写详细地址",@"",@"",@"",@"请填写房屋所在楼层",@"最多十项",@"从房屋介绍，交通周边方面",@"请输入联系人姓名",@"请输入联系人电话"];
        cell.placeholerStr = plArr[indexPath.row];
        
        NSArray *txtTextArr = @[@"title",@"price",@"address",@"",@"",@"",@"floor",@"config",@"summary",@"person",@"phone"];
        cell.txtField.text = _textDic[txtTextArr[indexPath.row]];

        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    if (indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5 || indexPath.row == _txtArr.count) {
        
    }else{
        
        DDRentwantHaveTxtFieldCell *custumCell= (DDRentwantHaveTxtFieldCell *)[tableView cellForRowAtIndexPath:indexPath];
        [custumCell.txtField becomeFirstResponder];
    }
}

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
-(void)callbackWithDict:(NSDictionary *)dict
{
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];

    switch (blockType) {
        case kDDBlockTypePublishAction:
        {
            [self allBlockWithDict:@{
                                     kYLKeyForBlockType : @(kDDBlockTypePublishAction),
                                     kYLModel:self.roModel,
                                     }];
        }break;
        case kDDBlockTypeRadioButtonSelectedItem:
        {
            DDRadioButtonGroupIdModel *model = dict[kYLModel];
            NSString *typeString = @"整租";
            NSString *roomString = @"1";
            self.roModel.source = @"中介";
            //类型
            if ([model.groupId isEqualToString:@"top"]) {
                if (![model.text isEqualToString:@""]) {
                    typeString = model.text;
                }
            }
            //来源
            if ([model.groupId isEqualToString:@"middle"]) {
                if (![model.text isEqualToString:@""]) {
                   self.roModel.source = model.text;
                }
                
            }
            //厅室
            if ([model.groupId isEqualToString:@"bottom"]) {
                if (![model.text isEqualToString:@""]) {
                    roomString = model.text;
                }
                
            }
            self.roModel.type = [NSString stringWithFormat:@"%@%@",roomString,typeString];
        }
            break;
        default:
            break;
    }
}



@end
