//
//  DDPublishImageTableView.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/27.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDPublishImageTableView.h"
#import "DDPublishImageCell.h"

@interface DDPublishImageTableView()<UITableViewDataSource, UITableViewDelegate,UIActionSheetDelegate>

@property (strong, nonatomic) DDUploadImageHelper *curUploadImageHelper;
@end

@implementation DDPublishImageTableView

static NSString *publishCellIdentifier = @"publishImageCell";

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        //初始化
        _curUploadImageHelper=[DDUploadImageHelper MPUploadImageForSend:NO];
        self.showsVerticalScrollIndicator   = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        self.dataSource = self;

        [self registerClass:[DDPublishImageCell class] forCellReuseIdentifier:publishCellIdentifier];
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return kPublishImageTableCellHeight;
    return [DDPublishImageCell cellHeightWithObj:self.curUploadImageHelper];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
 
    
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


@end






