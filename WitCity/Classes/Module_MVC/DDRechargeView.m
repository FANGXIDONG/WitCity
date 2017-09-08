
//
//  DDRechargeView.m
//  WitCity
//
//  Created by 方冬冬 on 2016/11/29.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDRechargeView.h"
#import "DDRequestModel.h"
//访问通讯录
/// iOS 9前的框架
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
/// iOS 9的新框架
#import <ContactsUI/ContactsUI.h>

#define Is_up_Ios_9             ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0)

@interface DDRechargeView()<ABPeoplePickerNavigationControllerDelegate,CNContactPickerDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UIView      *bgView;      //整体背景
@property (nonatomic, strong) UIButton    *contactBtn;  //通讯录
@property (nonatomic, strong) UIImageView *contactView;
@property (nonatomic, strong) UILabel     *contactLabel;
@property (nonatomic, strong) UILabel     *messageLabel;
@property (nonatomic, strong) UIButton    *payBtn;       //支付按钮
@property (nonatomic, strong) UIButton    *tmpBtn;
@property (nonatomic, strong) DDRequestModel *rModel;
@end

@implementation DDRechargeView

-(void)addViews     
{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.phoneTxt];
    [self.bgView addSubview:self.contactBtn];
    [self.contactBtn addSubview:self.contactView];
    [self.contactBtn addSubview:self.contactLabel];
    [self.bgView addSubview:self.messageLabel];
    [self addSubview:self.payBtn];
}

-(void)layout
{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(self);
        make.height.mas_equalTo(300);
//        make.edges.mas_equalTo(self);
    }];
    [self.phoneTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(-110);
        make.height.mas_equalTo(50);
    }];
    [self.contactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.phoneTxt.mas_right);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(self.phoneTxt);
        make.top.mas_equalTo(self.phoneTxt);
    }];
    [self.contactView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(20);
        make.centerX.mas_equalTo(self.contactBtn);
        make.top.mas_equalTo(5);
    }];
    [self.contactLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contactView.mas_bottom).offset(5);
        make.centerX.mas_equalTo(self.contactView);
    }];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneTxt.mas_bottom).offset(5);
        make.left.mas_equalTo(self.phoneTxt);
    }];

    __block UIButton *lastBtn = nil;
    int intes = 10;
    int num = 3;
    
    NSArray *priceArr = @[@"20元",@"30元",@"50元",@"100元",@"300元",@"500元"];
    
    for (int i= 0 ; i<6; i++) {
        
        UIButton *priceBtn = [UIButton new];
        [self.bgView addSubview:priceBtn];
        
        [priceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(80);
            if (lastBtn) {
                make.width.mas_equalTo(lastBtn);
            }else{
                if (i % num != 0) {
                    make.width.mas_equalTo((priceBtn.superview.frame.size.width - (num + 1)* intes)/4);
                }
            }
            if (i % num ==0 ) {
                make.left.mas_equalTo(priceBtn.superview).offset(intes);
            }else{
                make.left.mas_equalTo(lastBtn.mas_right).offset(intes);
            }
            if (i % num == (num - 1)) {
                make.right.mas_equalTo(priceBtn.superview).offset(-intes);
            }
            if (i / num == 0) {
                make.top.mas_equalTo(priceBtn.superview).offset(intes*10);
            } else {
                make.top.mas_equalTo(intes * 10 + ( i / num )* (80 + intes));
            }
        }];
        [priceBtn setTitle:priceArr[i] forState:UIControlStateNormal];
        [priceBtn setTitleColor:kYLColorFontGray forState:UIControlStateNormal];
        [priceBtn setTitleColor:kYLColorFontYellow forState:UIControlStateSelected];
//        [priceBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        priceBtn.layer.borderColor = kYLColorFontGray.CGColor;
        priceBtn.layer.borderWidth = 1;
        [priceBtn addTarget:self action:@selector(selectPrice:) forControlEvents:UIControlEventTouchUpInside];
        [priceBtn setTag:i+10];
        
            // 每次循环结束 此次的btn为下次约束的基准
            lastBtn = priceBtn;
    }
    
        [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.phoneTxt);
            make.right.mas_equalTo(self.contactBtn);
            make.top.mas_equalTo(self.bgView.mas_bottom).offset(30);
            make.height.mas_equalTo(40);
        }];
}

