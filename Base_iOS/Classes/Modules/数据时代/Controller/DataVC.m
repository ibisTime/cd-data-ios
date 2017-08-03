//
//  DataVC.m
//  Base_iOS
//
//  Created by 蔡卓越 on 2017/7/25.
//  Copyright © 2017年 caizhuoyue. All rights reserved.
//

#import "DataVC.h"

#import "DataView.h"

#import "RealNameAuthVC.h"
#import "BankCardAuthVC.h"
#import "ZMAuthVC.h"
#import "ZMOPScoreVC.h"
#import "ZMFoucsNameVC.h"
#import "ZMCheatScoreVC.h"
#import "ZMCheatAuthVC.h"
#import "ZMCheatFoucsNameVC.h"
#import "MXOperatorAuthVC.h"

#import <ZMCreditSDK/ALCreditService.h>
#import "MoxieSDK.h"

@interface DataVC ()<MoxieSDKDelegate>

@property (nonatomic, strong) DataView *dataView;

@end

@implementation DataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"数据时代";
    
    [self initDataView];
    
    [self initMXSDK];
}

#pragma mark - Init

- (void)initDataView {

    BaseWeakSelf;
    
    self.bgSV.height -= 49;
    
    self.dataView = [[DataView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49)];
    
    self.dataView.dataBlock = ^(SectionModel *section) {
      
        [weakSelf dataWithSection:section];
    };
    
    [self.bgSV addSubview:self.dataView];
    
    self.bgSV.contentSize = CGSizeMake(kScreenWidth, self.dataView.yy);
}

- (void)initMXSDK {

    [MoxieSDK shared].delegate = self;
    [MoxieSDK shared].mxUserId = kMoXieUserID;
    [MoxieSDK shared].mxApiKey = kMoXieApiKey;
    [MoxieSDK shared].fromController = self;
//    [MoxieSDK shared].cacheDisable = YES;
    
    [MoxieSDK shared].backImageName = @"返回";
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];


}

- (void)dataWithSection:(SectionModel *)section {
    
    switch (section.type) {
            
        case DataTypeZMRZ:
        {
            ZMAuthVC *zmAuthVC = [ZMAuthVC new];
            
            zmAuthVC.title = section.title;
            
            [self.navigationController pushViewController:zmAuthVC animated:YES];
            
        }break;
        
        case DataTypeSQQZPF:
        {
        
            ZMCheatScoreVC *cheatScoreVC = [ZMCheatScoreVC new];
            
            cheatScoreVC.title = section.title;
            
            [self.navigationController pushViewController:cheatScoreVC animated:YES];
            
        }break;
            
        case DataTypeZMXYPF:
        {
        
            ZMOPScoreVC *zmopScoreVC = [ZMOPScoreVC new];
            
            zmopScoreVC.title = section.title;
            
            [self.navigationController pushViewController:zmopScoreVC animated:YES];
            
        }break;
            
        case DataTypeQZXXRZ:
        {
            
            ZMCheatAuthVC *cheatAuthVC = [ZMCheatAuthVC new];
            
            cheatAuthVC.title = section.title;
            
            [self.navigationController pushViewController:cheatAuthVC animated:YES];
            
        }break;
            
        case DataTypeHYGZMD:
        {
        
            ZMFoucsNameVC *foucsNameVC = [ZMFoucsNameVC new];
            
            foucsNameVC.title = section.title;
            
            [self.navigationController pushViewController:foucsNameVC animated:YES];
            
        }break;
            
        case DataTypeQZGZQD:
        {
            ZMCheatFoucsNameVC *cheatFoucsNameVC = [ZMCheatFoucsNameVC new];
            
            cheatFoucsNameVC.title = section.title;
            
            [self.navigationController pushViewController:cheatFoucsNameVC animated:YES];
            
        }break;
            
        case DataTypeYYSRZ:
        {
        
//            if (![TLUser user].message) {
//                
//                [MoxieSDK shared].taskType = @"carrier";
//                
//                [[MoxieSDK shared] startFunction];
//                
//            } else {
//            
//                MXOperatorAuthVC *operatorAuthVC = [MXOperatorAuthVC new];
//                
//                operatorAuthVC.title = @"详情报告";
//                
//                [self.navigationController pushViewController:operatorAuthVC animated:YES];
//            }
            [MoxieSDK shared].taskType = @"carrier";

            [[MoxieSDK shared] startFunction];
            
        }break;
            
        case DataTypeEYSSMRZ:
        {
            //实名认证
            RealNameAuthVC *realNameAuthVC = [RealNameAuthVC new];
            
            realNameAuthVC.title = section.title;
            
            [self.navigationController pushViewController:realNameAuthVC animated:YES];
        }break;
            
        case DataTypeSYSSMRZ:
        {
        
            BankCardAuthVC *bankCardAuthVC = [BankCardAuthVC new];
            
            bankCardAuthVC.title = section.title;
            
            [self.navigationController pushViewController:bankCardAuthVC animated:YES];
            
        }break;
            
        default:
            break;
    }
}

- (void)result:(NSMutableDictionary*)dic{
    NSLog(@"result ");
    
    NSString* system  = [[UIDevice currentDevice] systemVersion];
    if([system intValue]>=7){
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    }
    
}

#pragma mark - MoxieSDKDelegate

-(void)receiveMoxieSDKResult:(NSDictionary*)resultDictionary {
    
    int code = [resultDictionary[@"code"] intValue];
    NSString *taskType = resultDictionary[@"taskType"];
    NSString *taskId = resultDictionary[@"taskId"];
    NSString *searchId = resultDictionary[@"searchId"];
    NSString *message = resultDictionary[@"message"];
    NSString *account = resultDictionary[@"account"];
    NSLog(@"get import result---code:%d,taskType:%@,taskId:%@,searchId:%@,message:%@,account:%@",code,taskType,taskId,searchId,message,account);
    
    [TLUser user].message = message;
    
    NSDictionary *userInfo = @{@"message": message};
    
    [[TLUser user] saveUserInfo:userInfo];

    if(code == 2) {
        //继续查询该任务进展
        
        [TLAlert alertWithInfo:@"继续查询该任务进展"];
        
    } else if(code == 1) {
        //code是1则成功
        [TLAlert alertWithSucces:@"查询成功"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.navigationController popViewControllerAnimated:YES];
        });
        
    } else if(code == -1) {
        //用户没有做任何操作
        
//        [TLAlert alertWithInfo:@"用户没有做任何操作"];
        
    } else if(code == -2) {
        //用户没有做任何操作
        
        [TLAlert alertWithInfo:@"平台方服务问题"];
        
    } else if(code == -3) {
        //用户没有做任何操作
        
        [TLAlert alertWithInfo:@"魔蝎数据服务异常"];
        
    }else if(code == -4) {
        //用户没有做任何操作
        
        [TLAlert alertWithInfo:@"用户输入出错"];
        
    }else {
        
        //该任务失败按失败处理
        [TLAlert alertWithError:@"查询失败"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
