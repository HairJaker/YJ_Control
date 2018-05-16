//
//  JCM_BaseViewController.m
//  竞彩猫
//
//  Created by yujie on 17/1/11.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "JCM_BaseViewController.h"

//#import "JCM_AdvertItemModel.h"

static NSString* const shareTitle = @"竞彩猫分享";
static NSString* const thumbImageName = @"分享LOGO";

@interface JCM_BaseViewController ()<UMSocialShareMenuViewDelegate,CAAnimationDelegate>{
    
    NSMutableArray * rightButtons;
    NSMutableArray * leftButtons;
    
    JCM_BuyArticleType  buyArticleType;
    
//    JCM_LoginViewController * loginVc;
    
}


@end

@implementation JCM_BaseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    rightButtons = [NSMutableArray new];
    leftButtons = [NSMutableArray new];
    
    self.view.backgroundColor = RGBA(232, 232, 232, 1.0f);  // 设置渐变背景
    
//    [self headView];         // 头部视图
    
}

-(void)setIsLogin:(BOOL)isLogin{
    self.isLogin = isLogin;
}

#pragma mark ----   头部视图  ------

-(UIView *)headView
{
    
    if (!_headView) {
        CGRect headViewRect =  CGRectMake(0, 0, SCREEN_WIDTH, NAVI_HEGIHT);
        
        _headView = [[UIView alloc]initWithFrame:headViewRect];
        _headView.backgroundColor = RGBA(251, 67, 41, 1.0f);
        [self.view addSubview:_headView];
    }
    
    return _headView;

}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        CGRect titleLabelRect = CGRectMake(0,0, 500 * SCALE_ELEMENT, 70 * SCALE_ELEMENT);
        
        _titleLabel = [[UILabel alloc]initWithFrame:titleLabelRect];
        _titleLabel.center = CGPointMake(CGRectGetMidX(self.view.frame), NAVI_HEGIHT - CENTER_ORIGIN_Y);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:FONT_SIZE];
        [_headView addSubview:_titleLabel];
    }
    
    return _titleLabel;
}

