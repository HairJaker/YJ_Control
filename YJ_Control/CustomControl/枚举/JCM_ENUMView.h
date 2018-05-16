//
//  JCM_ENUMView.h
//  竞彩猫
//
//  Created by yujie on 17/1/17.
//  Copyright © 2017年 yujie. All rights reserved.
//

#ifndef JCM_ENUMView_h
#define JCM_ENUMView_h

// web是否需要登录状态

typedef NS_ENUM(NSInteger, JCM_WebLoginType) {
    JCM_WebTypeNoLogin    = 0,
    JCM_WebTypeLogin      = 1
};

// web 类型:游戏,视频，文章

typedef NS_ENUM(NSInteger,JCM_WebKindType){
    JCM_WebKindArticle   = 0,
    JCM_WebKindVideo = 1,
    JCM_WebKindGame  = 2
};

// 第三方登录

typedef NS_ENUM(NSInteger, JCM_ThirdLoginType) {
    JCM_ThirdLoginTypeNone    = 0,
    JCM_ThirdLoginTypeTencent = 1,
    JCM_ThirdLoginTypeWechat  = 2,
    JCM_ThirdLoginTypeSina    = 3
};

//  导航
typedef NS_ENUM(NSInteger, JCM_TabBarType) {
    JCM_TabBarType_All           = 0,        // 全部
    JCM_TabBarHome               = 1,        // 首页底部导航
    JCM_TabBarFunction           = 2,        // 首页功能入口
    JCM_TabBarEuroCup            = 3,        // 欧洲杯导航
    JCM_TabBarCompeteKing        = 4         // 竞彩王导航
};

//  支付类型
typedef NS_ENUM(NSInteger, JCM_PriceType) {
    JCM_PriceType60                = 0,
    JCM_PriceType88                = 1,
    JCM_PriceType128               = 2,
    JCM_PriceType188               = 3,
    JCM_PriceType268               = 4,
    JCM_PriceType288               = 5,
    JCM_PriceTypeEur98               = 6,
    JCM_PriceTypeSuperComp138           = 7
};

//  广告类型
typedef NS_ENUM(NSInteger, JCM_AdvertType) {
    JCM_AdvertTypeBegin                = 1,
    JCM_AdvertTypeHead                 = 2,
    JCM_AdvertTypeCenter               = 3,
    JCM_AdvertTypePayment              = 4,
    JCM_AdvertTypeWeb                  = 5,
    JCM_AdvertTypeFree                 = 101,
    JCM_AdvertTypeTwoFish              = 102,
    JCM_AdvertTypeExpertSum            = 103,
    JCM_AdvertTypeBet                  = 104,
    JCM_AdvertTypeLeague               = 105,
    JCM_AdvertTypeEuro                 = 106,
    JCM_AdvertTypeRecord               = 107
};

// 弹出框类型
typedef NS_ENUM(NSInteger, JCM_AlertViewType) {
    JCM_AlertTypeNormal                = 1,
    JCM_AlertTypeRemoveLogin           = 2,
    JCM_AlertTypeBuy                   = 3
};

// 引导页类型

typedef NS_ENUM(NSInteger, JCM_GuideType) {
    JCM_GuideTypeHome                = 1,
    JCM_GuideTypeEuro                = 2
};

// 购买返回状态

typedef NS_ENUM(NSInteger,JCM_BuyArticleType){
    
    JCM_ReloadUserFishType = -5,
    JCM_NoLoginType    = 0,
    //    JCM_NoBindType     = 1,
    JCM_FreeType       = 2,
    JCM_IsBuyType      = 3,
    JCM_ConductType    = 4,
    JCM_MoneyNotEnoughType = 5,
    JCM_ConnectFailType = 6,
    JCM_CanBuyType      = 7
    
};

// 文章查看类别

typedef NS_ENUM(NSInteger,JCM_AriticleType){
    
    JCM_AriticleTypeFree = 0,
    JCM_AriticleTypeExpertSum = 1,
    JCM_AriticleTypeBet = 2,
    JCM_AriticleTypeMineBought = 3,
    JCM_AriticleTypeExpert = 4,
    JCM_AriticleTypeSchduRec = 5,
    JCM_AriticleTypeSuperComp = 6,
    JCM_AriticleTypeAtt = 7
    
};

#endif /* JCM_ENUMView_h */
