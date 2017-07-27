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

#import <ZMCreditSDK/ALCreditService.h>

@interface DataVC ()

@property (nonatomic, strong) DataView *dataView;

@end

@implementation DataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"数据时代";
    
    [self initDataView];
}

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
