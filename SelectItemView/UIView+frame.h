//
//  UIView+frame.h
//  SelectItemView
//
//  Created by 黄露 on 2017/6/12.
//  Copyright © 2017年 huanglu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define YH_Weak(type)  __weak typeof(type) weak##type = type;

#define YH_Strong(type)  __strong typeof(type) type = weak##type;

@interface UIView (frame)

-(UIView * (^)(CGFloat top))top;

-(UIView * (^)(CGFloat left))left;

-(UIView * (^)(CGFloat width))width;

-(UIView * (^)(CGFloat height))height;

-(UIView * (^)(UIColor * backcolor))backcolor;

-(UIView * (^)(CGSize size))size;

@end
