//
//  YHSelectDropView.m
//  YangHe_SCI
//
//  Created by 黄露 on 2017/6/10.
//  Copyright © 2017年 biz_zlq. All rights reserved.
//

#import "YHSelectDropView.h"

@interface YHSelectDropView  ()<UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong) UITableView * tableView;

@property (nonatomic , strong) NSArray * items;

@end

@implementation YHSelectDropView

- (instancetype) initWithFrame:(CGRect)frame {
    if (self= [super initWithFrame:frame]) {
        
    }
    
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    UIView * maskView = [[UIView alloc] initWithFrame:self.bounds];
    maskView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dropViewDisappear)];
    [maskView addGestureRecognizer:tapGesture];
    [self addSubview:maskView];
    
    CGRect tableFrame = self.bounds;
    tableFrame.size.height = tableFrame.size.height/2;
    self.tableView.frame = tableFrame;
    [self addSubview:self.tableView];
    
    self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4];
    
//    self.tableView.backgroundColor = [[UIColor customColorNameWithString:@"f9f9f9"] colorWithAlphaComponent:0.9];
//    if (self.delegate && [self.delegate respondsToSelector:@selector(backgroundColorForScrollRectForSelectDropView:)]) {
//        UIColor * backColor = [self.delegate backgroundColorForScrollRectForSelectDropView:self];
//        if (backColor) {
//            self.tableView.backgroundColor = backColor;
//        }
//    }
}

- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    
    return _tableView;
}

#pragma mark - uitableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * cell_id = @"cell_id";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    
    cell.textLabel.text = self.items[indexPath.row];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    if (self.itemFont) {
        cell.textLabel.font = self.itemFont;
    }
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectDropView:didSelectedIndex:)]) {
        [self.delegate selectDropView:self didSelectedIndex:indexPath.row];
    }
}

- (void) configSelectItems:(NSArray *)items {
    if (items.count > 0 ) {
        self.items = items;
        [self.tableView reloadData];
    }
    
    [self setNeedsLayout];
    [self layoutSubviews];
}


-(void )dropViewDisappear  {
    [self removeFromSuperview];
    if (self.delegate && [self.delegate respondsToSelector:@selector(dismissSelectDropView:)]) {
        [self.delegate dismissSelectDropView:self];
    }
}

- (void) setItemFont:(UIFont *)itemFont {
    _itemFont = itemFont;
}

@end
