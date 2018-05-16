//
//  JCM_Varification.h
//  竞彩猫
//
//  Created by yujie on 2017/5/23.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCM_Varification : NSObject

//判断手机号码格式是否正确
+(BOOL)valiMobile:(NSString *)mobile;

// 密码验证
+(BOOL)valiPassword:(NSString *)password;

// 用户名
+(BOOL)valiUserName:(NSString *)userName;

// 验证码
+(BOOL)valiCode:(NSString *)code;

// 粗略判断身份证号是否合法
+(BOOL)validateIdentityCard:(NSString *)identityCard;

// 真实姓名是否合法
+(BOOL)isChineseWithRealName:(NSString *)realName;

@end
