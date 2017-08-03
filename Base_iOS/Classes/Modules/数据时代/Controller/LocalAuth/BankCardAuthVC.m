//
//  BankCardAuthVC.m
//  Base_iOS
//
//  Created by 蔡卓越 on 2017/7/26.
//  Copyright © 2017年 caizhuoyue. All rights reserved.
//

#import "BankCardAuthVC.h"
#import "BankCardAuthResultVC.h"

@interface BankCardAuthVC ()

@property (nonatomic, strong) TLTextField *realName;    //真实姓名

@property (nonatomic, strong) TLTextField *idCard;      //身份证

@property (nonatomic, strong) TLTextField *bankCard;    //银行卡

@property (nonatomic, strong) TLTextField *mobile;      //预留手机号

@end

@implementation BankCardAuthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initSubviews];

}

#pragma mark - Init
- (void)initSubviews {
    
    CGFloat leftMargin = 15;
    
    self.realName = [[TLTextField alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50) leftTitle:@"姓名" titleWidth:105 placeholder:@"请输入姓名"];
    
    self.realName.returnKeyType = UIReturnKeyNext;
    
    [self.realName addTarget:self action:@selector(next:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [self.view addSubview:self.realName];
    
    self.idCard = [[TLTextField alloc] initWithFrame:CGRectMake(0, self.realName.yy, kScreenWidth, 50) leftTitle:@"身份证号码" titleWidth:105 placeholder:@"请输入身份证号码"];
    
    [self.view addSubview:self.idCard];
    
    self.bankCard = [[TLTextField alloc] initWithFrame:CGRectMake(0, self.idCard.yy, kScreenWidth, 50) leftTitle:@"银行卡号" titleWidth:105 placeholder:@"请输入银行卡号"];
    
    self.bankCard.keyboardType = UIKeyboardTypeNumberPad;

    [self.view addSubview:self.bankCard];
    
    self.mobile = [[TLTextField alloc] initWithFrame:CGRectMake(0, self.bankCard.yy, kScreenWidth, 50) leftTitle:@"手机号" titleWidth:105 placeholder:@"请输入银行预留手机号(选填)"];
    
    self.mobile.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.view addSubview:self.mobile];
    
    UIButton *confirmBtn = [UIButton buttonWithTitle:@"确认" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:15.0 cornerRadius:5];
    
    confirmBtn.frame = CGRectMake(leftMargin, self.mobile.yy + 40, kScreenWidth - 2*leftMargin, 45);
    
    [confirmBtn addTarget:self action:@selector(confirmIDCard:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:confirmBtn];
    
    
}

#pragma mark - Events
- (void)confirmIDCard:(UIButton *)sender {
    
    if (![self.realName.text valid]) {
        
        [TLAlert alertWithInfo:@"请输入姓名"];
        return;
    }
    
    if (![self.idCard.text valid]) {
        
        [TLAlert alertWithInfo:@"请输入身份证号码"];
        return;
    }
    
    if (self.idCard.text.length != 18) {
        
        [TLAlert alertWithInfo:@"请输入18位身份证号码"];
        return;

    }
    
    if (![self.bankCard.text valid]) {
        [TLAlert alertWithInfo:@"请输入银行卡号"];
        return;
    }
    
    if (![self.bankCard.text isBankCardNo]) {
        
        [TLAlert alertWithInfo:@"请输入正确格式的银行卡号"];
        return;
    }
    
    [self.view endEditing:YES];

    TLNetworking *http = [TLNetworking new];
    
    http.isShowMsg = NO;
    http.showView = self.view;

    http.code = @"798006";
    http.parameters[@"idKind"] = @"1";
    http.parameters[@"idNo"] = self.idCard.text;
    http.parameters[@"realName"] = self.realName.text;
    http.parameters[@"userId"] = @"U1234567895";
    http.parameters[@"remark"] = @"橙袋数据";
    http.parameters[@"cardNo"] = self.bankCard.text;
    http.parameters[@"bindMobile"] = self.mobile.text;
    
    [http postWithSuccess:^(id responseObject) {
        
        BankCardAuthResultVC *resultVC = [BankCardAuthResultVC new];
        
        resultVC.title = @"四要素认证结果";
        
        if ([responseObject[@"errorCode"] isEqual:@"0"]) {
            
            resultVC.result = YES;
            
        } else {
            
            resultVC.result = NO;
            
            resultVC.failureReason = responseObject[@"errorInfo"];
            
        }
        
        [self.navigationController pushViewController:resultVC animated:YES];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)next:(UITextField *)sender {
    
    [self.idCard becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
