//
//  YHSelectItemView.m
//  YangHe_SCI
//
//  Created by 黄露 on 2017/6/9.
//  Copyright © 2017年 biz_zlq. All rights reserved.
//

#import "YHSelectItemView.h"

#import "YHSelectButton.h"

#import "YHSelectDropView.h"

@interface YHSelectItemView ()<YHSelectButtonDelegate , YHSelectDropViewDelegate>

@property (nonatomic , strong) UIView * targetView;

@property (nonatomic , strong) NSArray * allTitles;

@property (nonatomic , assign) CGRect targetFrame;

//下拉列表
@property (nonatomic , strong) YHSelectDropView * dropView;

//所有的button
@property (nonatomic , strong) NSArray * itemButtons;

//下拉列表的所在视图
@property (nonatomic , strong) UIView * dropTargetView;

//下拉列表的起点坐标的y 
@property (nonatomic , assign) CGFloat dropOriginY;

//通过委托的设置的下拉视图
@property (nonatomic , strong) UIView * extraDropView;

@end

@implementation YHSelectItemView

- (instancetype) initWithFrame:(CGRect)frame
                  ToTargetView:(UIView *)targetView
            DropViewTargetView:(UIView *)dropTargetView
                       OriginY:(CGFloat)originY
{
    if (self = [super initWithFrame:frame]) {
        self.targetFrame = frame;
        self.targetView = targetView;
        
        [self addViewToTargetView:targetView];
        self.dropTargetView = dropTargetView;
        self.dropOriginY = originY;
    }
    
    return self;
}

- (void) awakeFromNib {
    [super awakeFromNib];
}


#pragma mark - 奖自己添加到目标视图上
- (void) addViewToTargetView:(UIView *)targetView {
    
    [targetView addSubview:self];
}

#pragma mark - config
- (void) configItems {
    NSInteger itemCount = self.allTitles.count;
    NSAssert(itemCount != 0, @"添加的数量不能为零");
    
    [self removeAllSelectButton];
    
    CGFloat width = (self.targetFrame.size.width - (itemCount + 1) * self.itemBtnMargin) / itemCount;
    CGFloat height = self.targetFrame.size.height - 2 * self.itemBtnMargin;
    NSMutableArray * tempArr = [NSMutableArray array];
    for (int i = 0 ; i < itemCount; i ++ ) {
        NSString * item = self.allTitles[i];
        
        UIImage * image = nil;
        if (self.delegate && [self.delegate respondsToSelector:@selector(rightImageForSelectItemView:)]) {
            image = [self.delegate rightImageForSelectItemView:self];
        }
        YHSelectButton * itemBtn = [YHSelectButton YHButtonWithTitle:item ItemImage:image];
        itemBtn.delegate = self;
        itemBtn.frame = CGRectMake(self.itemBtnMargin * (1 + i) + width * i , self.itemBtnMargin , width, height);
        itemBtn.tag = i + 100;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(fontSizeForSelectItemView:AtIndex:)]) {
            [itemBtn setTitleLabelFont:[self.delegate fontSizeForSelectItemView:self AtIndex:i]];
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(itemBackImageForSelectItemView:)]) {
            UIImage * backImage = [self.delegate itemBackImageForSelectItemView:self];
            if (!backImage) {
                continue;
            }
        }
        [self addSubview:itemBtn];
        
        [tempArr addObject:itemBtn];
    }
    
    self.itemButtons = [NSArray arrayWithArray:tempArr];
}

#pragma mark - YHButtonDelegate
- (void) tapedSelectButton:(YHSelectButton *)button {
    for (YHSelectButton * selectBtn  in self.itemButtons) {
        if (selectBtn == button) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(selectItemView:didSelectedItemIndex:)]) {
                [self.delegate selectItemView:self didSelectedItemIndex:selectBtn.tag - 100];
            }
            if (selectBtn.selectStatus == SelectButton_selected) {
                [self appearDropViewForIndex:button.tag - 100];
                [selectBtn setSelectButtonStatus:SelectButton_selected];
                continue;
            }
            [selectBtn setSelectButtonStatus:SelectButton_Normal];
            [self.dropView removeFromSuperview];
            [self dropViewDisappearAtIndex:button.tag - 100];
            
        } else {
            [selectBtn setSelectButtonStatus:SelectButton_Normal];
            [self dropViewAppearAnimation];
        }
    }
}

