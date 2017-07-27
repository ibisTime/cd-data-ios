//
//  ShareView.m
//  CityBBS
//
//  Created by 蔡卓越 on 2017/5/26.
//  Copyright © 2017年  caizhuoyue. All rights reserved.
//

#import "ShareView.h"
#import <UMSocialCore/UMSocialCore.h>
#import "UIView+Responder.h"
#import "BaseViewController.h"

@interface ShareView ()

@property (nonatomic , strong) CustomShareView *shareView;

@property (nonatomic, strong) UIViewController *vc;

@end

@implementation ShareView

- (instancetype)initWithFrame:(CGRect)frame shareBlock:(ShareViewTypeBlock)shareBlock vc:(UIViewController *)vc
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _shareBlock = [shareBlock copy];
        
        _vc = vc;
        
        [self addShareView];
    }
    return self;
}

- (void)addShareView
{
    NSArray *shareAry = @[@{@"image":@"ic_weixin",
                            @"title":@"微信"},
                          @{@"image":@"ic_wx_timeline",
                            @"title":@"朋友圈"}];
    
    _shareView = [[CustomShareView alloc] init];
    
    _shareView.alpha = 0;
    
    [_shareView setShareAry:shareAry delegate:self];
    
    [[UIApplication sharedApplication].keyWindow addSubview:_shareView];
    
    [_shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(kScreenHeight);
        
    }];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _shareView.alpha = 1;
        
    } completion:^(BOOL finished) {
        
    }];
    
    BaseWeakSelf;
    _shareView.cancleBlock = ^(){
        
        [weakSelf removeFromSuperview];
    };
    
}

#pragma mark HXEasyCustomShareViewDelegate

- (void)customShareViewButtonAction:(CustomShareView *)shareView title:(NSString *)title {
    
    [self shareWithTitle:title];
}

- (void)shareWithTitle:(NSString*)title
{
    
    NSString *shareTitle = PASS_NULL_TO_NIL(_shareTitle).length > 0 ? _shareTitle : @"健康e购";
    NSString *shareDesc = PASS_NULL_TO_NIL(_shareDesc).length > 0 ? _shareDesc : @"欢迎使用健康e购";
    UIImage *shareImage =  [_shareImgStr isEqualToString:@""] || _shareImgStr == nil? [UIImage imageNamed:@"app图标转发后"] : [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[_shareImgStr convertImageUrl]]]];
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:shareTitle descr:shareDesc thumImage:shareImage];
    
    shareObject.webpageUrl = _shareURL;
    
    messageObject.shareObject = shareObject;
    
    UMSocialPlatformType platformTypes;
    
    if (shareDesc.length > 80) {
        
        NSString *contentStr = [shareDesc substringToIndex:80];
        
        shareDesc = [NSString stringWithFormat:@"%@...", contentStr];
        
    }
    
    if([title isEqualToString:@"微信"]) {
        
        platformTypes = UMSocialPlatformType_WechatSession;
        
    }else {
        
        platformTypes = UMSocialPlatformType_WechatTimeLine;
        
    }
    
    //分享出去的东西点击的连接和类型
    
//    [UMSocialConfig setFinishToastIsHidden:YES position:UMSocialiToastPositionCenter];
    
    [[UMSocialManager defaultManager] shareToPlatform:platformTypes messageObject:messageObject currentViewController:_vc completion:^(id result, NSError *error) {
        
        if (error) {
            
            if (_shareBlock) {
                
                _shareBlock(@"1");
                
            }
            
        } else {
        
            if ([result isKindOfClass:[UMSocialShareResponse class]]) {
                
                if (_shareBlock) {
                    
                    _shareBlock(@"0");

                }
                
            }
        }
        
    }];
    
}

@end
