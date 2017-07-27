//
//  ZMAuthVC.m
//  Base_iOS
//
//  Created by 蔡卓越 on 2017/7/26.
//  Copyright © 2017年 caizhuoyue. All rights reserved.
//

#import "ZMAuthVC.h"
#import <ZMCert/ZMCert.h>

@interface ZMAuthVC ()

@property (nonatomic, strong) TLTextField *realName;    //真实姓名
@property (nonatomic, strong) TLTextField *idCard;      //身份证

@end

@implementation ZMAuthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initSubviews];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(realNameAuth) name:@"realNameSuccess" object:nil];

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
    
    UIButton *confirmBtn = [UIButton buttonWithTitle:@"确认" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:15.0 cornerRadius:5];
    
    confirmBtn.frame = CGRectMake(leftMargin, self.idCard.yy + 40, kScreenWidth - 2*leftMargin, 45);
    
    [confirmBtn addTarget:self action:@selector(confirmIDCard:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:confirmBtn];
    
    
}

#pragma mark - Notification

- (void)realNameAuth {

    [TLAlert alertWithSucces:@"实名认证成功"];

    [TLUser user].idNo = self.idCard.text;
    
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark - Events

- (void)next:(UITextField *)sender {
    
    [self.idCard becomeFirstResponder];
}

- (void)confirmIDCard:(UIButton *)sender {
    
    BaseWeakSelf;
    
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
    }
    
    TLNetworking *http = [TLNetworking new];
    
    http.code = @"798013";
    http.parameters[@"idKind"] = @"1";
    http.parameters[@"idNo"] = self.idCard.text;
    http.parameters[@"realName"] = self.realName.text;
    http.parameters[@"userId"] = @"U1234567898";
    http.parameters[@"remark"] = @"芝麻认证";
    http.parameters[@"localCheck"] = @"0";
    http.parameters[@"returnUrl"] = @"cddata://certi.back";
    
    [http postWithSuccess:^(id responseObject) {
        
        NSString *bizNo = responseObject[@"data"][@"bizNo"];

        [TLUser user].tempBizNo = bizNo;
        
        [self doVerify:responseObject[@"data"][@"url"]];

//        NSString *merchantId = responseObject[@"data"][@"merchantId"];
//        
//        ZMCertification *manager = [[ZMCertification alloc] init];
//
//        [manager startWithBizNO:bizNo merchantID:merchantId extParams:nil viewController:self onFinish:^(BOOL isCanceled, BOOL isPassed, ZMStatusErrorType errorCode) {
//            
//            if (isCanceled) {
//                
//                [TLAlert alertWithError:@"用户取消了认证"];
//
//            }else{
//                if (isPassed) {
//                    
//                    [TLAlert alertWithSucces:@"认证成功"];
//                    
//                }else{
//                    
//                    [TLAlert alertWithError:[NSString stringWithFormat:@"认证失败了 %zi", errorCode]];
//                    
//                }
//            }
//        }];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)doVerify:(NSString *)url {
    // 这里使用固定appid 20000067
    NSString *alipayUrl = [NSString stringWithFormat:@"alipays://platformapi/startapp?appId=20000067&url=%@",
                           [self URLEncodedStringWithUrl:url]];
    
    if ([self canOpenAlipay]) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:alipayUrl]];

//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:alipayUrl] options:@{} completionHandler:nil];
        
    } else {
        
        [TLAlert alertWithTitle:@"是否下载并安装支付宝完成认证?" msg:@"" confirmMsg:@"好的" cancleMsg:@"取消" cancle:^(UIAlertAction *action) {
            
        } confirm:^(UIAlertAction *action) {
            
            NSString *appstoreUrl = @"itms-apps://itunes.apple.com/app/id333206289";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appstoreUrl] options:@{} completionHandler:nil];
            
        }];
        
    }
}

- (NSString *)URLEncodedStringWithUrl:(NSString *)url {
    
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)url,NULL,(CFStringRef) @"!'();:@&=+$,%#[]|",kCFStringEncodingUTF8));
    return encodedString;
}

- (BOOL)canOpenAlipay {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipays://"]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
