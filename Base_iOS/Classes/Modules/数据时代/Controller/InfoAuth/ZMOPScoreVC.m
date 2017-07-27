//
//  ZMOPScoreVC.m
//  Base_iOS
//
//  Created by 蔡卓越 on 2017/7/26.
//  Copyright © 2017年 caizhuoyue. All rights reserved.
//

#import "ZMOPScoreVC.h"
#import <ZMCreditSDK/ALCreditService.h>
#import "ZMScoreModel.h"

@interface ZMOPScoreVC ()

@property (nonatomic, strong) TLTextField *realName;    //真实姓名

@property (nonatomic, strong) TLTextField *idCard;      //身份证

@end

@implementation ZMOPScoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initSubviews];

}

- (void)viewWillAppear:(BOOL)animated {

    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIColor createImageWithColor:kAppCustomMainColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
}

- (void)viewDidDisappear:(BOOL)animated {

    self.navigationController.navigationBar.translucent = YES;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIColor createImageWithColor:kBlackColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];

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
    }
    
    TLNetworking *http = [TLNetworking new];
    
    http.code = @"798015";
    http.parameters[@"idNo"] = self.idCard.text;
    http.parameters[@"realName"] = self.realName.text;

    
    [http postWithSuccess:^(id responseObject) {
        
        ZMScoreModel *scoreModel = [ZMScoreModel mj_objectWithKeyValues:responseObject[@"data"]];
        
        if (scoreModel.authorized) {
            
            [TLAlert alertWithSucces:[NSString stringWithFormat:@"查询成功, 您的芝麻信用分是%@分",scoreModel.zmScore]];
            
            
        } else {
            
            NSString *appId = scoreModel.appId;
            
            NSString *sign = scoreModel.signature;
            
            NSString *params = scoreModel.param;
            
            if (appId && sign && params) {
                
                [[ALCreditService sharedService] queryUserAuthReq:appId sign:sign params:params extParams:nil selector:@selector(result:) target:self];
                
            } else {
                
                [TLAlert alertWithInfo:@"appId或sign或param为空"];
            }
            
        }
        
    } failure:^(NSError *error) {
        
    }];
}

//- (void)userAuth {
//
//    TLNetworking *http = [TLNetworking new];
//    
//    http.code = @"798017";
//    http.parameters[@"idNo"] = self.idCard.text;
//    http.parameters[@"realName"] = self.realName.text;
//    
//    [http postWithSuccess:^(id responseObject) {
//        
//        NSString *appId = responseObject[@"data"][@"appId"];
//        
//        NSString *sign = responseObject[@"data"][@"signature"];
//        
//        NSString *params = responseObject[@"data"][@"param"];
//        
//        [[ALCreditService sharedService] queryUserAuthReq:appId sign:sign params:params extParams:nil selector:@selector(result:) target:self];
//        
//    } failure:^(NSError *error) {
//        
//    }];
//}

//查询芝麻信用分
//- (void)queryCreditScoreWithOpenId:(NSString *)openId {
//
//    TLNetworking *http = [TLNetworking new];
//    
//    http.code = @"798015";
//    http.parameters[@"openId"] = openId;
//    
//    [http postWithSuccess:^(id responseObject) {
//        
//        NSString *appId = responseObject[@"data"][@"appId"];
//        
//        NSString *sign = responseObject[@"data"][@"signature"];
//        
//        NSString *params = responseObject[@"data"][@"param"];
//        
//        [[ALCreditService sharedService] queryUserAuthReq:appId sign:sign params:params extParams:nil selector:@selector(result:) target:self];
//        
//    } failure:^(NSError *error) {
//        
//    }];
//
//}

- (void)result:(NSMutableDictionary *)dic {

    NSLog(@"result %@", dic);
    
    if (dic[@"authResult"]) {
        
        TLNetworking *http = [TLNetworking new];
        
        http.code = @"798015";
        
        http.parameters[@"idNo"] = self.idCard.text;
        http.parameters[@"realName"] = self.realName.text;
        
        [http postWithSuccess:^(id responseObject) {
            
            ZMScoreModel *scoreModel = [ZMScoreModel mj_objectWithKeyValues:responseObject[@"data"]];
            
            if (scoreModel.authorized) {
                
                [TLAlert alertWithSucces:[NSString stringWithFormat:@"查询成功, 您的芝麻信用分是%@分",scoreModel.zmScore]];
                
            }
            
        } failure:^(NSError *error) {
            
        }];
        
    } else {
    
        [TLAlert alertWithError:@"授权失败"];
    }

}

- (void)next:(UITextField *)sender {
    
    [self.idCard becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
