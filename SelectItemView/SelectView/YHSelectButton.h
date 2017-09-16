//
//  YHSelectButton.h
//  YangHe_SCI
//
//  Created by 黄露 on 2017/6/9.
//  Copyright © 2017年 biz_zlq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , SelectButtonStatus) {
    SelectButton_selected = 0,
    SelectButton_Normal
};

@class YHSelectButton;
@protocol YHSelectButtonDelegate <NSObject>

@optional;
- (void) tapedSelectButton:(YHSelectButton *)button;

@end

@interface YHSelectButton : UIView

+ (instancetype) YHButtonWithTitle:(NSString *)title ItemImage:(UIImage *)itemImage;

@property (nonatomic , assign) id<YHSelectButtonDelegate> delegate;

@property (nonatomic , assign , readonly) SelectButtonStatus selectStatus;

- (void) setSelectButtonStatus:(SelectButtonStatus) status;

- (void) setTitleLabelFont:(UIFont *)font;

@end
