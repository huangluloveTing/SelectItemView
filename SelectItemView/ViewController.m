//
//  ViewController.m
//  SelectItemView
//
//  Created by 黄露 on 2017/6/12.
//  Copyright © 2017年 huanglu. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Caculate.h"

#import "UIView+frame.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView * oView = [[UIView alloc] init];
    
    oView.top(10).left(50).width(100).height(100);
    oView.size(CGSizeMake(200, 300));
    oView.backcolor([UIColor redColor]);
    
    DCCaculator * ca = [DCCaculator initWithOriginNum:10];
    ca.add(10).mul(5).add(10).plu(4);
    NSLog(@"result = %f", ca.result);
    
    [self.view addSubview:oView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