-(UIButton *)leftButton{
    
    CGRect frame = CGRectMake(0, 0, 150 * SCALE_ELEMENT, 150 * SCALE_ELEMENT);
    
    _leftButton = [ UIButton createButtonWithFrame:frame
                                             title:@"返回"
                                          fontSize:FONT_SIZE
                                          fontName:FONT_NAME
                                         backColor:nil
                                        titleColor:[UIColor whiteColor]
                                        showBorder:NO
                                       borderColor:nil
                                       normalImage:nil
                                      cornerRadius:0
                                     selectedImage:nil];
    _leftButton.frame = frame;
    //    [btn setImage:image forState:UIControlStateNormal];
    [_leftButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [_leftButton setTitle:@"返回" forState:UIControlStateNormal];
    _leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, SCALE(20), 0, 0);
    _leftButton.titleEdgeInsets = UIEdgeInsetsMake(0, SCALE(40), 0, 0);
    _leftButton.center = CGPointMake(SCALE(70), NAVI_HEGIHT - CENTER_ORIGIN_Y);
    [_leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _leftButton.titleLabel.font = [UIFont systemFontOfSize:SCALE(36)];
    [_leftButton addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:_leftButton];
    
    return _leftButton;
}

-(void)setLeftButton
{
    
}

-(void)setHeadViewTitleLabelTextWith:(NSString *)text
{
    _titleLabel.text = text;
}

-(void)setHeadViewHidden:(BOOL)hidden
{
    _headView.hidden = hidden;
}

-(void)resetLeftButtonWithTitle:(NSString *)title titleColorStr:(NSString *)titleColorStr image:(UIImage *)image
{
    [_leftButton setTitleColor:[UIColor colorWithHexString:titleColorStr withAlpha:1.0f] forState:UIControlStateNormal];
    [_leftButton setTitle:title forState:UIControlStateNormal];
    [_leftButton setImage:image forState:UIControlStateNormal];
}

-(void)resetRightButtonWithTitle:(NSString *)title image:(UIImage *)image textColor:(UIColor *)textColor
{
    UIButton * rightButton = [rightButtons firstObject];
    
    [rightButton setTitle:title forState:UIControlStateNormal];
    [rightButton setImage:image forState:UIControlStateNormal];
    if (textColor) {
        [rightButton setTitleColor:textColor forState:UIControlStateNormal];
    }
    
}

-(void)setItemWithRigthTitle:(NSString *)rightTitle image:(UIImage *)image
{
    
    CGRect  frame = CGRectZero;
    
    if (rightTitle) {
        
        NSArray * rightTitles = [rightTitle componentsSeparatedByString:@","];
        
        for (int i = 0; i < rightTitles.count; i ++) {
            
            CGFloat  rightButWidth = rightTitles.count == 1?160 * SCALE_ELEMENT:120 * SCALE_ELEMENT;
            
            frame = CGRectMake(0, 0, rightButWidth, 62 * SCALE_ELEMENT);
            
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = frame;
            NSInteger count = i == 0?0:(rightTitles.count - i);
            [btn setCenter:CGPointMake(SCREEN_WIDTH - (SCALE(50) + rightButWidth/2 + rightButWidth * count),NAVI_HEGIHT - CENTER_ORIGIN_Y)];
            [btn setImage:image forState:UIControlStateNormal];
            [btn setTitle:[rightTitles objectAtIndex:i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:34 * SCALE_ELEMENT];
            btn.tag = 600+i;
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            [btn addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
            [_headView addSubview:btn];
            
            [rightButtons addObject:btn];
        }
    }else{
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 62 * SCALE_ELEMENT, 62 * SCALE_ELEMENT);
        btn.center = CGPointMake(SCREEN_WIDTH - SCALE(81), NAVI_HEGIHT - CENTER_ORIGIN_Y);
        [btn setImage:image forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
        [_headView addSubview:btn];
        
        [rightButtons addObject:btn];
        
    }
}

-(void)rightAction:(UIButton*)sender
{
    
}

-(void)leftAction:(UIButton*)sender
{
    
    [JCM_IndicatorView dismiss];
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark ----  添加渐变背景色  -----

-(void)setBackgroundColor
{
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    
    gradientLayer.colors = @[(__bridge id)[UIColor blackColor].CGColor,(__bridge id)[UIColor colorWithRed:125/255.0f green:125/255.0f blue:125/255.0f alpha:1.0f].CGColor];
    
    //位置x,y    自己根据需求进行设置   使其从不同位置进行渐变
    
    gradientLayer.startPoint = CGPointMake(0, 1);
    
    gradientLayer.endPoint = CGPointMake(1, 0);
    
    gradientLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    
    [self.view.layer addSublayer:gradientLayer];
}

#pragma mark  --  login  -- 

-(void)goToLogin{
    
    //    CATransition *transition = [CATransition animation];
    //    transition.duration = 1.0f;
    //    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //    transition.type = @"rippleEffect";
    //    transition.subtype = kCATransitionFromLeft;
    //    transition.delegate = self;
    //    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
//    loginVc = [[JCM_LoginViewController alloc]init];
//    [self.navigationController pushViewController:loginVc animated:YES];
    
}

-(void)goPop{
    
    if ([JCM_UserManager sharedUserManager].isLogin && _isLogin) {
        
//        JCM_TabBarController * tab = [self.navigationController.viewControllers firstObject];
//
//        [tab refreshSeletedItemWithIndex:0];  // 刷新tab 显示数据 进首页
//
//        [self.navigationController popToViewController:tab animated:YES];
        
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}

-(void)exitLogin{
    
    [JCM_UserManager sharedUserManager].isLogin = NO;
    [JCM_UserManager sharedUserManager].token = nil;
    [JCM_UserManager sharedUserManager].user_id = nil;
    [JCM_UserManager sharedUserManager].user_type = nil;
    
    [JCM_UserManager writeUserManagerObjectToFile];
    
    [self goToLogin];
    
}
#pragma mark  -- 下拉刷新 -- 上拉加载 --

-(void)addHeaderRefreshWithTableView:(UITableView *)tableView{
    
    NSMutableArray *headerImages = [NSMutableArray array];
    for (int i = 0; i < 12; i++) {
        NSString * filePath = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"refresh%d",i] ofType:@"tiff"];
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        [headerImages addObject:image];
    }
    
    MJRefreshGifHeader *gifHeader = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefreshData)];
    gifHeader.contentMode = UIViewContentModeScaleAspectFit;
    gifHeader.stateLabel.hidden = YES;
    gifHeader.lastUpdatedTimeLabel.hidden = YES;
    
    [gifHeader setImages:@[headerImages[0]] forState:MJRefreshStateIdle];
    [gifHeader setImages:headerImages forState:MJRefreshStatePulling];
    tableView.mj_header = gifHeader;
    
}

-(void)addHeaderRefreshWithScrollView:(UIScrollView *)scrollView{
    
    NSMutableArray *headerImages = [NSMutableArray array];
    for (int i = 0; i < 12; i++) {
        NSString * filePath = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"refresh%d",i] ofType:@"tiff"];
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        [headerImages addObject:image];
    }
    
    MJRefreshGifHeader *gifHeader = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefreshData)];
    gifHeader.stateLabel.hidden = YES;
    gifHeader.lastUpdatedTimeLabel.hidden = YES;
    
    [gifHeader setImages:@[headerImages[0]] forState:MJRefreshStateIdle];
    [gifHeader setImages:headerImages forState:MJRefreshStatePulling];
    scrollView.mj_header = gifHeader;
    
}

