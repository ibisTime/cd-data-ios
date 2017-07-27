//
//  MineModel.h
//  Base_iOS
//
//  Created by 蔡卓越 on 2017/7/26.
//  Copyright © 2017年 caizhuoyue. All rights reserved.
//

#import "BaseModel.h"

@interface MineModel : BaseModel

@property (nonatomic,copy) NSString *imgName;
@property (nonatomic,copy) NSString *text;
@property (nonatomic, copy) NSString *rightText;

@property (nonatomic,strong) void(^action)();

@end
