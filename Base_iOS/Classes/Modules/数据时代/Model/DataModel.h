//
//  DataModel.h
//  Base_iOS
//
//  Created by 蔡卓越 on 2017/7/25.
//  Copyright © 2017年 caizhuoyue. All rights reserved.
//

#import "BaseModel.h"

typedef NS_ENUM(NSInteger, DataType) {//认证类型
    
    DataTypeZMRZ = 0,     //芝麻认证
    DataTypeSQQZPF,       //申请欺诈评分
    DataTypeZMXYPF,       //芝麻信用评分
    DataTypeQZXXRZ,       //欺诈信息认证
    DataTypeHYGZMD,       //行业关注名单
    DataTypeQZGZQD,       //欺诈关注清单
    DataTypeYYSRZ,        //运营商认证
    DataTypeEYSSMRZ,      //二要素实名认证
    DataTypeSYSSMRZ,      //四要素实名认证
};

@class SectionModel;

@interface DataModel : BaseModel

@property (nonatomic, copy) NSString *topTitle;

@property (nonatomic, copy) NSString *topImg;

@property (nonatomic, strong) NSArray *contentArr;  //内容

@property (nonatomic, strong) NSArray *imgArr;      //图标

@property (nonatomic, assign) NSInteger row;

@property (nonatomic, assign) NSInteger num;        //每行分几个

@property (nonatomic, assign) CGFloat topH;         //顶部高度

@property (nonatomic, strong) NSMutableArray <SectionModel *>*sections;

@property (nonatomic, strong) NSArray *typeArr;

//
@property (nonatomic, assign) CGFloat sectionW;

@property (nonatomic, assign) CGFloat sectionH;

@property (nonatomic, assign) CGFloat lineW;

@property (nonatomic, assign) CGFloat lineH;

@end

@interface SectionModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, assign) DataType type;        //认证类型

@end