#pragma mark - 移除所有button
- (void) removeAllSelectButton {
    NSArray * subViews = self.subviews;
    for (UIView * subView in subViews) {
        if ([subView isKindOfClass:[YHSelectButton class]]) {
            [subView removeFromSuperview];
        }
    }
}

- (void) layoutSubviews {
    [super layoutSubviews];
    self.frame = self.targetFrame;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(allTitlesForSelectItemView:)]) {
        self.allTitles = [self.delegate allTitlesForSelectItemView:self];
    }
    
    [self configItems];
}

#pragma mark - YHSelectDropViewDelegate
- (void) selectDropView:(YHSelectDropView *)dropView didSelectedIndex:(NSInteger)index {
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectItemView:selectItemViewIndex:didSelectedDropViewIndex:)]) {
        
        NSInteger selectItemIndex = 0;
        NSInteger dropViewIndex = index;
        
        for (YHSelectButton * selectBtn  in self.itemButtons) {
            
            if (selectBtn.selectStatus == SelectButton_selected) {
                selectItemIndex = [self.itemButtons indexOfObject:selectBtn];
            }
            
        }
        [self.delegate selectItemView:self selectItemViewIndex:selectItemIndex didSelectedDropViewIndex:dropViewIndex];
    }
    
    [self.dropView dropViewDisappear];
}

- (void) dismissSelectDropView:(YHSelectDropView *)dropView {
    for (YHSelectButton * selectBtn  in self.itemButtons) {
        [selectBtn setSelectButtonStatus:SelectButton_Normal];
    }
}

//设置下拉视图可滑动区域的背景的背景
- (UIColor *) backgroundColorForScrollRectForSelectDropView:(YHSelectDropView *)dropView {
    if (dropView == self.dropView) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(backgroundColorForDropViewScrolRectForSelectItemView:AtItemIndex:)]) {
            return [self.delegate backgroundColorForDropViewScrolRectForSelectItemView:self AtItemIndex:self.dropView.tag - 100];
        }
    }
    return nil;
}

#pragma mark - 下拉列表
- (void) appearDropViewForIndex:(NSInteger) index {
    
    [self.extraDropView removeFromSuperview];
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropViewForSelectItemView:AtIndex:)]) {
        self.extraDropView = [self.delegate dropViewForSelectItemView:self AtIndex:index];
        CGRect dropFrame = CGRectMake(0, self.dropOriginY, CGRectGetWidth(self.targetView.frame), CGRectGetHeight(self.dropTargetView.frame));
        self.extraDropView.frame = dropFrame;
        if (self.extraDropView) {
            [self.dropTargetView addSubview:self.extraDropView];
            return;
        }
    }
    
    NSArray * titles = nil;
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectItemView:forDropViewItemsAtItemIndex:)]) {
        titles = [self.delegate selectItemView:self forDropViewItemsAtItemIndex:index];
        [self.dropView configSelectItems:titles];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(fontSizeForDropViewSelectItemView:AtItemIndex:)]) {
        UIFont * dropItemFont = [self.delegate fontSizeForDropViewSelectItemView:self AtItemIndex:index];
        self.dropView.itemFont = dropItemFont;
    }
    
    self.dropView.tag = 100 + index;
    
    [self.dropTargetView addSubview:self.dropView];
}

- (void) dropViewDisappearAtIndex:(NSInteger)index {
    [self.extraDropView removeFromSuperview];
}

#pragma mark - getter
- (YHSelectDropView *)dropView {
    if (!_dropView ) {
        _dropView = [[YHSelectDropView alloc] initWithFrame:CGRectMake(0, self.dropOriginY, self.dropTargetView.frame.size.width, CGRectGetHeight(self.dropTargetView.frame) - self.dropOriginY)];
        _dropView.delegate = self;
    }
    
    return _dropView;
}


- (void) reloadData {
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void) dropViewAppearAnimation {
    
}

@end
