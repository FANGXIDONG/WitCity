//
//  YLBasicViewMacro.h
//  YLDraw
//
//  Created by simpletour on 16/1/30.
//  Copyright © 2016年 duyulong. All rights reserved.
//

#ifndef YLBasicViewMacro_h
#define YLBasicViewMacro_h


#import <Masonry.h>
#import <objc/message.h>
#import "YLColor.h"
#import "UIColor+YL.h"
#import "YLBlockType.h"
#import "YLMacro.h"
//#import "UIColor+YL.h"
#import "YLFlatColor.h"

#define basicProtocol(viewName)                                                                      \
@protocol viewName##Delegate <NSObject>                                                              \
@required                                                                                            \
- (void)addViews;                                                                                    \
- (void)layout;                                                                                      \
@optional                                                                                            \
- (void)useStyle;                                                                                    \
- (void)before;                                                                                      \
- (void)after;                                                                                       \
@end


#define basicMethodsStatement(viewName)                                                              \
@property (nonatomic, weak) id<viewName##Delegate> ylViewDelegate;                                   \
-(void)initProperty;


#define basicMethodsImplement(viewName)                                                              \
- (void)initialization                                                                               \
{                                                                                                    \
[self initProperty];                                                                                 \
[self callWithMethod:@selector(before)];                                                             \
[self callWithMethod:@selector(addViews)];                                                           \
[self callWithMethod:@selector(layout)];                                                             \
[self callWithMethod:@selector(useStyle)];                                                           \
[self callWithMethod:@selector(after)];                                                              \
}                                                                                                    \
\
- (void)callWithMethod:(SEL)method                                                                   \
{                                                                                                    \
if (self.ylViewDelegate && [self.ylViewDelegate respondsToSelector:method]) {                        \
objc_msgSend(self, method);                                                                          \
}                                                                                                    \
}                                                                                                    \
\
- (void)initProperty                                                                                 \
{                                                                                                    \
unsigned int numIvars = 0;                                                                           \
Ivar * ivars = class_copyIvarList([self class], &numIvars);                                          \
for(int i = 0; i < numIvars; i++) {                                                                  \
Ivar thisIvar = ivars[i];                                                                            \
const char *type = ivar_getTypeEncoding(thisIvar);                                                   \
NSString *stringType =  [NSString stringWithCString:type encoding:NSUTF8StringEncoding];             \
NSString *clazzType = [self classNameWithString:stringType];                                         \
Class clazz = NSClassFromString(clazzType);                                                          \
id obj = [[clazz alloc]init];                                                                        \
if ([stringType hasPrefix:@"@"] && [obj isKindOfClass:[UIView class]]) {                             \
object_setIvar(self, thisIvar, obj);                                                                 \
}                                                                                                    \
}                                                                                                    \
free(ivars);                                                                                         \
}                                                                                                    \
\
- (NSString *)classNameWithString:(NSString *)className                                              \
{                                                                                                    \
className = [className stringByReplacingOccurrencesOfString:@"\"" withString:@""];                   \
NSString* str = [className stringByReplacingOccurrencesOfString:@"@" withString:@""];                \
return str;                                                                                          \
}                                                                                                    \
\
-(void)addViews{}                                                                                    \
-(void)layout{}                                                                                      \
-(void)useStyle{}                                                                                    \
-(void)before{}                                                                                      \
-(void)after{}

#define basicMethodsImplementWithTableViewCell(viewName)                                             \
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier \
{                                                                                                    \
self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];                                  \
if (self) {                                                                                          \
self.ylViewDelegate = self;                                                                          \
[self initialization];                                                                               \
}                                                                                                    \
return self;                                                                                         \
}                                                                                                    \
basicMethodsImplement(viewName)


#define basicMethodsImplementWithView(viewName)                                                      \
-(instancetype)initWithFrame:(CGRect)frame                                                           \
{                                                                                                    \
self = [super initWithFrame:frame];                                                                  \
if (self) {                                                                                          \
self.ylViewDelegate = self;                                                                          \
[self initialization];                                                                               \
}                                                                                                    \
return self;                                                                                         \
}                                                                                                    \
basicMethodsImplement(viewName)

#endif /* YLBasicViewMacro_h */
