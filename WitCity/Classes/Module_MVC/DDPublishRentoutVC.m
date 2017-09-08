//
//  DDPublishRentoutVC.m
//  WitCity
//
//  Created by 方冬冬 on 16/8/17.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDPublishRentoutVC.h"
#import "DDPublishRentoutTableView.h"
#import "DDCameraHelper.h"
#import "DDUploadImageHelper.h"
#import "YLLoginManager.h"
#import "DDImageItemModel.h"
#import "DDRentoutDetailModel.h"
//环形进度条
#import <DACircularProgressView.h>
#import <DALabeledCircularProgressView.h>

#define TIMER_DURATION 0
#define AQI_FULL 100

@interface DDPublishRentoutVC()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, QBImagePickerControllerDelegate>
{
    DACircularProgressView *progressView;
    DALabeledCircularProgressView *labeledProgressView;
    int start;
    int aqi;
}
@property (nonatomic, retain )NSTimer *timer;
@property (nonatomic, strong) DDPublishRentoutTableView *roTableView;
@property (nonatomic, strong) DDUploadImageHelper *curUploadImageHelper;
@property (nonatomic, strong) YLLoginManager *loginManager;
@end

@implementation DDPublishRentoutVC


-(void)viewDidLoad{
    
    self.navigationItem.title = @"发布-出租";
    self.navigationItem.leftBarButtonItem = [self buttonForPublishVCNavigationBarWithAction:@selector(leftClick) imageNamed:@"navi_back"];
    [self addViews];
}

-(void)addViews{
    [self.view addSubview:self.roTableView];
}


-(DDPublishRentoutTableView *)roTableView{
    
    if(!_roTableView) {
        _roTableView  = [[DDPublishRentoutTableView alloc] initWithFrame:CGRectMake(0,0, WINDOW_WIDTH, CONTENT_HEIGHT2) style:UITableViewStylePlain];
    }
    //滑动到最底端
    [_roTableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    WS(wself);
    _roTableView.allBlock = ^(NSDictionary *dict) {
        [wself callbackWithDict:dict];
    };
    return _roTableView;
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
        case kDDBlockTypePublishAction:
        {
            DDRentoutDetailModel *model = dict[kYLModel];
            //发布
            [self publish:model];
        }break;
        default:
            break;
    }
}

//发布
-(void)publish:(DDRentoutDetailModel *)model{
    

    [self.loginManager pushCheckedLoginWithPopToRoot:NO block:^{
        
//       [self setProgressView];
        
        NSMutableArray *dataArr = [NSMutableArray array];
        for (DDImageItemModel *model in self.curUploadImageHelper.imagesArray) {
            NSData *data = UIImagePNGRepresentation(model.image);
            [dataArr addObject:data];
        }
        
        [DDLifeHttpUtil publishRentOutWithTitle:model.title address:model.address price:model.price type:model.type source:model.source floor:model.floor config:model.config summary:model.summary thumb:dataArr person:model.person phone:model.phone Block:^(NSDictionary *dict) {
            
//            if ([dict[@"status"] intValue] == 1) {
                [YLToast showToastInKeyWindowWithText:@"发布成功"];
                [self leftClick];
//            }
            
        } failure:^{
            //
        }];
        
        
    }];

    
   
    
//    [DDLifeHttpUtil publishRentOutWithTitle:model.title address:model.address price:model.price type:model.type source:model.source floor:model.floor config:model.config summary:model.summary thumb:model.thumb person:model.person phone:model.phone Block:^(NSDictionary *dict) {
//        //
//    } failure:^{
//        //
//    }];
}

#pragma mark - 进度条
-(void)setProgressView{
    //设置空气质量指数
    aqi=100;
    //初始化进度条视图
    progressView = [[DACircularProgressView alloc] initWithFrame:CGRectMake(140.0f, 200.0f, 100.0f, 100.0f)];
    progressView.roundedCorners = NO;
    //设置颜色
    progressView.trackTintColor = [UIColor grayColor];
    progressView.progressTintColor=[UIColor greenColor];
    //设置进度
    [progressView setProgress:(CGFloat)aqi/AQI_FULL animated:YES initialDelay:0];
    
    labeledProgressView= [[DALabeledCircularProgressView alloc]
                          initWithFrame:CGRectMake(140.0f, 200.0f, 100.0f, 100.0f)];
    labeledProgressView.progressLabel.textColor=[UIColor blueColor];
    [self.view addSubview:labeledProgressView];
    [self.view addSubview:progressView];
    
    [self startAnimation];
}
#pragma mark 开始启动定时器 标签内容自加
- (void)startAnimation
{
    self.timer= [NSTimer scheduledTimerWithTimeInterval:(CGFloat)TIMER_DURATION/aqi
                                                 target:self
                                               selector:@selector(progressChange)
                                               userInfo:nil
                                                repeats:YES];
}
#pragma mark 改变标签内容
- (void)progressChange
{
    labeledProgressView.progressLabel.text = [NSString stringWithFormat:@"%d%%", start+=1];
    if (start>=aqi) {
        [self.timer invalidate];
        self.timer = nil;
        [progressView removeFromSuperview];
        [labeledProgressView removeFromSuperview];
        [YLToast showToastInKeyWindowWithText:@"发布成功"];
        
        // 延迟2秒执行：
        double delayInSeconds = 1.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self leftClick];
        });
    }
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
    [self.roTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.roTableView.txtArr.count inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}


-(void)leftClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
