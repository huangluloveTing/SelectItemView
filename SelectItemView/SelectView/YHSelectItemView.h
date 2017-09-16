//
//  YHSelectItemView.h
//  YangHe_SCI
//
//  Created by 黄露 on 2017/6/9.
//  Copyright © 2017年 biz_zlq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHSelectItemView;
@protocol YHSelectItemDelegate <NSObject>

//调用此回调，属性里面的set方法将失效
- (NSArray *)allTitlesForSelectItemView:(YHSelectItemView *)selectView;

@optional
- (void) selectItemView:(YHSelectItemView *)selectView didSelectedItemIndex:(NSInteger)index;

- (UIImage *) backImageSelectItemView:(YHSelectItemView *)selectItemView ForIndex:(NSInteger)index;

//
- (UIImage *) itemBackImageForSelectItemView:(YHSelectItemView *)selectItemView;

//下拉列表的选项
- (void) selectItemView:(YHSelectItemView *)selectItemView selectItemViewIndex:(NSInteger)itemIndex didSelectedDropViewIndex:(NSInteger)index;

//选中的背景图片
//- (UIImage *) itemBackImageForSelectedItemView:(YHSelectItemView *)selectItemView;

//每个item 对应的右边的图片
- (UIImage *) rightImageForSelectItemView:(YHSelectItemView *)selectItemView;

//对应的item 的字体
- (UIFont *) fontSizeForSelectItemView:(YHSelectItemView *)selectItemView AtIndex:(NSInteger)index;
//对应的下拉列表的字体大小
- (UIFont *) fontSizeForDropViewSelectItemView:(YHSelectItemView *)selectItemView AtItemIndex:(NSInteger)itemIndex;

//给下拉选项赋值
- (NSArray *) selectItemView:(YHSelectItemView *)selectItemView forDropViewItemsAtItemIndex:(NSInteger)itemIndex;

//自定义下拉视图,无需指定传入的view 的frame，会根据初始化传入的orginY 和目标视图计算frame
- (UIView *) dropViewForSelectItemView:(YHSelectItemView *)selectItemView AtIndex:(NSInteger)index;

//下拉视图可滑动区域的背景颜色
- (UIColor *)backgroundColorForDropViewScrolRectForSelectItemView:(YHSelectItemView *)selectItemView AtItemIndex:(NSInteger)index;

@end

@interface YHSelectItemView : UIView

- (instancetype) initWithFrame:(CGRect)frame
                  ToTargetView:(UIView *)targetView
            DropViewTargetView:(UIView *)dropTargetView
                       OriginY:(CGFloat) originY;

@property (nonatomic , assign) CGFloat itemBtnMargin;

@property (nonatomic , assign) id<YHSelectItemDelegate> delegate;

- (void) reloadData;

@end
