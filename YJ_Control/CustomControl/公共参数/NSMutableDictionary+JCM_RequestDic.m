//
//  NSMutableDictionary+JCM_RequestDic.m
//  竞彩猫
//
//  Created by yujie on 17/1/10.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "NSMutableDictionary+JCM_RequestDic.h"

@implementation NSMutableDictionary (JCM_RequestDic)

/**
 公共请求参数
 @return requestDictionary
 */
+(NSMutableDictionary *)requestDictionary{
    
    NSMutableDictionary * requestDic = [[NSMutableDictionary alloc]init];
    NSString  * buildVersion = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleVersion"];
//    NSString  * requestToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"requestToken"];
//    [requestDic setValue:requestToken != nil?requestToken:@"" forKey:@"uuid"];
    
    NSString * uuid = [[NSString alloc]initWithData:[self getUUID] encoding:NSUTF8StringEncoding];
    [requestDic setValue:uuid forKey:@"uuid"];

    [requestDic setValue:buildVersion forKey:@"version"];
//    [requestDic setValue:[UIDevice deviceName] forKey:@"deviceName"];
    
    [requestDic setValue:[JCM_UserManager sharedUserManager].user_id forKey:@"user_id"];
    [requestDic setValue:[JCM_UserManager sharedUserManager].token forKey:@"token"];
    [requestDic setValue:@(2) forKey:@"platform"];
    
    return requestDic;
}

/**
 @return uuid
 */
+(NSData *)getUUID{
    
    NSString * udid = [JCM_Keychain load:BUNDLE_IDENTIFIER];
    
    NSData* data = [[JCM_Keychain uuid] dataUsingEncoding:NSUTF8StringEncoding];
    
    if (udid == nil || udid.length == 0) {
        [JCM_Keychain save:BUNDLE_IDENTIFIER data:data];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:[JCM_Keychain load:BUNDLE_IDENTIFIER] forKey:@"UDID"];
    
    return [JCM_Keychain load:BUNDLE_IDENTIFIER];
    
}

+(NSString*)uuid{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    if(result.length == 0||result == nil){
        result = @"uuid for failure";
    }
    return result;
}

@end
