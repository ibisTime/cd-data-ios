//
//  MineCell.m
//  Base_iOS
//
//  Created by 蔡卓越 on 2017/7/26.
//  Copyright © 2017年 caizhuoyue. All rights reserved.
//

#import "MineCell.h"

@interface MineCell ()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *titleLbl;

@property (nonatomic, strong) UIImageView *accessoryImageView;

@end

@implementation MineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.iconImageView];
        self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@20);
            make.height.equalTo(@20);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(15);
            
        }];
        
        //右边箭头
        self.accessoryImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.accessoryImageView];
        [self.accessoryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@7);
            make.height.equalTo(@12);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            
        }];
        self.accessoryImageView.image = [UIImage imageNamed:@"mine_more"];
        
        self.rightLabel = [UILabel labelWithText:@"" textColor:kTextColor2 textFont:15.0];
        
        self.rightLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.rightLabel];
        [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_lessThanOrEqualTo(200);
            make.height.mas_equalTo(15.0);
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(0);
            
        }];
        
        //
        self.titleLbl = [UILabel labelWithText:@"" textColor:kTextColor textFont:15.0];
        [self.contentView addSubview:self.titleLbl];
        [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImageView.mas_right).offset(10);
            
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.right.lessThanOrEqualTo(self.accessoryImageView.mas_left);
        }];
        
        //
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor lineColor];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(0);
            make.width.equalTo(self.mas_width);
            make.height.mas_equalTo(@(kLineHeight));
            make.bottom.equalTo(self.mas_bottom);
        }];
        
    }
    return self;
    
}

- (void)setMineModel:(MineModel *)mineModel {
    
    self.iconImageView.image = [UIImage imageNamed:mineModel.imgName];
    
    self.titleLbl.text = mineModel.text;
    
    self.rightLabel.text = mineModel.rightText;
    
}


@end
