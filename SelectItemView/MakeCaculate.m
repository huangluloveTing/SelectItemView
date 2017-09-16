//
//  MakeCaculate.m
//  SelectItemView
//
//  Created by 黄露 on 2017/6/13.
//  Copyright © 2017年 huanglu. All rights reserved.
//

#import "MakeCaculate.h"


@implementation MakeCaculate

- (MakeCaculate *(^)(CGFloat num))add {
    
    make_weak(self)
    return ^MakeCaculate * (CGFloat num) {
        make_strong(self)
        
        self.result += num;
        
        return self;
    };
}

- (MakeCaculate *(^)(CGFloat num))sub {
    make_weak(self)
    return ^MakeCaculate * (CGFloat num) {
        make_strong(self)
        
        self.result -= num;
        
        return self;
    };
}

- (MakeCaculate *(^)(CGFloat num))mul {
    make_weak(self)
    return ^MakeCaculate * (CGFloat num) {
        make_strong(self)
        
        self.result *= num;
        
        return self;
    };
}

- (MakeCaculate *(^)(CGFloat num))plu {
    make_weak(self)
    return ^MakeCaculate * (CGFloat num) {
        make_strong(self)
        
        NSAssert(num != 0, @"除数不能为零");
        self.result /= num;
        
        return self;
    };
}

@end
