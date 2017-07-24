//
//  NSObject+Caculate.m
//  SelectItemView
//
//  Created by 黄露 on 2017/6/13.
//  Copyright © 2017年 huanglu. All rights reserved.
//

#import "NSObject+Caculate.h"

@implementation DCCaculator


+ (instancetype) initWithOriginNum:(CGFloat)num {
    DCCaculator * obj = [[DCCaculator alloc] init];
    MakeCaculate * cacultor = [[MakeCaculate alloc] init];
    obj.caculator = cacultor;
    cacultor.result = num ;
    return obj;
}

-(DCCaculator * (^)(CGFloat num)) add {
    make_weak(self)
    return ^DCCaculator * (CGFloat num) {
        make_strong(self);
        
        self.caculator.add(num);
        return self;
    };
}

-(DCCaculator * (^)(CGFloat num)) sub {
    make_weak(self)
    return ^DCCaculator * (CGFloat num) {
        make_strong(self);
        
        self.caculator.sub(num);
        return self;
    };
}


-(DCCaculator * (^)(CGFloat num)) mul {
    make_weak(self)
    return ^DCCaculator * (CGFloat num) {
        make_strong(self);
        
        self.caculator.mul(num);
        return self;
    };
}

-(DCCaculator * (^)(CGFloat num)) plu {
    make_weak(self)
    return ^DCCaculator * (CGFloat num) {
        make_strong(self);
        
        self.caculator.plu(num);
        return self;
    };
}

- (CGFloat) result {
    return self.caculator.result;
}

@end
