//
//  YLPhotoManager.m
//  HYB
//
//  Created by duyulong on 4/3/16.
//  Copyright © 2016 HYB. All rights reserved.
//

#import "YLPhotoManager.h"
#import "YLBlockType.h"

@interface YLPhotoManager ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation YLPhotoManager

-(instancetype)initWithController:(UIViewController *)controller
{
    self = [super init];
    if(self) {
        self.controller = controller;
    }
    return self;
}

- (void)showOptionActionSheet
{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"请选择上传方式" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:cancelAction];
    
    UIAlertAction *acCamera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (self.allBlock) {
            self.allBlock(@{
                            kYLKeyForBlockType : @(kYLBlockTypePhotoCamera),
                            });
        }
    }];
    [ac addAction:acCamera];
    
    UIAlertAction *acLibrary = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (self.allBlock) {
            self.allBlock(@{
                            kYLKeyForBlockType : @(kYLBlockTypePhotoLibrary),
                            });
        }
    }];
    [ac addAction:acLibrary];
    
    [self.controller presentViewController:ac animated:YES completion:nil];
}

- (void)getPhotoWithCamera
{
    [self usePhotoWithType:UIImagePickerControllerSourceTypeCamera];
}


- (void)getPhotoWithLibrary
{
    [self usePhotoWithType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)usePhotoWithType:(UIImagePickerControllerSourceType)type
{
    UIImagePickerController  *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = type;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self.controller presentViewController:picker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
        if (self.allBlock) {
            self.allBlock(@{
                            kYLKeyForBlockType : @(kYLBlockTypePhotoResult),
                            kYLValue : image
                            });
        }
        [picker dismissViewControllerAnimated:YES completion:nil];
    }];
}


@end
