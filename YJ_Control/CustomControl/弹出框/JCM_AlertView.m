//
//  JCM_AlertView.m
//  竞彩猫
//
//  Created by yujie on 2017/4/1.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "JCM_AlertView.h"

static CGFloat  kTitleYOffset = 15.0f;
static CGFloat  kTitleHeight  = 25.0f;

@interface JCM_AlertView(){
    
    BOOL _isLeftClick;
    
}

@property (nonatomic, strong) UILabel *alertTitleLabel;
@property (nonatomic, strong) UILabel *alertContentLabel;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIView *backImageView;

@end

@implementation JCM_AlertView


- (id)initWithTitle:(NSString *)title
        contentText:(NSString *)contentText
    removeLoginTime:(NSString *)removeLoginTime
         deviceName:(NSString *)deviceName
    leftButtonTitle:(NSString *)leftButtonTitle
   rightButtonTitle:(NSString *)rightButtonTitle
      alertViewType:(JCM_AlertViewType)alertType
              price:(NSString *)price
            balance:(NSString *)balance
  customContentText:(NSMutableAttributedString *)customContentText{
    
    self = [super init];
    
    if (self) {
        
        self.layer.cornerRadius = 5.0f;
        self.backgroundColor = [UIColor whiteColor];
        
        [self addTitleAndContentLabelWithAlertType:alertType];
        
        
#define kSingleButtonWidth 160.0f
#define kCoupleButtonWidth 107.0f
#define kButtonHeight 40.0f
#define kButtonBottomOffset 10.0f
        
        CGRect leftButtonFrame  = CGRectZero,rightButtonFrame = CGRectZero,singleButtonFrame = CGRectMake((ALERT_WIDTH - kSingleButtonWidth) * 0.5, ALERT_HEIGHT - kButtonBottomOffset - kButtonHeight, kSingleButtonWidth, kButtonHeight);
        
        if (!leftButtonTitle) { // 只显示右边按钮
            
            _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _rightBtn.frame = singleButtonFrame;
            
            if (alertType == JCM_AlertTypeRemoveLogin) {
                title = @"下线通知";
                contentText = [NSString stringWithFormat:@"您的账号已于""%@"",在""%@""进行登录，您已被迫下线，如非您本人操作，请立即修改密码，防止账号被盗用",removeLoginTime,deviceName];
                
                _alertTitleLabel.text = title;
                _alertContentLabel.text = contentText;
            }
            
            [_rightBtn addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
        } else if(!rightButtonTitle) { // 只显示左边按钮
            
            _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _leftBtn.frame = singleButtonFrame;
            
            _alertTitleLabel.text = title;
            _alertContentLabel.text = contentText;
            
            [_leftBtn addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }else{
            
            leftButtonFrame = CGRectMake((ALERT_WIDTH - 2 * kCoupleButtonWidth - kButtonBottomOffset) * 0.5, ALERT_HEIGHT - kButtonBottomOffset - kButtonHeight, kCoupleButtonWidth, kButtonHeight);
            rightButtonFrame = CGRectMake(CGRectGetMaxX(leftButtonFrame) + kButtonBottomOffset, ALERT_HEIGHT - kButtonBottomOffset - kButtonHeight, kCoupleButtonWidth, kButtonHeight);
            
            _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            _leftBtn.frame = leftButtonFrame;
            _rightBtn.frame = rightButtonFrame;
            
            switch (alertType) {
                case JCM_AlertTypeBuy:
                {
                    [self getBuyTitleWithTitle:title andPrice:price];
                    
                    [self getBuyContentWithContentText:contentText];
                }
                    break;
                case JCM_AlertTypeNormal:
                {
                    _alertTitleLabel.text = title;
                    _alertContentLabel.text = contentText;
                }
                    break;
                    
                default:
                    break;
            }
            
        }
        
        if (_leftBtn) {
            
            [self addButton:_leftBtn withBackgroundColor:RGBA(227, 100, 83, 1.0f) title:leftButtonTitle action:@selector(leftButtonClick:)];
            
        }
        
        if (_rightBtn) {
            
            [self addButton:_rightBtn withBackgroundColor:RGBA(87, 135, 173, 1.0f) title:rightButtonTitle action:@selector(rightButtonClick:)];
            
        }
        
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        
        
    }
    return self;
}

-(void)getBuyTitleWithTitle:(NSString *)title andPrice:(NSString *)price{
    
    title = [NSString stringWithFormat:@"本次购买将扣除您:%@鱼",price];
    
    NSRange range = [title rangeOfString:price];
    
    NSMutableAttributedString * titleStr = [[NSMutableAttributedString alloc]initWithString:title];
    
    [titleStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    
    _alertTitleLabel.attributedText = titleStr;
    
}

-(void)getBuyContentWithContentText:(NSString *)contentText{
    
    contentText = [NSString stringWithFormat:@"账号可用余额:%d鱼\n\n预测有风险,购买需谨慎",[JCM_UserManager sharedUserManager].money];
    
    NSRange range = [contentText rangeOfString:[NSString stringWithFormat:@"%d",[JCM_UserManager sharedUserManager].money]];
    
    NSMutableAttributedString * contentStr = [[NSMutableAttributedString alloc]initWithString:contentText];
    [contentStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    
    _alertContentLabel.attributedText = contentStr;
    
}

-(void)addButton:(UIButton *)button withBackgroundColor:(UIColor *)backgroundColor
           title:(NSString *)title
          action:(SEL)action{
    
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:87.0/255.0 green:135.0/255.0 blue:173.0/255.0 alpha:1]] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    
    button.titleLabel.font = [UIFont systemFontOfSize:44 * SCALE_ELEMENT];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 3.0f;
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:button];
}

-(void)addTitleAndContentLabelWithAlertType:(JCM_AlertViewType)type{
    
    CGFloat contentFontSize = 28 * SCALE_ELEMENT,titleFontSize = 34 * SCALE_ELEMENT;
    
    if (type == JCM_AlertTypeNormal) {
        contentFontSize = 38 * SCALE_ELEMENT;
        titleFontSize   = 40 * SCALE_ELEMENT;
    }
    
    // 标题
    _alertTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kTitleYOffset, ALERT_WIDTH, kTitleHeight)];
    _alertTitleLabel.font = [UIFont systemFontOfSize:titleFontSize];
    _alertTitleLabel.textColor = [UIColor colorWithRed:56.0/255.0 green:64.0/255.0 blue:71.0/255.0 alpha:1];
    [self addSubview:_alertTitleLabel];
    
    // 内容
    CGFloat contentLabelWidth = ALERT_WIDTH - 16;
    
    _alertContentLabel = [[UILabel alloc]initWithFrame:CGRectMake((ALERT_WIDTH - contentLabelWidth) * 0.5, CGRectGetMaxY(_alertTitleLabel.frame), contentLabelWidth, 60)];
    _alertContentLabel.numberOfLines = 0;
    _alertContentLabel.textAlignment = _alertTitleLabel.textAlignment = NSTextAlignmentCenter;
    _alertContentLabel.textColor = [UIColor colorWithRed:127.0/255.0 green:127.0/255.0 blue:127.0/255.0 alpha:1];
    _alertContentLabel.font = [UIFont systemFontOfSize:contentFontSize];
    [self addSubview:_alertContentLabel];
    
}

