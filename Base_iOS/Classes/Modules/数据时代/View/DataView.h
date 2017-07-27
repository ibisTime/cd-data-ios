//
//  DataView.h
//  Base_iOS
//
//  Created by 蔡卓越 on 2017/7/25.
//  Copyright © 2017年 caizhuoyue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"

typedef void(^DataSelectBlock)(SectionModel *section);

@interface DataView : UIView

@property (nonatomic, copy) DataSelectBlock dataBlock;

- (instancetype)initWithFrame:(CGRect)frame;

@end
