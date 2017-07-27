//
//  ZHAddressChooseVC.h
//  ZHCustomer
//
//  Created by  蔡卓越 on 2016/12/29.
//  Copyright © 2016年  caizhuoyue. All rights reserved.
//

#import "TLBaseVC.h"
@class ZHReceivingAddress;

@interface ZHAddressChooseVC : TLBaseVC

@property (nonatomic,strong) NSString *selectedAddrCode;

@property (nonatomic,copy) void(^chooseAddress)(ZHReceivingAddress *address);

//从我的界面进入时显示  为YES
@property (nonatomic,assign) BOOL isDisplay;


@end
