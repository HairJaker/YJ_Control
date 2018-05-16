//
//  JCM_UserManager.m
//  竞彩猫
//
//  Created by yujie on 17/1/13.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "JCM_UserManager.h"

@implementation JCM_UserManager

singlent_for_implementation(JCM_UserManager);

static  JCM_UserManager  * userManager = nil;

+(instancetype)sharedUserManager{
    
    if (userManager == nil) {
        
        userManager = [JCM_UserManager readUserManagerObjectFromFile];
        
        if (userManager == nil) {
            
            static dispatch_once_t once;
            
            dispatch_once(&once, ^{
                userManager = [[JCM_UserManager alloc]init];
            });
        }
    }
    
    return userManager;
}
// 读取
+ (JCM_UserManager *)readUserManagerObjectFromFile {
    
    JCM_UserManager * object = nil;
    
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString * userInfoPath = [[array objectAtIndex:0] stringByAppendingPathComponent:@"userInfo.list"];
    
    NSData * data = [NSData dataWithContentsOfFile:userInfoPath];
    
    NSKeyedUnarchiver * unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    
    object = (JCM_UserManager*)[unarchiver decodeObjectForKey:@"data"];
    
    [unarchiver finishDecoding];
    
    return object;
}

// 写入
+(BOOL)writeUserManagerObjectToFile{
    
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString * userInfoPath = [[array objectAtIndex:0] stringByAppendingPathComponent:@"userInfo.list"];
    
    NSMutableData * userData = [[NSMutableData alloc]init];
    
    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:userData];
    
    [archiver encodeObject:userManager forKey:@"data"];
    
    [archiver finishEncoding];
    
    [userData writeToFile:userInfoPath atomically:YES];
    
    return YES;
    
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    
    // tab bar
//    [aCoder encodeObject:_tabBarModel forKey:@"tabBarModel"];
//
//    [aCoder encodeInt:_tabBarState forKey:@"tabBarState"];
//
//    // user
//    [aCoder encodeObject:_userModel forKey:@"userModel"];
    [aCoder encodeInt:_money forKey:@"money"];
    [aCoder encodeBool:_isLogin forKey:@"isLogin"];
    [aCoder  encodeObject:_token forKey:@"token"];
    [aCoder  encodeObject:_user_id forKey:@"user_id"];
    [aCoder encodeObject:_user_type forKey:@"user_type"];
    
//    // 轮播图
//    [aCoder encodeObject:_circleListModel forKey:@"circleListModel"];
//
//    //  配置
//    [aCoder encodeObject:_jcm_configure forKey:@"configure"];
//
//    // 专家列表
//    [aCoder encodeObject:_allExpertModel forKey:@"allExpertModel"];
//    [aCoder encodeObject:_footExpertModel forKey:@"footExpertModel"];
//    [aCoder encodeObject:_basketExpertModel forKey:@"basketExpertModel"];
//    [aCoder encodeObject:_stateExpertModel forKey:@"stateExpertModel"];
//    [aCoder encodeObject:_hotExpertModel forKey:@"hotExpertModel"];
//
//    // 内购
//    [aCoder encodeInteger:_receiptId forKey:@"receiptId"];
//
//    // 游戏
//    [aCoder encodeObject:_game_entrance forKey:@"game_entrance"];
//    [aCoder encodeObject:_game_money forKey:@"game_money"];
//    [aCoder encodeInt:_catFood forKey:@"catFood"];
//
//    // web
//    [aCoder encodeObject:_webUpDate forKey:@"webUpDate"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self = [super init]) {
        
//        // tab Bar
//        _tabBarModel = [aDecoder decodeObjectForKey:@"tabBarModel"];
//        _tabBarState = [aDecoder decodeIntForKey:@"tabBarState"];
//        
//        // user
//        _userModel = [aDecoder decodeObjectForKey:@"userModel"];
//        _user_id   = [aDecoder decodeObjectForKey:@"user_id"];
//        _user_type = [aDecoder decodeObjectForKey:@"user_type"];
//        _token     = [aDecoder decodeObjectForKey:@"token"];
//        _isLogin   = [aDecoder decodeBoolForKey:@"isLogin"];
//        _money     = [aDecoder decodeIntForKey:@"money"];
//        
//        // 轮播图
//        _circleListModel = [aDecoder decodeObjectForKey:@"circleListModel"];
//        
//        // 配置
//        _jcm_configure = [aDecoder decodeObjectForKey:@"configure"];
//        
//        // 专家列表
//        _allExpertModel = [aDecoder decodeObjectForKey:@"allExpertModel"];
//        _footExpertModel = [aDecoder decodeObjectForKey:@"footExpertModel"];
//        _basketExpertModel = [aDecoder decodeObjectForKey:@"basketExpertModel"];
//        _stateExpertModel = [aDecoder decodeObjectForKey:@"stateExpertModel"];
//        _hotExpertModel = [aDecoder decodeObjectForKey:@"hotExpertModel"];
        
        // 内购
        _receiptId = [aDecoder decodeIntegerForKey:@"receiptId"];
        
        // 游戏
        _game_entrance = [aDecoder decodeObjectForKey:@"game_entrance"];
        _game_money = [aDecoder decodeObjectForKey:@"game_money"];
        _catFood     = [aDecoder decodeIntForKey:@"catFood"];
        
        // web
        _webUpDate = [aDecoder decodeObjectForKey:@"webUpDate"];
        
    }
    
    return self;
}
@end

