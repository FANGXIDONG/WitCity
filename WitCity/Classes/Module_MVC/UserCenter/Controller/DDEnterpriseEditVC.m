//
//  DDEnterpriseEditVC.m
//  WitCity
//
//  Created by 方冬冬 on 2017/7/24.
//  Copyright © 2017年 bjxybs. All rights reserved.
//

#import "DDEnterpriseEditVC.h"
#import "DDEnterpriseEditTableView.h"
#import "DDSelectModel.h"
#import "YLUserHttpUtil.h"

#import "DDCameraHelper.h"
#import "DDUploadImageHelper.h"
#import "DDImageItemModel.h"

@interface DDEnterpriseEditVC ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, QBImagePickerControllerDelegate>
@property (nonatomic, strong) DDEnterpriseEditTableView *edTableView;
@property (nonatomic, strong) DDUploadImageHelper *curUploadImageHelper;
@property (nonatomic, strong) NSArray *typeArr;
@property (nonatomic, strong) NSArray *industryArr;
@end

@implementation DDEnterpriseEditVC

- (void)viewDidLoad{
    [super viewDidLoad];
    [self navigationWithTitle:_titleString];
    self.navigationItem.rightBarButtonItem = [self buttonForNavigationBarWithAction:@selector(skipdataClick) title:@"跳过"];
    [self addViews];
    [self loadData];
}

-(void)loadData{
    self.edTableView.dataModel = _dataModel;
    [YLUserHttpUtil getCompanyRegisterTypeblock:^(NSDictionary *dict) {
        _typeArr = [DDSelectModel mj_objectArrayWithKeyValuesArray:dict];
        self.edTableView.typeArr = _typeArr;
    } failure:^{
    }];
    [YLUserHttpUtil getCompanyIndustryblock:^(NSDictionary *dict) {
        _industryArr = [DDSelectModel mj_objectArrayWithKeyValuesArray:dict];
        self.edTableView.industryArr = _industryArr;
    } failure:^{
    }];
}

-(void)skipdataClick{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)addViews{
    [self.view addSubview:self.edTableView];
}

-(DDEnterpriseEditTableView *)edTableView
{
    if(!_edTableView) {
        _edTableView  = [[DDEnterpriseEditTableView alloc] initWithFrame:CGRectMake(0,0, WINDOW_WIDTH, CONTENT_HEIGHT2) style:UITableViewStylePlain];
    }
    WS(wself);
    _edTableView.allBlock = ^(NSDictionary *dict) {
        [wself callbackWithDict:dict];
    };
    return _edTableView;
}

#pragma mark  - callback
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
        case kDDBlockTypeDataSubmit:
        {
            //审核
           DDDataModel *dataModel = dict[kYLModel];
            [self submitDataWithModel:dataModel];
        }
            break;
        default:
            break;
    }
}
-(void)submitDataWithModel:(DDDataModel *)model
{

    [YLUserHttpUtil editEnterpriseDataWithUser_id:[YLUserSingleton shareInstance].uid reg_type:model.reg_type industry:model.industry contn:model.contn contp:model.contp address:model.address des:model.des thumb:nil block:^(NSDictionary *dict) {

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"提交成功，等待后台审核" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self popViewController];
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:NO completion:nil];
    } failure:^{
        //
    }];
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
    //刷新单元格11行
    [self.edTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.edTableView.txtArr.count inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end







