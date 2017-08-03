//
//  CaptchaView.m
//  Base_iOS
//
//  Created by 蔡卓越 on 2017/7/14.
//  Copyright © 2017年 caizhuoyue. All rights reserved.
//

#import "CaptchaView.h"

@implementation CaptchaView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUIWith:frame];
        
    }
    return self;
}

- (void)setUpUIWith:(CGRect)frame
{
    
    self.captchaTf = [[AccountTf alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [self addSubview:self.captchaTf];
    self.captchaTf.rightViewMode = UITextFieldViewModeAlways;
    
    //获得验证码按钮
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, frame.size.height)];
    
    TLTimeButton *captchaBtn = [[TLTimeButton alloc] initWithFrame:CGRectMake(0, 0, 80, frame.size.height - 15) totalTime:60.0];
    captchaBtn.backgroundColor = [UIColor orangeColor];
    self.captchaBtn = captchaBtn;
    
    [self.captchaBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    
    captchaBtn.titleLabel.font = [UIFont thirdFont];
    self.captchaTf.keyboardType = UIKeyboardTypeNumberPad;
    captchaBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    captchaBtn.layer.borderWidth = 1.0;
    captchaBtn.layer.cornerRadius = 4;
    captchaBtn.clipsToBounds = YES;
    captchaBtn.backgroundColor = [UIColor clearColor];
    [captchaBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    captchaBtn.centerY = rightView.height/2.0;
    [rightView addSubview:captchaBtn];
    
    self.captchaTf.rightView = rightView;
    
    
    //    //2.1 添加分割线
    //    UIView *sLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, 20)];
    //    sLine.centerY = captchaBtn.centerY;
    //    sLine.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    //    [captchaBtn addSubview:sLine];
    
}

@end
