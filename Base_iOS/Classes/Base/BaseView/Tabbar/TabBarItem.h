//
//  TabBarItem.h
//  YS_iOS
//
//  Created by 蔡卓越 on 2017/6/8.
//  Copyright © 2017年 caizhuoyue. All rights reserved.
//

#import "BaseModel.h"

@interface TabBarItem : BaseModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *selectedImgUrl;
@property (nonatomic, copy) NSString *unSelectedImgUrl;
@property (nonatomic, assign) BOOL isSelected;

@end
