//
//  YLListViewController.h
//  FJZ
//
//  Created by duyulong on 11/19/15.
//  Copyright © 2015 FJZ. All rights reserved.
//

#import "YLViewController.h"
#import "YLListTableView.h"

@interface YLListViewController : YLViewController

@property (nonatomic, assign) NSInteger page;

- (void)showDataWithTableView:(YLListTableView *)tableView dataList:(NSArray *)dataList withFlag:(NSInteger )flag append:(BOOL)append;
-(void)loadWithPage:(NSInteger)page append:(BOOL)append;
-(void)refresh;
-(void)load;

@end
