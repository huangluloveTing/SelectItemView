//
//  YHSelectDropView.h
//  YangHe_SCI
//
//  Created by 黄露 on 2017/6/10.
//  Copyright © 2017年 biz_zlq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHSelectDropView;
@protocol YHSelectDropViewDelegate <NSObject>

@optional
- (void) selectDropView:(YHSelectDropView *)dropView didSelectedIndex:(NSInteger)index;

//下拉列表消失 的回调
- (void) dismissSelectDropView:(YHSelectDropView *)dropView;
//下拉视图可选区域的背景颜色
- (UIColor *) backgroundColorForScrollRectForSelectDropView:(YHSelectDropView *)dropView;
@end

@interface YHSelectDropView : UIView

@property (nonatomic , assign) id<YHSelectDropViewDelegate> delegate;

- (void) configSelectItems:(NSArray<NSString *> *)items;

@property (nonatomic , strong) UIFont * itemFont;

-(void )dropViewDisappear;

@end