-(void)addHeaderRefreshWithCollectionView:(UICollectionView *)collectionView{
    
    NSMutableArray *headerImages = [NSMutableArray array];
    for (int i = 0; i < 12; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh%d.tiff",i]];
        [headerImages addObject:image];
    }
    
    MJRefreshGifHeader *gifHeader = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefreshData)];
    gifHeader.stateLabel.hidden = YES;
    gifHeader.lastUpdatedTimeLabel.hidden = YES;
    
    [gifHeader setImages:@[headerImages[0]] forState:MJRefreshStateIdle];
    [gifHeader setImages:headerImages forState:MJRefreshStatePulling];
    collectionView.mj_header = gifHeader;
    
}

-(void)headRefreshData{
    
    
}

-(void)addFooterRefreshWithTableView:(UITableView *)tableView{
    
    MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefreshData)];
    // 设置颜色
    footer.stateLabel.textColor = [UIColor blackColor];
    [footer.arrowView isHidden];
    tableView.mj_footer = footer;
    
}

-(void)footRefreshData{
    
    
    
}

#pragma mark  --  分享  -- 

-(void)setSharePlatforms
{
    //设置分享面板的显示和隐藏的代理回调
    [UMSocialUIManager setShareMenuViewDelegate:self];
    
    NSMutableArray * platforms = [NSMutableArray array];
    
    if ([QQApiInterface isQQInstalled]&&[QQApiInterface isQQSupportApi]) {
        [platforms addObject:@(UMSocialPlatformType_QQ)];
        [platforms addObject:@(UMSocialPlatformType_Qzone)];
    }
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        [platforms addObject:@(UMSocialPlatformType_WechatSession)];
        [platforms addObject:@(UMSocialPlatformType_WechatFavorite)];
        [platforms addObject:@(UMSocialPlatformType_WechatTimeLine)];
    }
    if ([WeiboSDK isWeiboAppInstalled]&&[WeiboSDK isCanShareInWeiboAPP]) {
        [platforms addObject:@(UMSocialPlatformType_Sina)];
    }
    [UMSocialUIManager setPreDefinePlatforms:platforms];
    
}
////  分享类型
// 纯文本
-(void)shareText:(NSString *)text
{
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.text = text;
    
    [self showShareMenuViewWithMessageObject:messageObject];
}
// 文字和图片
-(void)shareText:(NSString *)text shareImage:(UIImage *)shareImage
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [UMShareImageObject shareObjectWithTitle:shareTitle descr:text thumImage:[UIImage imageNamed:thumbImageName]];
    shareObject.shareImage = shareImage;
    messageObject.shareObject = shareObject;//分享消息对象设置分享内容对象
    
    [self showShareMenuViewWithMessageObject:messageObject];
    
    
}
// 文本和链接
-(void)shareUrl:(NSString *)url contentText:(NSString *)contentText title:(NSString *)title thumbImage:(UIImage *)thumbImage
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    if (!title) {
        title = shareTitle;
    }
    
    if (!thumbImage) {
        thumbImage = [UIImage imageNamed:thumbImageName];
    }
    
    //创建网页对象
    UMShareWebpageObject *webObject = [UMShareWebpageObject shareObjectWithTitle:title descr:contentText thumImage:thumbImage];
    if (url) {
        //设置网页地址
        webObject.webpageUrl = url;
    }
    messageObject.shareObject = webObject;
    
    [self showShareMenuViewWithMessageObject:messageObject];
}
//  显示分享面板
-(void)showShareMenuViewWithMessageObject:(UMSocialMessageObject*)messageObject
{
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        // 根据获取的platformType确定所选平台进行下一步操作
        
        [self shareWithMessageObject:messageObject platformType:platformType];
        
    }];
}

