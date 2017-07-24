//
//  UIView+frame.m
//  SelectItemView
//
//  Created by 黄露 on 2017/6/12.
//  Copyright © 2017年 huanglu. All rights reserved.
//

#import "UIView+frame.h"

#import <objc/runtime.h>

@implementation UIView (frame)

-(UIView *(^)(CGFloat top))top {
    YH_Weak(self);
    return ^UIView *(CGFloat top) {
        YH_Strong(self);
        CGRect frame = self.frame;
        frame.origin.y = top;
        self.frame = frame;
        return self;
    };
}

- (UIView *(^)(CGFloat left))left {
    YH_Weak(self);
    return ^UIView *(CGFloat left) {
        YH_Strong(self);
        CGRect frame = self.frame;
        frame.origin.x = left;
        self.frame = frame;
        return self;
    };
}

- (UIView *(^)(CGFloat width))width {
    YH_Weak(self)
    return ^UIView *(CGFloat width) {
        YH_Strong(self);
        CGRect frame = self.frame;
        frame.size.width = width;
        self.frame = frame;
        return self;
    };
}

- (UIView *(^)(CGFloat height))height {
    YH_Weak(self)
    return ^UIView *(CGFloat height ) {
        YH_Strong(self);
        CGRect frame = self.frame;
        frame.size.height = height;
        self.frame = frame;
        return self;
    };
}

- (UIView *(^)(UIColor * backcolor))backcolor {
    YH_Weak(self)
    return ^UIView *(UIColor * backcolor) {
        YH_Strong(self);
        self.backgroundColor = backcolor;
        return self;
    };
}

- (UIView *(^)(CGSize size))size {
    YH_Weak(self)
    return ^UIView *(CGSize size) {
        YH_Strong(self);
        CGRect frame = self.frame;
        frame.size = size;
        self.frame = frame;
        return self;
    };
}

@end
