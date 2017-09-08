//
//  DDMyNoteBottomView.h
//  WitCity
//
//  Created by 方冬冬 on 16/7/29.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "YLView.h"

typedef NS_ENUM(NSUInteger,DDNotesBottomType){
    kDDNotesBottomOnlyDelete,       //只有删除
    kDDNotesBottomEditAndStatus,    //编辑、状态
    kDDNotesBottomEditAndDelete,    //编辑、删除
};

@interface DDMyNoteBottomView : YLView

//@property (nonatomic, copy) NSString *editString;
@property (nonatomic, copy) NSString *deleteString;

@property (nonatomic, assign) DDNotesBottomType type;
@end
