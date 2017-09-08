//
//  MovieTableViewController.h
//  WitCity
//
//  Created by 方冬冬 on 16/6/28.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import <UIKit/UIKit.h>


@class rilegouleView;

@interface MovieTableViewController : UITableViewController

@property (nonatomic, strong) rilegouleView *rilegoule;
@property (nonatomic, strong) UIImageView *BlurredView;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSIndexPath *currentIndexPath;
@end
