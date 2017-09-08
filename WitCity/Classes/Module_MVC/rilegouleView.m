//
//  rilegouleView.m
//  WitCity
//
//  Created by 方冬冬 on 16/6/28.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "rilegouleView.h"
#import "ContentView.h"
#import "ContentScrollView.h"
#import "EveryDayModel.h"
#import "EveryDayTableViewCell.h"

@implementation rilegouleView


- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray index:(NSInteger)index{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        
        self.contentMode = UIViewContentModeTop;
        self.clipsToBounds = YES;
        _scrollView = [[ContentScrollView alloc] initWithFrame:CGRectMake(0, 64, WINDOW_WIDTH, WINDOW_HEIGHT - 64) imageArray:imageArray index:index];
        [self addSubview:_scrollView];
        
        self.scrollView.userInteractionEnabled = YES;
        //
        EveryDayModel *model = imageArray[index];
        //
        _contentView = [[ContentView alloc]initWithFrame:CGRectMake(0, WINDOW_HEIGHT / 1.7, WINDOW_WIDTH, WINDOW_HEIGHT - WINDOW_HEIGHT / 1.7) Width:35 model:model collor:[UIColor whiteColor]];
        [_contentView setData:model];
        [self addSubview:_contentView];
        //
        _playView = [[UIImageView alloc]initWithFrame:CGRectMake((WINDOW_WIDTH - 100) / 2, (WINDOW_HEIGHT/1.7 - 100) / 2 + 64, 100, 100)];
        _playView.image = [UIImage imageNamed:@"video-play"];
        
        [self addSubview:_playView];
        
        _animationView = [[EveryDayTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:nil];
        [_animationView.coverview removeFromSuperview];
        
        [self addSubview:_animationView];
        
        _playView.alpha = 0;
        
        _scrollView.alpha = 0;
    }
    return self;
}

- (void)aminmationShow{
    
    self.contentView.frame = CGRectMake(0, self.offsetY, WINDOW_WIDTH, 250);
    self.animationView.frame = CGRectMake(0, self.offsetY, WINDOW_WIDTH, 250);
    self.animationView.picture.transform = self.animationTrans;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.animationView.frame = CGRectMake(0, 64, WINDOW_WIDTH, WINDOW_HEIGHT / 1.7);
        self.animationView.picture.transform = CGAffineTransformMakeTranslation(0,  (WINDOW_HEIGHT / 1.7 - 250)/2);
        
        self.contentView.frame = CGRectMake(0, WINDOW_HEIGHT / 1.7 + 64, WINDOW_WIDTH, WINDOW_HEIGHT - WINDOW_HEIGHT / 1.7 -64);
    } completion:^(BOOL finished) {
        
        self.scrollView.alpha = 1;
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self.animationView.alpha = 0;
            self.playView.alpha = 1;
            
        } completion:^(BOOL finished) {
            
        }];
    }];
    
    
}

- (void)animationDismissUsingCompeteBlock:(void (^)(void))complete {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.animationView.alpha = 1;
    } completion:^(BOOL finished) {
        
        self.scrollView.alpha = 0;
        self.playView.alpha = 0;
        [UIView animateWithDuration:0.5 animations:^{
            
            CGRect rec = self.animationView.frame;
            rec.origin.y = self.offsetY;
            rec.size.height = 250;
            self.animationView.frame = rec;
            self.animationView.picture.transform = self.animationTrans;
            self.contentView.frame = rec;
            
        } completion:^(BOOL finished) {
            
            self.animationTrans = CGAffineTransformIdentity;
            
            [self.contentView removeFromSuperview];
            //            _rilegoule
            //
            [UIView animateWithDuration:0.25 animations:^{
                self.animationView.alpha = 0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
                
                complete();
            }];
            
        }];
    }];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
