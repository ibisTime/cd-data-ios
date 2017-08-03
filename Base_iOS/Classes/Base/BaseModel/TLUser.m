//
//  TLUser.m
//  ZHBusiness
//
//  Created by  蔡卓越 on 2016/12/14.
//  Copyright © 2016年  caizhuoyue. All rights reserved.
//

#import "TLUser.h"
#import "TLUserExt.h"
#import "UICKeyChainStore.h"

//#define USER_ID_KEY @"user_id_key_ycscy"
#define TOKEN_ID_KEY @"token_id_key_ycscy"
#define USER_INFO_DICT_KEY @"user_info_dict_key_ycscy"

NSString *const kUserLoginNotification = @"kUserLoginNotification_ycscy";
NSString *const kUserLoginOutNotification = @"kUserLoginOutNotification_ycscy";
NSString *const kUserInfoChange = @"kUserInfoChange_ycscy";

@implementation TLUser

+ (instancetype)user {

    static TLUser *user = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        user = [[TLUser alloc] init];
        
    });
    
    return user;

}

#pragma mark- 调用keyChainStore

- (void)initUserData {

    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefault objectForKey:TOKEN_ID_KEY];
    self.token = token;
    
    //--//
    [self setUserInfoWithDict:[userDefault objectForKey:USER_INFO_DICT_KEY]];

}


- (void)saveToken:(NSString *)token {

    [[NSUserDefaults standardUserDefaults] setObject:token forKey:TOKEN_ID_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

- (void)saveUserInfo:(NSDictionary *)userInfo {

    NSLog(@"原%@--现%@",[TLUser user].userId,userInfo[@"userId"]);
    
    [[NSUserDefaults standardUserDefaults] setObject:userInfo forKey:USER_INFO_DICT_KEY];
    //
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


- (TLUserExt *)userExt {

    if (!_userExt) {
        _userExt = [[TLUserExt alloc] init];
        
    }
    return _userExt;

}

- (void)updateUserInfo {

    TLNetworking *http = [TLNetworking new];
    http.isShowMsg = NO;
    http.code = USER_INFO;
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"token"] = [TLUser user].token;
    [http postWithSuccess:^(id responseObject) {
        
        [self setUserInfoWithDict:responseObject[@"data"]];
        [self saveUserInfo:responseObject[@"data"]];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kUserInfoChange object:nil];
        
    } failure:^(NSError *error) {
        
        
    }];

}


- (void)setUserInfoWithDict:(NSDictionary *)dict {

    self.userId = dict[@"userId"];
    
    self.idNo = dict[@"idNo"];
    self.message = dict[@"message"];
    
}


- (NSString *)detailAddress {

    if (!self.userExt.province) {
        return @"未知";
    }
    return [NSString stringWithFormat:@"%@ %@ %@",self.userExt.province,self.userExt.city,self.userExt.area];

}

@end