-(void)leftButtonClick:(UIButton *)sender{
    
    _isLeftClick = YES;
    [self dismissAlert];
    if (self.leftBlock) {
        self.leftBlock();
    }
    
}

-(void)rightButtonClick:(UIButton *)sender{
    
    _isLeftClick = NO;
    [self dismissAlert];
    if (self.rightBlock) {
        self.rightBlock();
    }
    
}

-(void)dismissAlert{
    
    [self removeFromSuperview];
    
    if (self.dismissBlock) {
        self.dismissBlock();
    }
    
}

-(void)show{
    
    UIViewController * rootVc = [self appRootViewController];
    
    self.frame = CGRectMake((CGRectGetWidth(rootVc.view.bounds) - ALERT_WIDTH)/2, -ALERT_HEIGHT - 30, ALERT_WIDTH, ALERT_HEIGHT);
    
    [rootVc.view addSubview:self];
}

-(UIViewController *)appRootViewController{
    
    UIViewController * appRootVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController * topVc = appRootVc;
    
    while (topVc.presentedViewController) {
        topVc = topVc.presentedViewController;
    }
    
    return  topVc;
    
}

-(void)removeFromSuperview{
    
    [_backImageView removeFromSuperview];
    
    _backImageView = nil;
    
    UIViewController * rootVc = [self appRootViewController];
    
    CGFloat xOrigin = _isLeftClick ? 0: SCREEN_WIDTH;
    
    CGRect removeFrame = CGRectMake(xOrigin, CGRectGetHeight(rootVc.view.bounds), ALERT_WIDTH, ALERT_HEIGHT);
    
    [UIView animateWithDuration:0.35f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.frame = removeFrame;
        
        if (_isLeftClick) {
            self.transform = CGAffineTransformMakeRotation(-M_1_PI / 1.5);
        }else{
            self.transform = CGAffineTransformMakeRotation(M_1_PI / 1.5);
        }
        
    } completion:^(BOOL finished) {
        [super removeFromSuperview];
    }];
    
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    UIViewController *rootVc = [self appRootViewController];
    
    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame:rootVc.view.bounds];
        self.backImageView.backgroundColor = [UIColor blackColor];
        self.backImageView.alpha = 0.6f;
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    [rootVc.view addSubview:self.backImageView];
    
    self.transform = CGAffineTransformMakeRotation(-M_1_PI / 2);
    
    CGRect moveFrame = CGRectMake((CGRectGetWidth(rootVc.view.bounds) - ALERT_WIDTH) * 0.5, (CGRectGetHeight(rootVc.view.bounds) - ALERT_HEIGHT) * 0.5, ALERT_WIDTH, ALERT_HEIGHT);
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformMakeRotation(0);
        self.frame = moveFrame;
    } completion:^(BOOL finished) {
    }];
    [super willMoveToSuperview:newSuperview];
}

@end


@implementation UIImage (colorful)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
