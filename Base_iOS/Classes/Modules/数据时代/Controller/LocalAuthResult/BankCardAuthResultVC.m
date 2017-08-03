//
//  BankCardAuthResultVC.m
//  Base_iOS
//
//  Created by 蔡卓越 on 2017/8/2.
//  Copyright © 2017年 caizhuoyue. All rights reserved.
//

#import "BankCardAuthResultVC.h"

@interface BankCardAuthResultVC ()

@end

@implementation BankCardAuthResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [UIBarButtonItem addLeftItemWithImageName:@"返回" frame:CGRectMake(0, 0, 20, 20) vc:self action:@selector(back)];
    
    [self initSubviews];
    
}

#pragma mark - Init
- (void)initSubviews {
    
    self.view.backgroundColor = kWhiteColor;
    
    CGFloat imageW = kWidth(60);
    
    NSString *result = self.result ? @"认证成功": @"认证失败";
    
    NSString *resultStr = self.result ? @"认证成功": @"认证失败";
    
    UIImageView *resultIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, kWidth(35), imageW, imageW)];
    
    resultIV.image = [UIImage imageNamed:result];
    
    resultIV.layer.cornerRadius = imageW/2.0;
    
    resultIV.clipsToBounds = YES;
    
    resultIV.centerX = self.view.centerX;
    
    [self.view addSubview:resultIV];
    
    UILabel *promptLabel = [UILabel labelWithText:resultStr textColor:[UIColor textColor] textFont:15.0];
    
    promptLabel.frame = CGRectMake(0, resultIV.yy + kWidth(20), kScreenWidth, 16);
    
    promptLabel.backgroundColor = kClearColor;
    promptLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:promptLabel];
    
    if (!self.result) {
        
        NSString *text = self.failureReason;
        
        UILabel *textLbl = [UILabel labelWithText:text textColor:kTextColor textFont:15.0];
        
        textLbl.frame = CGRectMake(15, promptLabel.yy + 35, kScreenWidth - 30, 40);
        
        [self.view addSubview:textLbl];
        
    }
    
}

#pragma mark - Events

- (void)back {
    
    if (self.result) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    } else {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
