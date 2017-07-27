//
//  ZHAddressCell.m
//  ZHCustomer
//
//  Created by  caizhuoyue on 2016/12/29.
//  Copyright © 2016年  caizhuoyue. All rights reserved.
//

#import "ZHAddressCell.h"

#define ADDRESS_CHANGE_NOTIFICATION @"ADDRESS_CHANGE_NOTIFICATION"

@interface ZHAddressCell()

@property (nonatomic,strong) UILabel *infoLbl;
@property (nonatomic,strong) UILabel *addressLbl;
@property (nonatomic,strong) UILabel *detailAddressLbl;
@property (nonatomic, strong) UILabel *mobileLbl;

@property (nonatomic,strong) UIButton *selectedBtn;

@property (nonatomic, strong) UIButton *editBtn;

@property (nonatomic, strong) UIView *line;

@end


@implementation ZHAddressCell

- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat leftMargin = 15;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addressChangeAction:) name:ADDRESS_CHANGE_NOTIFICATION object:nil];

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //1.
        self.infoLbl = [UILabel labelWithFrame:CGRectMake(leftMargin, leftMargin, kScreenWidth - 15 - 120 - 15, 18)
                                  textAligment:NSTextAlignmentLeft
                               backgroundColor:[UIColor clearColor]
                                          font:[UIFont secondFont]
                                     textColor:[UIColor zh_textColor]];
        [self addSubview:self.infoLbl];
        self.infoLbl.height = [[UIFont secondFont] lineHeight];
        
        
        self.mobileLbl = [UILabel labelWithFrame:CGRectMake(kScreenWidth - 15 - 120, leftMargin, 120, 18)
                                    textAligment:NSTextAlignmentRight
                                 backgroundColor:[UIColor clearColor]
                                            font:[UIFont secondFont]
                                       textColor:[UIColor zh_textColor]];
        
        [self addSubview:self.mobileLbl];
        self.mobileLbl.height = [FONT(15) lineHeight];

        //2.
        self.addressLbl = [UILabel labelWithFrame:CGRectMake(leftMargin, self.infoLbl.yy + 15 , kScreenWidth - 30, 0)
                                  textAligment:NSTextAlignmentLeft
                               backgroundColor:[UIColor clearColor]
                                          font:FONT(15)
                                     textColor:[UIColor zh_textColor]];
        self.addressLbl.numberOfLines = 0;
        [self addSubview:self.addressLbl];
        self.addressLbl.height = [FONT(15) lineHeight];
        
        //
//        self.detailAddressLbl = [UILabel labelWithFrame:CGRectMake(leftMargin, self.addressLbl.yy + 10 , self.infoLbl.width, self.addressLbl.height)
//                                     textAligment:NSTextAlignmentLeft
//                                  backgroundColor:[UIColor clearColor]
//                                             font:FONT(13)
//                                        textColor:[UIColor zh_textColor]];
//        [self addSubview:self.detailAddressLbl];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.addressLbl.yy + leftMargin, kScreenWidth, kLineHeight)];
        line.backgroundColor = [UIColor zh_lineColor];
        [self addSubview:line];
        self.line = line;
        //
        self.selectedBtn = [[UIButton alloc] initWithFrame:CGRectMake(leftMargin, line.yy + 5, 20, 20)];
        [self addSubview:self.selectedBtn];
        [self.selectedBtn setImage:[UIImage imageNamed:@"address_unselected"] forState:UIControlStateNormal];
        [self.selectedBtn addTarget:self action:@selector(selectedAddress) forControlEvents:UIControlEventTouchUpInside];
        
        
        //编ewe辑 和 删除
//        CGFloat w = 70;
//        UIButton *deleteBtn = [self btnWithFrame:CGRectMake(kScreenWidth - w, 110, w, 30) imageName:@"delete" title:@"删除"];
//        [deleteBtn addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:deleteBtn];
//        deleteBtn.xx_size = kScreenWidth - 10;
//        UIButton *editBtn = [self btnWithFrame:CGRectMake(0, 110, w, deleteBtn.height) imageName:@"edit" title:@"编辑"];
//        [editBtn addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
//        editBtn.xx_size = deleteBtn.x - 15;
//        [self addSubview:editBtn];

        //编辑按钮

        CGFloat w = 70;
        UIButton *editBtn = [self btnWithFrame:CGRectMake(kScreenWidth - w, line.yy, w, 30) imageName:@"edit" title:@"编辑"];
        [editBtn addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:editBtn];
        editBtn.xx_size = kScreenWidth - 10;
        self.editBtn = editBtn;
    }
    

    
    return self;

}

- (UIButton *)btnWithFrame:(CGRect )frame imageName:(NSString *)imageName title:(NSString *)title {

    UIButton *editBtn = [[UIButton alloc] initWithFrame:frame];
    [self addSubview:editBtn];
    editBtn.titleLabel.font = FONT(14);
    [editBtn setTitleColor:[UIColor zh_textColor] forState:UIControlStateNormal];
    [editBtn setTitle:title forState:UIControlStateNormal];
    editBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [editBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    return editBtn;

}

#pragma mark- 删除收货地址
- (void)delete {

    if (self.deleteAddr) {
        
        __weak typeof(self) weakSelf = self;
        self.deleteAddr(weakSelf);
        
    }

}

#pragma mark- 便捷收货地址
- (void)edit {

    if (self.editAddr) {
        
        __weak typeof(self) weakSelf = self;
        self.editAddr(weakSelf);
        
    }

}


- (void)addressChangeAction:(NSNotification *)noti {

    id obj = noti.userInfo[@"sender"];
    
    if (self.address.isSelected) {
        
        self.address.isSelected = NO;
        [self.selectedBtn setImage:[UIImage imageNamed:@"address_unselected"] forState:UIControlStateNormal];
        return;
    }
    
    if ([obj isEqual:self]) {
        
        self.address.isSelected = YES;
        [self.selectedBtn setImage:[UIImage imageNamed:@"address_selected"] forState:UIControlStateNormal];
        
    }
    
}

- (void)setIsDisplay:(BOOL)isDisplay {

    _isDisplay = isDisplay;
    
    self.selectedBtn.hidden = isDisplay;

}


- (void)selectedAddress {
    
    //已经是选中状态 return
    if (self.address.isSelected) {
        return;
    }
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:ADDRESS_CHANGE_NOTIFICATION object:self userInfo:@{
//                                                                                                                  @"sender" : self
//                                                                                                                  }];

    
}


- (void)setAddress:(ZHReceivingAddress *)address {

    _address = address;

    self.infoLbl.text = [NSString stringWithFormat:@"%@",_address.addressee];
    
    self.mobileLbl.text = _address.mobile;
    
    self.addressLbl.text = [NSString stringWithFormat:@"%@ %@ %@ %@",_address.province,_address.city,_address.district, _address.detailAddress];
    
    CGSize size = [self.addressLbl.text calculateStringSize:CGSizeMake(kScreenWidth - 30, MAXFLOAT) font:self.addressLbl.font];
    
    self.addressLbl.height = size.height;
    
    //更新布局
    self.line.y = self.addressLbl.yy + 15;

    self.selectedBtn.y = self.line.yy + 5;
    
    self.editBtn.y = self.line.yy;

    _address.cellHeight = 15 + 15 + 15 + size.height + 15 + 30;
    

    if (address.isSelected) {
        
        [self.selectedBtn setImage:[UIImage imageNamed:@"address_selected"] forState:UIControlStateNormal];
        
    }
}


- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