// 调用分享接口
-(void)shareWithMessageObject:(UMSocialMessageObject *)messageObject
                 platformType:(UMSocialPlatformType)platformType{
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [self showShareResultWithError:error];
    }];
}

// 分享结果显示
-(void)showShareResultWithError:(NSError *)error
{
    NSString *resultMessage = nil;
    if (!error) {
        resultMessage = [NSString stringWithFormat:@"分享成功"];
    }else {
        if(error.code == 2009){
            resultMessage = [NSString stringWithFormat:@"取消分享"];
        }else{
            resultMessage = [NSString stringWithFormat:@"分享失败"];
        }
        
    }
    //提示
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:resultMessage preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark  --  暂无数据  --

-(void)showNoDataViewWithView:(UIView *)view center:(CGPoint)center{
    
    [_noDataLabel removeFromSuperview];
    _noDataLabel = nil;
    
    _noDataLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60 * SCALE_ELEMENT)];
    _noDataLabel.text = @"暂无数据";
    _noDataLabel.textColor = [UIColor redColor];
    _noDataLabel.textAlignment = NSTextAlignmentCenter;
    _noDataLabel.font = [UIFont systemFontOfSize:15.0f];
    _noDataLabel.center = center;
    _noDataLabel.tag = 999;
    [view addSubview:_noDataLabel];
    
}

-(void)removeNoData{
    
    [_noDataLabel removeFromSuperview];
    _noDataLabel = nil;
    
}

-(void)showNoDataViewWithView:(UIView *)view center:(CGPoint)center title:(NSString *)title type:(NSInteger)type{
    
    [self removeNoDataView];
    
    _noDataView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 400 * SCALE_ELEMENT, 500 * SCALE_ELEMENT)];
    _noDataView.backgroundColor = [UIColor clearColor];
    _noDataView.center = center;
    [view addSubview:_noDataView];
    
    NSString * imgName = type == 1?@"暂无数据":@"比武场暂无数据";
    NSString * colorStr = type == 1?@"#898888":@"#3d3d3d";
    
    UIImageView * noDataImgView = [UIImageView createImgViewWithFrame:CGRectMake(25 * SCALE_ELEMENT, 15 * SCALE_ELEMENT, 350 * SCALE_ELEMENT, 350 * SCALE_ELEMENT) cornerRadius:0 image:[UIImage imageNamed:imgName]];
    noDataImgView.contentMode = UIViewContentModeScaleAspectFit;
    [_noDataView addSubview:noDataImgView];
    
    if (!title) {
        title = @"暂无数据";
    }
    
    _noDataLabel = [UILabel createLabelWithFrame:CGRectMake(0, 450 * SCALE_ELEMENT, _noDataView.frame.size.width, 35 * SCALE_ELEMENT)
                                            text:title
                                       backColor:nil
                                       textColor:[UIColor colorWithHexString:colorStr withAlpha:1.0f] showBorder:NO
                                        fontSize:32 * SCALE_ELEMENT
                                     borderColor:nil cornerRadius:0];
    [_noDataView addSubview:_noDataLabel];
    
}

-(void)removeNoDataView{
    
    [_noDataLabel removeFromSuperview];
    [_noDataView removeFromSuperview];
    _noDataLabel = nil;
    _noDataView = nil;
    
}

#pragma mark  -- advert   --

-(JCM_AdvertItemModel * )getAdvertItemModelWithAdvertType:(JCM_AdvertType)advertType{
    
    NSString * typeStr = [NSString stringWithFormat:@"%ld",advertType];
    
    JCM_AdvertItemModel * advertItemModel;
    
//    for (JCM_AdvertItemModel * itemModel in [JCM_UserManager sharedUserManager].jcm_configure.adverticement) {
//        if ([itemModel.indexs isEqualToString:typeStr]) {
//            advertItemModel = itemModel;
//        }
//    }
    
    return advertItemModel;
    
}

-(BOOL)advertIsShowWithAdvertType:(JCM_AdvertType)advertType{
    
    NSString * typeStr = [NSString stringWithFormat:@"%ld",advertType];
    
    BOOL isShow = NO;
    
//    for (JCM_AdvertItemModel * itemModel in [JCM_UserManager sharedUserManager].jcm_configure.adverticement) {
//        if ([itemModel.indexs isEqualToString:typeStr]) {
//            if (![itemModel.article_id isEqualToString:@"-"]) {
//                isShow = YES;
//            }
//        }
//    }
    
    return isShow;
}

