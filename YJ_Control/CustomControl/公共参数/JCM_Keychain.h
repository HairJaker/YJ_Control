//
//  JCM_Keychain.h
//  竞彩猫
//
//  Created by yujie on 17/1/10.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCM_Keychain : NSObject

+(void)save:(NSString *)service data:(id)data;

+(id)load:(NSString *)service;

+(NSString*)uuid;

@end
