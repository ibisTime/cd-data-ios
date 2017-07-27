//
//  MineGroup.h
//  Base_iOS
//
//  Created by 蔡卓越 on 2017/7/26.
//  Copyright © 2017年 caizhuoyue. All rights reserved.
//

#import "BaseModel.h"
#import "MineModel.h"

@interface MineGroup : BaseModel

@property (nonatomic,copy) NSArray <MineModel *>*items;

@property (nonatomic, copy) NSArray *sections;    //分组

@end
