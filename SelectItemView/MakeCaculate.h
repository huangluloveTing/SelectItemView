//
//  MakeCaculate.h
//  SelectItemView
//
//  Created by 黄露 on 2017/6/13.
//  Copyright © 2017年 huanglu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define make_weak(type) __weak typeof(type) weak##_type = type;
#define make_strong(type)  __strong typeof(type) type = weak##_type;

@interface MakeCaculate : NSObject

//计算结果
@property (nonatomic , assign) CGFloat result;

- (MakeCaculate *(^)(CGFloat num))add;
- (MakeCaculate *(^)(CGFloat num))sub;
- (MakeCaculate *(^)(CGFloat num))mul;
- (MakeCaculate *(^)(CGFloat num))plu;

@end
