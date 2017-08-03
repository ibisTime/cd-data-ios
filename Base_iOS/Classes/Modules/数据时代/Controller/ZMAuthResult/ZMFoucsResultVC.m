//
//  ZMFoucsResultVC.m
//  Base_iOS
//
//  Created by 蔡卓越 on 2017/8/1.
//  Copyright © 2017年 caizhuoyue. All rights reserved.
//

#import "ZMFoucsResultVC.h"

@interface ZMFoucsResultVC ()

@end

@implementation ZMFoucsResultVC

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
    
    NSString *resultStr = self.result ? @"查询成功": @"查询失败";
    
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
    
    if (self.result) {
        
        if (_foucsModel.isMatched) {
            
            [TLAlert alertWithSucces:@"您在行业关注名单中"];
            
        } else {
            
            NSString *text = @"您不在行业关注名单中";
            
            UILabel *textLbl = [UILabel labelWithText:text textColor:kTextColor textFont:15.0];
            
            textLbl.frame = CGRectMake(15, promptLabel.yy + 35, kScreenWidth - 30, 40);
            
            [self.view addSubview:textLbl];
            
        }
        
//        self.scoreTF = [[TLTextField alloc] initWithFrame:CGRectMake(0, promptLabel.yy + kWidth(35), kScreenWidth, 50) leftTitle:@"芝麻信用评分" titleWidth:115 placeholder:@""];
//        
//        self.scoreTF.text = self.scoreModel.zmScore;
//        
//        self.scoreTF.enabled = NO;
//        
//        [self.view addSubview:self.scoreTF];
//        
//        self.realNameTF = [[TLTextField alloc] initWithFrame:CGRectMake(0, self.scoreTF.yy, kScreenWidth, 50) leftTitle:@"姓名" titleWidth:115 placeholder:@""];
//        
//        self.realNameTF.text = self.realName;
//        
//        self.realNameTF.enabled = NO;
//        
//        [self.view addSubview:self.realNameTF];
//        
//        self.idCardTF = [[TLTextField alloc] initWithFrame:CGRectMake(0, self.realNameTF.yy, kScreenWidth, 50) leftTitle:@"身份证号码" titleWidth:115 placeholder:self.idCard];
//        
//        self.idCardTF.enabled = NO;
//        
//        self.idCardTF.text = self.idCard;
//        
//        [self.view addSubview:self.idCardTF];
//        
//        self.realNameTF.hidden = self.scoreModel.authorized ? NO: YES;
//        
//        self.idCardTF.hidden = self.scoreModel.authorized ? NO: YES;
        
    } else {
        
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
