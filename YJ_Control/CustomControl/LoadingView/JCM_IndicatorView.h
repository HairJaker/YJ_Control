//
//  JCM_IndicatorView.h
//  竞彩猫
//
//  Created by yujie on 17/1/17.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCM_IndicatorView : UIView

@property (nonatomic, assign) CGFloat timeFlag;
@property (nonatomic, strong) NSTimer* timer;
@property (nonatomic, strong) UIColor* innerColor; //内圆颜色
@property (nonatomic, strong) UIColor* middleColor;//中间颜色
@property (nonatomic, strong) UIColor* outerColor; //外圈颜色

-(void)startAnimation;//
-(void)stopAnimation;
//-(void)removeAnimationView;
+(void)showInView:(UIView *)view title:(NSString *)title;//显示动画
+(void)dismiss;//停止动画

@end
