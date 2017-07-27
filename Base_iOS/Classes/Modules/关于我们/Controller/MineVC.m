//
//  MineVC.m
//  Base_iOS
//
//  Created by 蔡卓越 on 2017/7/25.
//  Copyright © 2017年 caizhuoyue. All rights reserved.
//

#import "MineVC.h"
#import "MineTableView.h"

@interface MineVC ()

@property (nonatomic, strong) MineGroup *group;

@property (nonatomic, strong) MineTableView *tableView;

@property (nonatomic, strong) UIView *headerView;

@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"";
    
    [self initSubviews];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}

#pragma mark - Init
- (void)initSubviews {

    [self initGroup];
    
    [self initTableView];

    [self initHeaderView];
    
}

- (void)initGroup {

//    BaseWeakSelf;
    
    //商务洽谈
    MineModel *mobile = [MineModel new];
    
    mobile.text = @"商务洽谈";
    mobile.imgName = @"商务洽谈";
    mobile.rightText = @"宓永宝 139 5809 2437";
    
    MineModel *email = [MineModel new];
    
    email.text = @"Email";
    email.imgName = @"邮件";
    email.rightText = @"13958092437@163.com";
    
    //版本号
    MineModel *version = [MineModel new];
    
    version.text = @"版本号";
    version.imgName = @"版本号";
    version.rightText = @"v1.0.0";

    self.group = [MineGroup new];
    
    self.group.sections = @[@[mobile, email], @[version]];
    
}

- (void)initHeaderView {

    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    
    self.tableView.tableHeaderView = self.headerView;
    
    UIImageView *bgIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    
    [self.headerView addSubview:bgIV];
    [bgIV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(0);
        
    }];
    
    UIImageView *iconIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"橙袋"]];
    
    [self.headerView addSubview:iconIV];
    [iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(0);
        make.width.height.mas_equalTo(80);
        make.top.mas_equalTo(44);
        
    }];
    
    UILabel *label = [UILabel labelWithText:@"中立   •   安全   •   专注" textColor:kWhiteColor textFont:15.0];
    
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = kClearColor;
    
    [self.headerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(iconIV.mas_bottom).mas_equalTo(17);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(16);
        
    }];
}

- (void)initTableView {

    self.tableView = [[MineTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49) style:UITableViewStyleGrouped];
    
    self.tableView.mineGroup = self.group;
    
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
