//
//  XHScrollView.h
//  style_ios
//
//  Created by yulongdu on 9/21/15.
//  Copyright © 2015 nick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLBasicViewMacro.h"

basicProtocol(YLScrollView)

@interface YLScrollView : UIScrollView<YLScrollViewDelegate>

basicMethodsStatement(YLScrollView)

@end
