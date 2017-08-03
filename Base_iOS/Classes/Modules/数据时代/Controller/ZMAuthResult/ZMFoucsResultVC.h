//
//  ZMFoucsResultVC.h
//  Base_iOS
//
//  Created by 蔡卓越 on 2017/8/1.
//  Copyright © 2017年 caizhuoyue. All rights reserved.
//

#import "BaseViewController.h"
#import "ZMFoucsModel.h"

@interface ZMFoucsResultVC : BaseViewController

@property (nonatomic, strong) ZMFoucsModel *foucsModel;

@property (nonatomic, assign) BOOL result;          //认证结果

@property (nonatomic, copy) NSString *failureReason;   //失败原因

@end
