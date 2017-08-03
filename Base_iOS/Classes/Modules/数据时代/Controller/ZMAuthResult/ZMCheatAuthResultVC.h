//
//  ZMCheatAuthResultVC.h
//  Base_iOS
//
//  Created by 蔡卓越 on 2017/8/2.
//  Copyright © 2017年 caizhuoyue. All rights reserved.
//

#import "BaseViewController.h"
#import "ZMCheatAuthModel.h"

@interface ZMCheatAuthResultVC : BaseViewController

@property (nonatomic, strong) ZMCheatAuthModel *cheatAuthModel;

@property (nonatomic, assign) BOOL result;              //认证结果

@property (nonatomic, copy) NSString *failureReason;    //失败原因

@end
