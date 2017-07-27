//
//  ZMCheatAuthModel.h
//  Base_iOS
//
//  Created by 蔡卓越 on 2017/7/27.
//  Copyright © 2017年 caizhuoyue. All rights reserved.
//

#import "BaseModel.h"

@interface ZMCheatAuthModel : BaseModel

@property (nonatomic, copy) NSString *bizNo;

@property (nonatomic, strong) NSArray<NSString *> *verifyCodeList;

@end
