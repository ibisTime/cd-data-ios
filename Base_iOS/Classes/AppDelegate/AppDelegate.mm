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

#import <PgyUpdate/PgyUpdateManager.h>
#import <PgySDk/PgyManager.h>

#import <ZMCreditSDK/ALCreditService.h>

#import "AppDelegate+Launch.h"

#import "NavigationController.h"
#import "TabbarViewController.h"
#import "DataVC.h"

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
    
    // 配置蒲公英
    [self configPgy];
    
    //配置芝麻信用
    [self configZMOP];
    
    //配置魔蝎
    [self configMoXie];
    
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
        
        //查询是否认证成功
        TLNetworking *http = [TLNetworking new];
        http.showView = [UIApplication sharedApplication].keyWindow;
        http.code = @"798014";
        http.parameters[@"bizNo"] = [TLUser user].tempBizNo;
        
        [http postWithSuccess:^(id responseObject) {
            
            NSString *str = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"isSuccess"]];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RealNameAuthResult" object:str];
            
            
        } failure:^(NSError *error) {
            
            
        }];
        
        
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
        
        //查询是否认证成功
        TLNetworking *http = [TLNetworking new];
        http.showView = [UIApplication sharedApplication].keyWindow;
        http.code = @"798014";
        http.parameters[@"bizNo"] = [TLUser user].tempBizNo;
        
        [http postWithSuccess:^(id responseObject) {
            
            NSString *str = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"isSuccess"]];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RealNameAuthResult" object:str];

//            if ([str isEqualToString:@"1"]) {
//                
//                
//            } else {
//                
//                [TLAlert alertWithError:@"实名认证失败"];
//            }
            
            
        } failure:^(NSError *error) {
            
            
        }];
        
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

//配置蒲公英
- (void)configPgy {
    
    // 关闭用户反馈
    [[PgyManager sharedPgyManager] setEnableFeedback:NO];
    [[PgyManager sharedPgyManager] startManagerWithAppId:kPgyerAppKey];
    
    // 检查更新
    [[PgyUpdateManager sharedPgyManager] startManagerWithAppId:kPgyerAppKey];
    [[PgyUpdateManager sharedPgyManager] checkUpdate];
}

- (void)configZMOP {

    [[ALCreditService sharedService] resgisterApp];
}

- (void)configMoXie {

    
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
        
        [[TLUser user] initUserData];
        
        //异步跟新用户信息
//        [[TLUser user] updateUserInfo];

        
        //登入
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLogin) name:kUserLoginNotification object:nil];
        
        //用户登出
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLoginOut) name:kUserLoginOutNotification object:nil];
    }];
}

- (void)userLogin {
    
    //注册推送别名
    //    [JPUSHService setAlias:[TLUser user].userId callbackSelector:nil object:nil];
    self.window.rootViewController = [[NavigationController alloc] initWithRootViewController:[[DataVC alloc] init]];
}

//- (void)userLoginOut {
//    
//    [[TLUser user] loginOut];
//    
//    self.window.rootViewController = [[NavigationController alloc] initWithRootViewController:[[TLUserLoginVC alloc] init]];
//    
//}

#pragma mark 微信支付结果
- (void)onResp:(BaseResp *)resp {
    
    if ([resp isKindOfClass:[PayResp class]]) {
        //支付返回结果
        NSNotification *notification = [NSNotification notificationWithName:ORDER_PAY_NOTIFICATION object:[NSNumber numberWithInt:resp.errCode]];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
}

@end
