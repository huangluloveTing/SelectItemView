//
//  YHSelectButton.m
//  YangHe_SCI
//
//  Created by 黄露 on 2017/6/9.
//  Copyright © 2017年 biz_zlq. All rights reserved.
//

#import "YHSelectButton.h"

@interface YHSelectButton ()

@property (weak, nonatomic) IBOutlet UIButton *selectButton;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation YHSelectButton


+ (instancetype) YHButtonWithTitle:(NSString *)title ItemImage:(UIImage *)itemImage  {
    
    YHSelectButton * select = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([YHSelectButton class]) owner:nil options:nil].firstObject;
    
    [select configViewWithTitle:title AndImage:itemImage];
    
    return select;
}

- (void) configViewWithTitle:(NSString *)title AndImage:(UIImage *)image {
    [self.selectButton setTitle:title forState:UIControlStateNormal];
    [self.selectButton setTitle:title forState:UIControlStateSelected];
    self.imageView.image = image;
}

- (IBAction)buttonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self animationTaped];
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapedSelectButton:)]) {
        [self.delegate tapedSelectButton:self];
    }
}

- (void) tapImageView {
    [self buttonAction:self.selectButton];
}

- (void) awakeFromNib {
    [super awakeFromNib];
    
    self.selectButton.backgroundColor = [UIColor whiteColor];
    [self.selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    self.selectButton.selected = NO;
    
    self.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView)];
    [self.imageView addGestureRecognizer:tapGesture];
}

- (void) animationTaped {
    if (self.selectButton.selected) {
        [UIView animateWithDuration:0.2 animations:^{
            self.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    }
    else {
        
        [UIView animateWithDuration:0.25 animations:^{
            self.imageView.transform = CGAffineTransformIdentity;
        }];
    }
}

- (SelectButtonStatus) selectStatus {
    return self.selectButton.selected ? SelectButton_selected : SelectButton_Normal;
}

- (void) setSelectButtonStatus:(SelectButtonStatus)status {
    switch (status) {
        case SelectButton_Normal:
        {
            self.selectButton.selected = NO;
            [self animationTaped];
        }
            break;
            
        case SelectButton_selected:
        {
            self.selectButton.selected = YES;
            [self animationTaped];
        }
            break;
            
        default:
            break;
    }
}

- (void) setTitleLabelFont:(UIFont *)font {
    if (font) {
        self.selectButton.titleLabel.font = font;
    }
}

@end
