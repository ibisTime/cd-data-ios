//
//  AppDelegate.m
//  Base_iOS
//
//  Created by 蔡卓越 on 2017/7/13.
//  Copyright © 2017年 caizhuoyue. All rights reserved.
//

#import "AppDelegate.h"

#import "IQKeyboardManager.h"
#import "TLWXManager.h"
#import "TLAlipayManager.h"
#import "WXApi.h"
#import <ZMCreditSDK/ALCreditService.h>

#import "AppDelegate+Launch.h"

#import "NavigationController.h"
#import "TabbarViewController.h"
#import "DataVC.h"
#import "TLUserLoginVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - App Life Cycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //服务器环境
    [self configServiceAddress];
    
    //键盘
    [self configIQKeyboard];
    
    //配置地图
//    [self configMapKit];
    
    //配置极光
//    [self configJPushWithOptions:launchOptions];
    
    //配置芝麻信用
    [self configZMOP];
    
    //配置根控制器
    [self configRootViewController];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
}


// iOS9 NS_AVAILABLE_IOS
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    if ([url.host isEqualToString:@"certi.back"]) {
        
        NSString *str =  [url query];
        NSArray <NSString *>*arr =  [str componentsSeparatedByString:@"&"];
        
        __block NSString *bizNoStr;
        __block NSDictionary *dict;
        [arr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj hasPrefix:@"biz_content="]) {
                
                bizNoStr = [obj substringWithRange:NSMakeRange(12, obj.length - 12)];
                
                dict = [NSJSONSerialization JSONObjectWithData:[bizNoStr.stringByRemovingPercentEncoding dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                
            }
            
        }];
        
        
        //--//
        if (!dict[@"failed_reason"]) {
            
            //通知我们的服务器认证成功
            TLNetworking *http = [TLNetworking new];
            http.showView = [UIApplication sharedApplication].keyWindow;
            http.code = @"798014";
            //      http.parameters[@"userId"] = [TLUser user].userId;
            http.parameters[@"bizNo"] = [TLUser user].tempBizNo;
            
            [http postWithSuccess:^(id responseObject) {
                
                NSString *str = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"isSuccess"]];
                
                if ([str isEqualToString:@"1"]) {
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"realNameSuccess" object:nil];

                } else {
                
                    [TLAlert alertWithError:@"实名认证失败"];
                }
                
                
            } failure:^(NSError *error) {
                
                
            }];
            
        } else {
            
            
        }
        
        
        return YES;
    }
    
    if ([url.host isEqualToString:@"safepay"]) {
        
        [TLAlipayManager hadleCallBackWithUrl:url];
        return YES;
        
    } else {
        
        return [WXApi handleOpenURL:url delegate:[TLWXManager manager]];
        
    }
    
    return YES;
}

// iOS9 NS_DEPRECATED_IOS
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"certi.back"]) {
        
        NSString *str =  [url query];
        NSArray <NSString *>*arr =  [str componentsSeparatedByString:@"&"];
        
        __block NSString *bizNoStr;
        __block NSDictionary *dict;
        [arr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj hasPrefix:@"biz_content="]) {
                
                bizNoStr = [obj substringWithRange:NSMakeRange(12, obj.length - 12)];
                
                dict = [NSJSONSerialization JSONObjectWithData:[bizNoStr.stringByRemovingPercentEncoding dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                
            }
            
        }];
        
        
        //--//
        if (!dict[@"failed_reason"]) {
            
            //通知我们的服务器认证成功
            TLNetworking *http = [TLNetworking new];
            http.showView = [UIApplication sharedApplication].keyWindow;
            http.code = @"798014";
//            http.parameters[@"userId"] = [TLUser user].userId;
            http.parameters[@"bizNo"] = [TLUser user].tempBizNo;
            
            [http postWithSuccess:^(id responseObject) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"realNameSuccess" object:nil];
                
            } failure:^(NSError *error) {
                
                
            }];
            
        } else {
        
            
        }
        
        
        return YES;
    }
    
    if ([url.host isEqualToString:@"safepay"]) {
        
        [TLAlipayManager hadleCallBackWithUrl:url];
        return YES;
        
    } else {
        
        return [WXApi handleOpenURL:url delegate:[TLWXManager manager]];
        
    }
}

#pragma mark - Config
- (void)configServiceAddress {
    
    //配置环境
    [AppConfig config].runEnv = RunEnvDev;
    
}

- (void)configZMOP {

    [[ALCreditService sharedService] resgisterApp];
}

- (void)configIQKeyboard {
    
    //
//    [IQKeyboardManager sharedManager].enable = YES;
//    [[IQKeyboardManager sharedManager].disabledToolbarClasses addObject:[ComposeVC class]];
//    [[IQKeyboardManager sharedManager].disabledToolbarClasses addObject:[SendCommentVC class]];
    
}

- (void)configRootViewController {
    
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    //iOS10以下
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //iOS10以上
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self launchEventWithCompletionHandle:^(LaunchOption launchOption) {
        
        TabbarViewController *tabbarCtrl = [[TabbarViewController alloc] init];
        self.window.rootViewController = tabbarCtrl;
        
        //取出用户信息
        if([TLUser user].isLogin) {
            
            [[TLUser user] initUserData];
            
            //异步跟新用户信息
            [[TLUser user] updateUserInfo];
            
        };
        
        //登入
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLogin) name:kUserLoginNotification object:nil];
        
        //用户登出
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLoginOut) name:kUserLoginOutNotification object:nil];
    }];
}

- (void)userLogin {
    
    //注册推送别名
    //    [JPUSHService setAlias:[TLUser user].userId callbackSelector:nil object:nil];
    self.window.rootViewController = [[NavigationController alloc] initWithRootViewController:[[DataVC alloc] init]];
}

- (void)userLoginOut {
    
    [[TLUser user] loginOut];
    
    self.window.rootViewController = [[NavigationController alloc] initWithRootViewController:[[TLUserLoginVC alloc] init]];
    
}

#pragma mark 微信支付结果
- (void)onResp:(BaseResp *)resp {
    
    if ([resp isKindOfClass:[PayResp class]]) {
        //支付返回结果
        NSNotification *notification = [NSNotification notificationWithName:ORDER_PAY_NOTIFICATION object:[NSNumber numberWithInt:resp.errCode]];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
}

@end
