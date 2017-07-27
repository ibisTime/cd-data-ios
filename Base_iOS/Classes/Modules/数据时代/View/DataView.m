//
//  DataView.m
//  Base_iOS
//
//  Created by 蔡卓越 on 2017/7/25.
//  Copyright © 2017年 caizhuoyue. All rights reserved.
//

#import "DataView.h"

@interface DataView ()

@property (nonatomic, strong) NSMutableArray <DataModel *>*datas;

@end

@implementation DataView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = kPaleGreyColor;
        
        self.datas = [NSMutableArray array];
        
        [self initData];
        
        [self initSubviews];
    }
    
    return self;
}

#pragma mark - Init

- (void)initData {

    NSArray *topTitleArr = @[@"信息认证", @"魔蝎认证", @"本地认证"];
    
    NSArray *contentArr = @[@[@"芝麻认证", @"申请欺诈评分", @"芝麻信用评分", @"欺诈信息认证", @"行业关注名单", @"欺诈关注清单"], @[@"运营商认证", @""], @[@"二要素实名认证", @"四要素实名认证"]];
    
    NSArray *imgArr = @[@[@"芝麻认证", @"申请欺诈评分", @"芝麻信用评分", @"欺诈信息认证", @"行业关注名单", @"欺诈关注清单"], @[@"运营商认证", @""], @[@"2", @"4"]];
    
    NSArray *typeArr = @[@[@(DataTypeZMRZ), @(DataTypeSQQZPF), @(DataTypeZMXYPF), @(DataTypeQZXXRZ), @(DataTypeHYGZMD), @(DataTypeQZGZQD)], @[@(DataTypeYYSRZ), @(DataTypeYYSRZ)], @[@(DataTypeEYSSMRZ), @(DataTypeSYSSMRZ)]];
    
    for (int i = 0; i < topTitleArr.count; i++) {
        
        DataModel *dataModel = [DataModel new];
        
        dataModel.topTitle = topTitleArr[i];
        
        dataModel.contentArr = contentArr[i];
        
        dataModel.imgArr = imgArr[i];
        
        dataModel.typeArr = typeArr[i];
        
        dataModel.row = dataModel.contentArr.count;
        
        dataModel.num = 2;
        
        dataModel.topH = kHeight(45);
        
        dataModel.sectionW = kScreenWidth/(dataModel.num*1.0);
        
        dataModel.sectionH = kHeight(82);
        
        dataModel.lineW = 1;
        
        dataModel.lineH = 1;
        
        NSMutableArray *sections = [NSMutableArray array];
        //导入图片和文字
        for (int i = 0; i < dataModel.contentArr.count; i++) {
            
            
            SectionModel *section = [SectionModel new];
            
            section.title = dataModel.contentArr[i];
            
            section.img = dataModel.imgArr[i];
            
            section.type = [dataModel.typeArr[i] integerValue];
            
            [sections addObject:section];
            
        }
        
        dataModel.sections = sections;
        
        [self.datas addObject:dataModel];

    }
    
}

- (void)initSubviews {
    
    CGFloat sectionH = 0;

    for (int j = 0; j < self.datas.count; j++) {
        
        DataModel *data = self.datas[j];
        
        CGFloat leftMargin = kScreenWidth - data.sectionW*data.num;
        
        CGFloat viewH = data.topH + data.row/2*(data.sectionH + data.lineH);

        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(leftMargin, 10*j+ sectionH, kScreenWidth - 2*leftMargin, viewH)];
        
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(leftMargin, 0, kScreenWidth - 2*leftMargin, data.topH)];
        
        topView.backgroundColor = kWhiteColor;
        
        [bgView addSubview:topView];
        
        UIView *leftLine = [[UIView alloc] initWithFrame:CGRectMake(kWidth(15), (data.topH - 12)/2.0, 3, 12)];
        
        leftLine.backgroundColor = kAppCustomMainColor;
        
        [topView addSubview:leftLine];
        
        UILabel *textLabel = [UILabel labelWithText:data.topTitle textColor:kTextColor textFont:kWidth(14.0)];
        
        [topView addSubview:textLabel];
        [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(leftLine.mas_right).mas_equalTo(6);
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(16);
            
        }];
        
        for (int i = 0; i < data.sections.count; i++) {
            
            NSInteger num = data.num;
            
            CGFloat viewW = data.sectionW;
            
            CGFloat viewH = data.sectionH;
            
            CGFloat lineW = data.lineW;
            
            CGFloat lineH = data.lineH;
            
            UIButton *btn = [UIButton buttonWithTitle:@"" titleColor:kTextColor backgroundColor:kWhiteColor titleFont:13.0];
            
            btn.tag = 2000 + 100*j + i;
            
            btn.frame = CGRectMake(i%num*(viewW + lineW), i/num*(viewH + lineH) + data.topH, viewW, viewH);
            
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, kWidth(70), 0, 0);
            
            [btn addTarget:self action:@selector(selectTestType:) forControlEvents:UIControlEventTouchUpInside];
            
            [bgView addSubview:btn];
            
            UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:data.imgArr[i]]];

            iv.frame = CGRectMake(kWidth(15), 0, kWidth(40), kWidth(40));
            
            iv.centerY = btn.height/2.0;
            
            [btn addSubview:iv];
            
            UILabel *label = [UILabel labelWithText:data.contentArr[i] textColor:kTextColor textFont:kWidth(13.0)];
            
            label.frame = CGRectMake(kWidth(70), 0, 110, 15);
            
            label.centerY = btn.height/2.0;
            
            [btn addSubview:label];
            
            UIView *wLine = [[UIView alloc] initWithFrame:CGRectMake(i%num*viewW, (i/num)*viewH + data.topH, viewW, lineH)];
            
            wLine.backgroundColor = kPaleGreyColor;
            
            [bgView addSubview:wLine];
            
            UIView *hLine = [[UIView alloc] initWithFrame:CGRectMake((i%num+1)*viewW, i/num*viewH + data.topH, lineW, viewH)];
            
            hLine.backgroundColor = kPaleGreyColor;
            
            [bgView addSubview:hLine];
            
        }
        
        sectionH += viewH;

        [self addSubview:bgView];
    }
    
    self.height = sectionH + 10*(self.datas.count - 1);
    
    
}

#pragma mark - Events

- (void)selectTestType:(UIButton *)sender {
    
    NSInteger i = sender.tag%100;
    
    NSInteger j = (sender.tag-2000)/100;

    DataModel *dataModel = self.datas[j];
    
    SectionModel *section = dataModel.sections[i];
    
    if (_dataBlock) {
        
        _dataBlock(section);
    }
    
}

@end
