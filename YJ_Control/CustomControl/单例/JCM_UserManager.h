//
//  JCM_UserManager.h
//  竞彩猫
//
//  Created by yujie on 17/1/13.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import "JCM_Configure.h"

@interface JCM_UserManager : NSObject

singlent_for_interface(JCM_UserManager);

// 导航栏
//@property (strong,nonatomic) JCM_TabBarModel * tabBarModel;
@property (assign,nonatomic) int               tabBarState;

// 用户
//@property (strong,nonatomic) JCM_UserModel   * userModel;
@property (copy,nonatomic)   NSString<Optional> * token;
@property (assign,nonatomic) BOOL       isLogin;
@property (assign,nonatomic) int        money;
@property (nonatomic,copy)   NSString<Optional> * user_id;
@property (nonatomic,copy)   NSString<Optional> * user_type;

// 内购
@property (nonatomic,assign)   NSInteger receiptId;

// 游戏
@property (copy,nonatomic) NSString * game_entrance;
@property (copy,nonatomic) NSString * game_money;
@property (assign,nonatomic) int catFood;

// 友盟token
@property (copy  ,nonatomic) NSString * deviceToken;

//@property (nonatomic,strong) JCM_Configure * jcm_configure;

// 专家列表
// 全部
//@property (strong,nonatomic) JCM_ExpertListModel * allExpertModel;
//// 足球
//@property (strong,nonatomic) JCM_ExpertListModel * footExpertModel;
//// 篮球
//@property (strong,nonatomic) JCM_ExpertListModel * basketExpertModel;
//// 状态
//@property (strong,nonatomic) JCM_ExpertListModel * stateExpertModel;
//// 热度
//@property (strong,nonatomic) JCM_ExpertListModel * hotExpertModel;

// 轮播图
//@property (strong,nonatomic) JCM_CircleListModel * circleListModel;

// 同道
@property (assign,nonatomic) BOOL isRemoveMatchResultBottomView;

// web
@property (strong,nonatomic)   NSDate * webUpDate;


+(instancetype)sharedUserManager;

+(JCM_UserManager *)readUserManagerObjectFromFile;

+(BOOL)writeUserManagerObjectToFile;

@end
