//
//  YLPhotoManager.h
//  HYB
//
//  Created by duyulong on 4/3/16.
//  Copyright © 2016 HYB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YLPhotoManager : NSObject

@property (nonatomic, copy) void(^allBlock)(NSDictionary *dict);
@property (nonatomic, strong) UIViewController *controller;

-(instancetype)initWithController:(UIViewController *)controller;
- (void)showOptionActionSheet;
- (void)getPhotoWithCamera;
- (void)getPhotoWithLibrary;

@end
