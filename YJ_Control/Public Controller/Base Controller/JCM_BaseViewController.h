//
//  JCM_BaseViewController.h
//  竞彩猫
//
//  Created by yujie on 17/1/11.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JCM_AdvertItemModel;
@class JCM_ExpertArticleModel;

typedef void(^JCM_BuyFailNotConnectedBlock)(void);

@interface JCM_BaseViewController : UIViewController

@property (nonatomic,strong) UIView   * headView;
@property (nonatomic,strong) UILabel  * titleLabel;
@property (nonatomic,strong) UIButton * leftButton;
@property (nonatomic,strong) UILabel  * noDataLabel;
@property (nonatomic,strong) UIView  * noDataView;

@property (nonatomic,assign) BOOL    isLogin;  // 是否是登录

-(void)setHeadViewTitleLabelTextWith:(NSString *)text;

-(void)setHeadViewHidden:(BOOL)hidden;

-(void)setItemWithRigthTitle:(NSString *)rightTitle image:(UIImage *)image;

-(void)resetLeftButtonWithTitle:(NSString *)title titleColorStr:(NSString *)titleColorStr image:(UIImage *)image;

-(void)resetRightButtonWithTitle:(NSString *)title image:(UIImage *)image textColor:(UIColor *)textColor;

-(void)rightAction:(UIButton *)sender;

-(void)leftAction:(UIButton *)sender;

//  分享
-(void)shareText:(NSString *)text;

-(void)shareText:(NSString *)text shareImage:(UIImage *)shareImage;

-(void)shareUrl:(NSString *)url contentText:(NSString *)contentText title:(NSString *)title thumbImage:(UIImage *)thumbImage ;

-(void)showShareResultWithError:(NSError *)error;

-(void)shareWithMessageObject:(UMSocialMessageObject *)messageObject
                 platformType:(UMSocialPlatformType)platformType;

-(void)goToLogin;

-(void)exitLogin;

-(void)goPop;

// 刷新
-(void)addHeaderRefreshWithTableView:(UITableView *)tableView;

-(void)addHeaderRefreshWithCollectionView:(UICollectionView *)collectionView;

-(void)addHeaderRefreshWithScrollView:(UIScrollView *)scrollView;

-(void)headRefreshData;
// 加载
-(void)addFooterRefreshWithTableView:(UITableView *)tableView;

-(void)footRefreshData;

// 暂无数据
-(void)showNoDataViewWithView:(UIView *)view center:(CGPoint)center;

-(void)removeNoData;

-(void)showNoDataViewWithView:(UIView *)view center:(CGPoint)center title:(NSString *)title type:(NSInteger)type;

-(void)removeNoDataView;

// 广告
-(JCM_AdvertItemModel * )getAdvertItemModelWithAdvertType:(JCM_AdvertType)advertType;

-(BOOL)advertIsShowWithAdvertType:(JCM_AdvertType)advertType;

// 被踢下线
-(void)showRemoveLoginWithResult:(NSDictionary *)result;

@property (nonatomic,copy) JCM_BuyFailNotConnectedBlock notConnectedBlock;

// 购买
-(JCM_BuyArticleType)buyArticleWithIsFree:(NSString *)isFree
                                    isBuy:(NSString *)isBuy
                                    price:(NSString *)price
                                  isVideo:(BOOL)isVideo;

-(void)actionWithBuyFail:(JCM_BuyArticleType)buyFailType articleId:(NSString *)articleId isVideo:(BOOL)isVideo;

-(void)buyActionWithArticleId:(NSString *)articleId  price:(NSString *)price isVideo:(BOOL)isVideo;

-(void)reloadUserFishNumWithResult:(NSDictionary *)result isVideo:(BOOL)isVideo;

-(void)pushWebViewWithArticleId:(NSString*)articleId isVideo:(BOOL)isVideo;

-(void)buySeccessWithResult:(id)result isVideo:(BOOL)isVideo;

@end
