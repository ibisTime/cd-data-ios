//
//  ZMFoucsNameVC.m
//  Base_iOS
//
//  Created by 蔡卓越 on 2017/7/27.
//  Copyright © 2017年 caizhuoyue. All rights reserved.
//

#import "ZMFoucsNameVC.h"
#import <ZMCreditSDK/ALCreditService.h>
#import "ZMFoucsModel.h"

@interface ZMFoucsNameVC ()

@property (nonatomic, strong) TLTextField *realName;    //真实姓名

@property (nonatomic, strong) TLTextField *idCard;      //身份证

@end

@implementation ZMFoucsNameVC

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
    
    http.code = @"798016";
    http.parameters[@"idNo"] = self.idCard.text;
    http.parameters[@"realName"] = self.realName.text;
    
    [http postWithSuccess:^(id responseObject) {
        
        ZMFoucsModel *foucsModel = [ZMFoucsModel mj_objectWithKeyValues:responseObject[@"data"]];
        
        if (foucsModel.authorized) {
            
            if (foucsModel.isMatched) {
                
                [TLAlert alertWithSucces:@"您在行业关注名单中"];
                
            } else {
            
                [TLAlert alertWithSucces:@"您不在行业关注名单中"];

            }
            
        } else {
            
            NSString *appId = foucsModel.appId;
            
            NSString *sign = foucsModel.signature;
            
            NSString *params = foucsModel.param;
            
            if (appId && sign && params) {
                
                [[ALCreditService sharedService] queryUserAuthReq:appId sign:sign params:params extParams:nil selector:@selector(result:) target:self];

            } else {
            
                [TLAlert alertWithInfo:@"appId或sign或param为空"];
            }
            
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)result:(NSMutableDictionary *)dic {
    
    NSLog(@"result %@", dic);
    
    if (dic[@"authResult"]) {
        
        TLNetworking *http = [TLNetworking new];
        
        http.code = @"798016";
        
        http.parameters[@"idNo"] = self.idCard.text;
        http.parameters[@"realName"] = self.realName.text;
        
        [http postWithSuccess:^(id responseObject) {
            
            ZMFoucsModel *foucsModel = [ZMFoucsModel mj_objectWithKeyValues:responseObject[@"data"]];
            
            if (foucsModel.isMatched) {
                
                [TLAlert alertWithSucces:@"您已加入行业关注名单"];
                
            } else {
            
                [TLAlert alertWithInfo:@"您还未加入行业关注名单"];
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