-(void)useStyle
{
    self.rModel = [[DDRequestModel alloc] init];
    self.backgroundColor = kYLColorBakcgorund;
    self.bgView.backgroundColor =[UIColor whiteColor];
    
    self.phoneTxt.placeholder = @"输入要充值的手机号码";
    self.phoneTxt.backgroundColor = kYLColorBakcgorund;
//    self.phoneTxt.delegate = self;
//    self.phoneTxt.borderStyle = UITextBorderStyleLine;
    self.contactBtn.layer.borderColor = kYLColorBakcgorund.CGColor;
    self.contactBtn.layer.borderWidth = 1.0f;
    self.contactView.image = [UIImage imageNamed:@"recharge_contact"];
    self.contactView.userInteractionEnabled = YES;
    self.contactLabel.text = @"通讯录";
    self.contactLabel.textColor = [UIColor blueColor];
    self.contactLabel.font = [UIFont systemFontOfSize:13];
    self.messageLabel.text = @"充值话费仅限西藏用户，流量全国通用";
    self.messageLabel.textColor = kYLColorFontGray;
    self.messageLabel.font = [UIFont systemFontOfSize:12];
    
    self.payBtn.backgroundColor = kYLColorFontOrange;
    [self.payBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    
    
    [self.contactBtn addTarget:self action:@selector(getMobileContacts:) forControlEvents:UIControlEventTouchUpInside];
    [self.payBtn addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
}

//立即支付
-(void)payAction:(UIButton *)sender
{
    [self allBlockWithDict:@{
                             kYLKeyForBlockType : @(kDDBlockTypeWechatPayCreateOrder),
                             kYLModel : self.rModel,
                             }];
}


//选择金额
-(void)selectPrice:(UIButton *)sender
{
      self.tmpBtn.layer.borderColor = kYLColorFontGray.CGColor;
      if (sender!= self.tmpBtn) {
          self.tmpBtn.selected = NO;
          sender.selected = YES;
          self.tmpBtn = sender;
      }else{
          self.tmpBtn.selected = YES;
      }
      sender.layer.borderColor = kYLColorFontYellow.CGColor;
    
      self.rModel.money = sender.titleLabel.text;
    if ([self.rModel.money intValue] == 20) {
        self.rModel.prodid = @"1";
    }
    if ([self.rModel.money intValue] == 30) {
        self.rModel.prodid = @"2";
    }

    if ([self.rModel.money intValue] == 50) {
        self.rModel.prodid = @"3";
    }

    if ([self.rModel.money intValue] == 100) {
        self.rModel.prodid = @"4";
    }
    if ([self.rModel.money intValue] == 300) {
        self.rModel.prodid = @"5";
    }

    if ([self.rModel.money intValue] == 500) {
        self.rModel.prodid = @"6";
    }

    
}

//获取通讯录
-(void)getMobileContacts:(UIButton *)sender
{
    //获取通讯录权限，调用系统通讯录
    [self CheckAddressBookAuthorization:^(bool isAuthorized , bool isUp_ios_9) {
        if (isAuthorized) {
            [self callAddressBook:isUp_ios_9];
        }else {
            NSLog(@"请到设置>隐私>通讯录打开本应用的权限设置");
        }
    }];
}

- (void)CheckAddressBookAuthorization:(void (^)(bool isAuthorized , bool isUp_ios_9))block {
    
    if (Is_up_Ios_9) {
        CNContactStore * contactStore = [[CNContactStore alloc]init];
        if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusNotDetermined) {
            [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * __nullable error) {
                if (error)
                {
                    NSLog(@"Error: %@", error);
                }
                else if (!granted)
                {
                    
                    block(NO,YES);
                }
                else
                {
                    block(YES,YES);
                }
            }];
        }
        else if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized){
            block(YES,YES);
        }
        else {
            NSLog(@"请到设置>隐私>通讯录打开本应用的权限设置");
        }
    }else {
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
        
        if (authStatus == kABAuthorizationStatusNotDetermined)
        {
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (error)
                    {
                        NSLog(@"Error: %@", (__bridge NSError *)error);
                    }
                    else if (!granted)
                    {
                        
                        block(NO,NO);
                    }
                    else
                    {
                        block(YES,NO);
                    }
                });
            });
        }else if (authStatus == kABAuthorizationStatusAuthorized)
        {
            block(YES,NO);
        }else {
            NSLog(@"请到设置>隐私>通讯录打开本应用的权限设置");
        }
    }
}

- (void)callAddressBook:(BOOL)isUp_ios_9 {
    if (isUp_ios_9) {
        CNContactPickerViewController *contactPicker = [[CNContactPickerViewController alloc] init];
        contactPicker.delegate = self;
        contactPicker.displayedPropertyKeys = @[CNContactPhoneNumbersKey];
        [[self viewController] presentViewController:contactPicker animated:YES completion:nil];
    }else {
        ABPeoplePickerNavigationController *peoplePicker = [[ABPeoplePickerNavigationController alloc] init];
        peoplePicker.peoplePickerDelegate = self;
        [[self viewController] presentViewController:peoplePicker animated:YES completion:nil];
        
    }
}


#pragma mark -- CNContactPickerDelegate
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty {
    CNPhoneNumber *phoneNumber = (CNPhoneNumber *)contactProperty.value;
    [[self viewController] dismissViewControllerAnimated:YES completion:^{
        /// 联系人
        NSString *text1 = [NSString stringWithFormat:@"%@%@",contactProperty.contact.familyName,contactProperty.contact.givenName];
        /// 电话
        NSString *text2 = phoneNumber.stringValue;
        NSString *text3 = [text2 stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSLog(@"联系人：%@, 电话：%@",text1,text2);
        
        self.phoneTxt.text = text3;
        self.rModel.phone = self.phoneTxt.text;
    }];
}

#pragma mark -- ABPeoplePickerNavigationControllerDelegate
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    
    ABMultiValueRef valuesRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
    CFIndex index = ABMultiValueGetIndexForIdentifier(valuesRef,identifier);
    CFStringRef value = ABMultiValueCopyValueAtIndex(valuesRef,index);
    CFStringRef anFullName = ABRecordCopyCompositeName(person);
    
    [[self viewController] dismissViewControllerAnimated:YES completion:^{
        /// 联系人
        NSString *text1 = [NSString stringWithFormat:@"%@",anFullName];
        /// 电话
        NSString *text2 = (__bridge NSString*)value;
        NSString *text3 = [text2 stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSLog(@"联系人：%@, 电话：%@",text1,text2);
        
        self.phoneTxt.text = text3;
        self.rModel.phone = self.phoneTxt.text;
    }];
}

//获取view的controller
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


//- (void)textFieldDidEndEditing:(UITextField *)textField{
//    
//    self.phoneTxt.text = textField.text;
//    self.rModel.phone = self.phoneTxt.text;
//}

@end

















