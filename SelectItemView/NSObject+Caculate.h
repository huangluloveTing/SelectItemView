//
//  NSObject+Caculate.h
//  SelectItemView
//
//  Created by 黄露 on 2017/6/13.
//  Copyright © 2017年 huanglu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MakeCaculate.h"

@interface DCCaculator : NSObject

@property (nonatomic , strong) MakeCaculate * caculator;

@property (nonatomic , assign , readonly) CGFloat result;

+ (instancetype) initWithOriginNum:(CGFloat)num;

- (DCCaculator * (^)(CGFloat num)) add;
- (DCCaculator * (^)(CGFloat num)) sub;
- (DCCaculator * (^)(CGFloat num)) mul;
- (DCCaculator * (^)(CGFloat num)) plu;


@end