#pragma mark  --  被踢下线  --
// 被踢下线
-(void)showRemoveLoginWithResult:(NSDictionary *)result{
    
    if (![DEFAULT_USER valueForKey:@"removeLoginAlertCount"]) {
        [DEFAULT_USER setValue:@"0" forKey:@"removeLoginAlertCount"];
    }
    
    if ([[DEFAULT_USER valueForKey:@"removeLoginAlertCount"] integerValue] == 0) {
        [DEFAULT_USER setValue:@"1" forKey:@"removeLoginAlertCount"];
        JCM_AlertView * alert = [[JCM_AlertView alloc]initWithTitle:nil
                                                        contentText:nil
                                                    removeLoginTime:result[@"last_login_time"]
                                                         deviceName:result[@"device_name"]
                                                    leftButtonTitle:nil
                                                   rightButtonTitle:@"确定"
                                                      alertViewType:JCM_AlertTypeRemoveLogin
                                                              price:nil
                                                            balance:nil
                                                  customContentText:nil];
        
        __weak __typeof__(self)weakSelf = self;
        
        alert.rightBlock = ^(){
            
            __strong __typeof__(weakSelf) strongSelf = weakSelf;
            
            [DEFAULT_USER setValue:@"0" forKey:@"removeLoginAlertCount"];
            
            [strongSelf removeLogin];
            
        };
        
        [alert show];
    }
    
}

-(void)removeLogin{
    
    [JCM_UserManager sharedUserManager].isLogin = NO;
    [JCM_UserManager sharedUserManager].token = nil;
    [JCM_UserManager sharedUserManager].user_id = nil;
    [JCM_UserManager sharedUserManager].user_type = nil;
    [JCM_UserManager sharedUserManager].money = 0;
    
    [JCM_UserManager writeUserManagerObjectToFile];
    
    [self goToLogin];
    
}

#pragma mark  --  购买 --

-(JCM_BuyArticleType)buyArticleWithIsFree:(NSString *)isFree
                                    isBuy:(NSString *)isBuy
                                    price:(NSString *)price
                                  isVideo:(BOOL)isVideo{
    
    if (![JCM_UserManager sharedUserManager].isLogin) {
        return JCM_NoLoginType;
    }else{
        
        if ([isBuy intValue] == 1) {
            return JCM_IsBuyType;
        }else{
            if([isFree intValue] == 1) {
                return JCM_FreeType;
            }else if([isFree intValue] == 3){
                return JCM_ConductType;
            }else{
                [self reloadUserFishNumWithPrice:price isVideo:isVideo];
                
                return JCM_ReloadUserFishType;
            }
        }
    }
    
}

-(void)reloadUserFishNumWithPrice:(NSString *)price isVideo:(BOOL)isVideo{
    
    __block  NSDictionary * aResult = nil;
    
    NSMutableDictionary * infoDic = [NSMutableDictionary requestDictionary];
    
//    [JCM_HTTPCommunicate createRequest:USER_FISH_NUM_STR
//                                module:usersModule
//                         curReqVersion:curReqVersion
//                             withParam:infoDic withMethod:POST success:^(id result) {
//
//                                 if ([result[@"status"] intValue] == 0) {
//
//                                     [JCM_UserManager sharedUserManager].money = [result[@"data"][@"fish_num"] intValue];
//                                     [JCM_UserManager writeUserManagerObjectToFile];
//
//                                     if ([JCM_UserManager sharedUserManager].money < [price intValue]) {
//                                         aResult = @{@"buyState":@(JCM_MoneyNotEnoughType)};
//
//                                     }else{
//                                         aResult = result;
//                                     }
//                                     [self reloadUserFishNumWithResult:aResult isVideo:isVideo];
//
//                                 }else if ([result[@"status"] intValue] == 3){
//
//                                     [self showRemoveLoginWithResult:result];
//
//                                 }else{
//
//                                     [MBProgressHUD showProgress:result[@"message"] toView:self.view afterDelay:1];
//
//                                 }
//
//                             } failure:^(NSError *erro) {
//
//                                 [self reloadUserFishNumWithResult:nil isVideo:isVideo];
//
//                             } showHUD:nil];
    
}

-(void)reloadUserFishNumWithResult:(NSDictionary *)result isVideo:(BOOL)isVideo{
    
    
}

