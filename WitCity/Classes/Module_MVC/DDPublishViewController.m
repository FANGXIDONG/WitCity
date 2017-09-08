//
//  DDPublishViewController.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/19.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDPublishViewController.h"
#import "DDPublishLwqTopView.h"      //头视图
#import "DDPublishLwqButtomView.h"   //底部视图
#import "DDPublishImageTableView.h"  //发布图片表格

#import "DDCameraHelper.h"
#import "DDUploadImageHelper.h"
#import "YLLoginManager.h"
#import "DDImageItemModel.h"

@interface DDPublishViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, QBImagePickerControllerDelegate>

@property (nonatomic, strong) DDPublishLwqTopView *topView;
@property (nonatomic, strong) DDPublishLwqButtomView *bottomView;
@property (nonatomic, strong) DDPublishImageTableView *tableView;
@property (strong, nonatomic) DDUploadImageHelper *curUploadImageHelper;
@property (nonatomic, copy) NSString *publishTitle;
@property (nonatomic, copy) NSString *publishContent;
@property (nonatomic,strong)YLLoginManager *loginManager;
@end

@implementation DDPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发布-柳梧圈";
    self.navigationItem.leftBarButtonItem = [self buttonForPublishVCNavigationBarWithAction:@selector(leftClick) imageNamed:@"navi_back"];
    [self addViews];

    self.tableView.bounces=NO;
    self.tableView.scrollEnabled=YES;
}

-(void)addViews{
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.topView;

    [self.view addSubview:self.bottomView];
}

#pragma mark - getter
-(DDPublishLwqTopView *)topView
{
    if(!_topView) {
        _topView = [[DDPublishLwqTopView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, CONTENT_HEIGHT2 - kBottomHeight - kPublishImageTableCellHeight)];
    }
    WS(wself);
    _topView.allBlock = ^(NSDictionary *dict) {
        [wself callbackWithDict:dict];
    };
    return _topView;
}

-(DDPublishImageTableView *)tableView
{
    if(!_tableView) {
        _tableView  = [[DDPublishImageTableView alloc] initWithFrame:CGRectMake(0,0, WINDOW_WIDTH, CONTENT_HEIGHT2 - kBottomHeight) style:UITableViewStylePlain];
    }
    WS(wself);
    _tableView.allBlock = ^(NSDictionary *dict) {
        [wself callbackWithDict:dict];
    };
    return _tableView;
}

-(DDPublishLwqButtomView *)bottomView
{
    if(!_bottomView) {
        _bottomView = [[DDPublishLwqButtomView alloc]initWithFrame:CGRectMake(0, CONTENT_HEIGHT2 - 150, WINDOW_WIDTH, kBottomHeight)];
    }
    WS(wself);
    _bottomView.allBlock = ^(NSDictionary *dict) {
        [wself callbackWithDict:dict];
    };
    return _bottomView;
}

-(YLLoginManager *)loginManager
{
    if(!_loginManager) {
        _loginManager = [[YLLoginManager alloc]initWithController:self];
    }
    return _loginManager;
}


-(void)callbackWithDict:(NSDictionary *)dict{
    
    NSInteger blockType = [dict[kYLKeyForBlockType] integerValue];
    switch (blockType) {
        case kDDBlockTypeCamera:{
            //拍照
            [self callCamera];
            
        }break;
        case kDDBlockTypeAlerm:
        {
            //相册
            _curUploadImageHelper = dict[kYLModel];
            [self callAlbum];

        }break;
        case kDDBlockTypeTitleText:
        {
            //标题
            _publishTitle = dict[kYLValue];
        }break;
        case kDDBlockTypeContentText:
        {
            //内容
            _publishContent = dict[kYLValue];
        }break;
        case kDDBlockTypePublishAction:
        {
            //发布
            [self publishOfLiuwuquan];
        }break;
    
        default:
            break;
    }
}

//发布
-(void)publishOfLiuwuquan{
    
    [self.loginManager pushCheckedLoginWithPopToRoot:NO block:^{
       
        [self publishContentAction];
        
    }];
}

-(void)publishContentAction{
    
    if (!self.publishTitle) {
        
        if (!self.publishContent) {
            
            if (self.curUploadImageHelper.selectedAssetURLs.count==0) {
                [YLToast showToastWithView:self.view text:@"标题内容图片不能同时为空"];
                return;
            }
            
        }
    }
    
    NSMutableArray *dataArr = [NSMutableArray array];
    for (DDImageItemModel *model in self.curUploadImageHelper.imagesArray) {
        NSData *data = UIImagePNGRepresentation(model.image);
        [dataArr addObject:data];
    }
    
    [DDLifeHttpUtil publishLwqWithtitle:_publishTitle content:_publishContent thumbFile:dataArr Block:^(NSDictionary *dict) {
        
        if ([dict[@"status"] intValue] == 1) {
            [YLToast showToastInKeyWindowWithText:@"发布成功"];
            [self leftClick];
        }
        
        NSLog(@"%@",dict);
        
    } failure:^{
        //
    }];
  
    
    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"发布成功" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self dismissViewControllerAnimated:NO completion:nil];
//    }];
//    [alertController addAction:okAction];
//    [self presentViewController:alertController animated:NO completion:nil];
    

}

//相机
-(void)callCamera{
    if (![DDCameraHelper checkCameraAuthorizationStatus]) {
        return;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;//设置可编辑
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:nil];//进入照相界面
}
//相册
-(void)callAlbum{
    if (![DDCameraHelper checkPhotoLibraryAuthorizationStatus]) {
        return;
    }
    QBImagePickerController *imagePickerController = [[QBImagePickerController alloc] init];
    [imagePickerController.selectedAssetURLs removeAllObjects];
    [imagePickerController.selectedAssetURLs addObjectsFromArray:_curUploadImageHelper.selectedAssetURLs];
    imagePickerController.filterType = QBImagePickerControllerFilterTypePhotos;
    imagePickerController.delegate = self;
    imagePickerController.maximumNumberOfSelection = kupdateMaximumNumberOfImage;
    imagePickerController.allowsMultipleSelection = YES;
    [self presentViewController:imagePickerController animated:YES completion:NULL];
}


#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *pickerImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    [assetsLibrary writeImageToSavedPhotosAlbum:[pickerImage CGImage] orientation:(ALAssetOrientation)pickerImage.imageOrientation completionBlock:^(NSURL *assetURL, NSError *error) {
        [self.curUploadImageHelper addASelectedAssetURL:assetURL];
        //局部刷新 根据布局相应调整
        [self partialTableViewRefresh];
    }];
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark UINavigationControllerDelegate, QBImagePickerControllerDelegate

- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didSelectAssets:(NSArray *)assets{
    NSMutableArray *selectedAssetURLs = [NSMutableArray new];
    [imagePickerController.selectedAssetURLs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [selectedAssetURLs addObject:obj];
    }];
    DDWeakSelf(self)
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.curUploadImageHelper.selectedAssetURLs = selectedAssetURLs;
        dispatch_async(dispatch_get_main_queue(), ^{
            DDStrongSelf(self)
            //局部刷新 根据布局相应调整
            [self partialTableViewRefresh];
        });
    });
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController{
    [self dismissViewControllerAnimated:YES completion:nil];
}


//上传图后局部刷新图片行 根据布局相应调整
-(void)partialTableViewRefresh
{
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}

-(void)leftClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end












