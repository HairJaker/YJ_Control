//
//  JCM_Varification.m
//  竞彩猫
//
//  Created by yujie on 2017/5/23.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "JCM_Varification.h"

@implementation JCM_Varification

//判断手机号码格式是否正确
+(BOOL)valiMobile:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        
        NSString *CM_NUM = @"^(1[0-9])\\d{9}$";
        
        //        /**
        //         * 移动号段正则表达式
        //         */
        //        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        //        /**
        //         * 联通号段正则表达式
        //         */
        //        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        //        /**
        //         * 电信号段正则表达式
        //         */
        //        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        //        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        //        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        //        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        //        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1) {
            return YES;
        }else{
            return NO;
        }
    }
}

// 密码验证
+(BOOL)valiPassword:(NSString *)password
{
    
    // 6-20位字符
    if (password.length >= 6 && password.length <= 20) {
        
        // 不包含空格
        if ([password rangeOfString:@" "].location == NSNotFound ){
            
            return YES;
            
        }else{
            return NO;
        }
    }else{
        return NO;
    }
    
    //    //6-20位数字和字母组成
    //    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";
    //    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    //    if ([pred evaluateWithObject:self]) {
    //        return YES ;
    //    }else{
    //        return NO;
    //   }
}

// 验证码
+(BOOL)valiCode:(NSString *)code
{
    
    // 验证码
    if (code.length == 6) {
        
        return YES;
        
    }else{
        return NO;
    }
}

// 密码验证
+(BOOL)valiUserName:(NSString *)userName
{
    
    NSString *userNameRegex = @"^[A-Za-z]([A-Za-z0-9]{3,15})+$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", userNameRegex];
    
    BOOL isMatch = [pred evaluateWithObject:userName];
    
    return isMatch;
    
}


#pragma mark  --  身份证号或者真实姓名是否合法 --
// 粗略判断身份证号是否合法
+(BOOL)validateIdentityCard:(NSString *)identityCard
{
    if (identityCard.length <= 0) {
        return NO;
    }
    NSString *identityRegex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",identityRegex];
    return [identityCardPredicate evaluateWithObject:identityCard];
}
// 真实姓名是否合法
+(BOOL)isChineseWithRealName:(NSString *)realName
{
    if (realName.length <= 0) {
        return NO;
    }
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:realName];
}


@end