-(void)actionWithBuyFail:(JCM_BuyArticleType)buyFailType articleId:(NSString *)articleId isVideo:(BOOL)isVideo{
    
    
    switch (buyFailType) {
        case JCM_NoLoginType:{
            [self goToLogin];
        }
            break;
            
        case JCM_ConductType:{
            [MBProgressHUD showProgress:@"进行中不可购买" toView:self.view afterDelay:1.0f];
            
        }
            break;
        case JCM_FreeType:
        {
            [self pushWebViewWithArticleId:articleId isVideo:isVideo];
        }
            break;
        case JCM_IsBuyType:
        {
            [self pushWebViewWithArticleId:articleId isVideo:isVideo];
        }
            break;
        case JCM_MoneyNotEnoughType:
        {
//            JCM_FastPayViewController * fastPayVc = [[JCM_FastPayViewController alloc]init];
//            [self.navigationController pushViewController:fastPayVc animated:YES];
        }
            break;
        case JCM_ConnectFailType:
            
            break;
            
        default:
            break;
    }
    
}

-(void)pushWebViewWithArticleId:(NSString*)articleId isVideo:(BOOL)isVideo{
    
    
}

-(void)buyActionWithArticleId:(NSString *)articleId price:(NSString *)price isVideo:(BOOL)isVideo{
    
    [self buyArticleWithPrice:price articleId:articleId isVideo:isVideo];
    
}

-(void)buyArticleWithPrice:(NSString *)price articleId:(NSString *)article_id isVideo:(BOOL)isVideo{
    
    JCM_AlertView * alertView = [[JCM_AlertView alloc]initWithTitle:nil
                                                        contentText:nil
                                                    removeLoginTime:nil
                                                         deviceName:nil
                                                    leftButtonTitle:@"取消"
                                                   rightButtonTitle:@"确定"
                                                      alertViewType:JCM_AlertTypeBuy
                                                              price:price
                                                            balance:nil
                                                  customContentText:nil];
    [alertView show];
    
    alertView.leftBlock  = ^() {
        
        [self buySeccessWithResult:nil isVideo:isVideo];
        
        [MBProgressHUD showProgress:@"取消购买" toView:self.view afterDelay:1.0f];
        
    };
    
    alertView.rightBlock  = ^() {
        
        UIView * view = [UIApplication sharedApplication].keyWindow.rootViewController.view;
        
        NSMutableDictionary *buyDic = [NSMutableDictionary requestDictionary];
        
        [buyDic setValue:article_id forKey:@"article_id"];
        
        [MBProgressHUD showMessag:@"购买中..." toView:view];
        
//        [JCM_HTTPCommunicate createRequest:USER_BUY_ARTICLE_URL_STR
//                                    module:usersModule
//                             curReqVersion:curReqVersion
//                                 withParam:buyDic
//                                withMethod:POST
//                                   success:^(id result) {
//                                       
//                                       [MBProgressHUD hideHUDForView:view];
//                                       
//                                       if ([result[@"status"] integerValue] == 0) {
//                                           
//                                           [MBProgressHUD showProgress:@"购买成功" toView:self.view afterDelay:1.0f];
//                                           
//                                           [JCM_UserManager sharedUserManager].money -= [price intValue];
//                                           
//                                           [JCM_UserManager writeUserManagerObjectToFile];
//                                           
//                                           [self buySeccessWithResult:result isVideo:isVideo];
//                                           
//                                       }else if ([result[@"status"] intValue] == 3){
//                                           
//                                           [self showRemoveLoginWithResult:result];
//                                           
//                                       }else{
//                                           [MBProgressHUD showProgress:result[@"message"] toView:self.view afterDelay:1];
//                                       }
//                                       
//                                   } failure:^(NSError *erro) {
//                                       
//                                       [self buySeccessWithResult:nil isVideo:isVideo];
//                                       
//                                       [MBProgressHUD hideHUDForView:view];
//                                       
//                                   } showHUD:nil];
    };
}

-(void)buySeccessWithResult:(id)result isVideo:(BOOL)isVideo{
    
    
    
}

#pragma mark - UMSocialShareMenuViewDelegate
- (void)UMSocialShareMenuViewDidAppear
{
    NSLog(@"UMSocialShareMenuViewDidAppear");
}
- (void)UMSocialShareMenuViewDidDisappear
{
    NSLog(@"UMSocialShareMenuViewDidDisappear");
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
