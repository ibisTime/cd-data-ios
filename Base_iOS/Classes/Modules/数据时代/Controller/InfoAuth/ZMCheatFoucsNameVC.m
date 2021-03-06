//
//  ZMCheatFoucsNameVC.m
//  Base_iOS
//
//  Created by 蔡卓越 on 2017/7/27.
//  Copyright © 2017年 caizhuoyue. All rights reserved.
//

#import "ZMCheatFoucsNameVC.h"
#import "AddressPickerView.h"
#import "ZMCheatFoucsModel.h"

#import "ZMCheatFoucsResultVC.h"

@interface ZMCheatFoucsNameVC ()

@property (nonatomic, strong) TLTextField *realName;    //真实姓名

@property (nonatomic, strong) TLTextField *idCard;      //身份证

@property (nonatomic, strong) TLTextField *bankCard;    //银行卡

@property (nonatomic, strong) TLTextField *mobile;      //预留手机号

@property (nonatomic, strong) TLTextField *email;       //邮箱

@property (nonatomic, strong) TLTextField *detailAddress;   //详细地址

@property (nonatomic, strong) TLTextField *address;     //地址;

//
@property (nonatomic,strong) AddressPickerView *addressPicker;

@property (nonatomic,copy) NSString *province;
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *area;

@end

@implementation ZMCheatFoucsNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initSubviews];
    
}

#pragma mark - Init

- (AddressPickerView *)addressPicker {
    
    if (!_addressPicker) {
        
        _addressPicker = [[AddressPickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        
        __weak typeof(self) weakSelf = self;
        _addressPicker.confirm = ^(NSString *province,NSString *city,NSString *area){
            
            weakSelf.province = province;
            weakSelf.city = city;
            weakSelf.area = area;
            
            weakSelf.address.text = [NSString stringWithFormat:@"%@ %@ %@",weakSelf.province,weakSelf.city,weakSelf.area];
            
        };
        
    }
    return _addressPicker;
    
}

- (void)initSubviews {
    
    CGFloat leftMargin = 15;
    
    self.realName = [[TLTextField alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50) leftTitle:@"姓名" titleWidth:105 placeholder:@"请输入姓名"];
    
    self.realName.returnKeyType = UIReturnKeyNext;
    
    [self.realName addTarget:self action:@selector(next:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [self.view addSubview:self.realName];
    
    self.idCard = [[TLTextField alloc] initWithFrame:CGRectMake(0, self.realName.yy, kScreenWidth, 50) leftTitle:@"身份证号码" titleWidth:105 placeholder:@"请输入身份证号码"];
    
    [self.view addSubview:self.idCard];
    
    self.mobile = [[TLTextField alloc] initWithFrame:CGRectMake(0, self.idCard.yy, kScreenWidth, 50) leftTitle:@"手机号" titleWidth:105 placeholder:@"请输入手机号(选填)"];
    
    self.mobile.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.view addSubview:self.mobile];
    
    self.bankCard = [[TLTextField alloc] initWithFrame:CGRectMake(0, self.mobile.yy, kScreenWidth, 50) leftTitle:@"银行卡号" titleWidth:105 placeholder:@"请输入银行卡号(选填)"];
    
    self.bankCard.keyboardType = UIKeyboardTypeNumberPad;

    [self.view addSubview:self.bankCard];
    
    self.email = [[TLTextField alloc] initWithFrame:CGRectMake(0, self.bankCard.yy, kScreenWidth, 50) leftTitle:@"邮箱" titleWidth:105 placeholder:@"请输入邮箱(选填)"];
    
    [self.view addSubview:self.email];
    
    self.address = [[TLTextField alloc] initWithFrame:CGRectMake(0, self.email.yy, kScreenWidth, 50) leftTitle:@"省市区" titleWidth:105 placeholder:@"请选择省市区(选填)"];
    
    [self.view addSubview:self.address];
    
    self.detailAddress = [[TLTextField alloc] initWithFrame:CGRectMake(0, self.address.yy, kScreenWidth, 50) leftTitle:@"详细地址" titleWidth:105 placeholder:@"请输入详细地址(选填)"];
    
    [self.view addSubview:self.detailAddress];
    
    UIButton *confirmBtn = [UIButton buttonWithTitle:@"确认" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:15.0 cornerRadius:5];
    
    confirmBtn.frame = CGRectMake(leftMargin, self.detailAddress.yy + 40, kScreenWidth - 2*leftMargin, 45);
    
    [confirmBtn addTarget:self action:@selector(confirmIDCard:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:confirmBtn];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:self.address.bounds];
    [self.address addSubview:btn];
    [btn addTarget:self action:@selector(chooseAddress) forControlEvents:UIControlEventTouchUpInside];
    
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
    
    [self.view endEditing:YES];

    NSString *address = [NSString stringWithFormat:@"%@%@", self.address.text, self.detailAddress.text];
    
    TLNetworking *http = [TLNetworking new];
    
    http.isShowMsg = NO;
    http.showView = self.view;

    http.code = @"798021";
    http.parameters[@"idNo"] = self.idCard.text;
    http.parameters[@"realName"] = self.realName.text;
    http.parameters[@"bankCard"] = self.bankCard.text;
    http.parameters[@"mobile"] = self.mobile.text;
    http.parameters[@"address"] = address;
    http.parameters[@"ip"] = [NSString getIPAddress:YES];
    http.parameters[@"wifimac"] = [NSString getWifiMacAddress];
    //获取不到
    http.parameters[@"mac"] = @"";
    //获取不到
    http.parameters[@"imei"] = @"";
    
    //
    [http postWithSuccess:^(id responseObject) {
        
        ZMCheatFoucsResultVC *resultVC = [ZMCheatFoucsResultVC new];
        
        resultVC.title = @"欺诈关注清单结果";
        
        if ([responseObject[@"errorCode"] isEqual:@"0"]) {

            ZMCheatFoucsModel *foucsModel = [ZMCheatFoucsModel mj_objectWithKeyValues:responseObject[@"data"]];

            resultVC.foucsModel = foucsModel;
            
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

- (void)chooseAddress {
    
    [self.view endEditing:YES];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.addressPicker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
