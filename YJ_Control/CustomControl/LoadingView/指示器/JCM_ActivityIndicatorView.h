//
//  JCM_ActivityIndicatorView.h
//  竞彩猫
//
//  Created by yujie on 2017/4/13.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,JCM_ActivityIndicatorAnimationType){

  JCM_ActivityIndicatorAnimationTypeBallBeat,
  JCM_ActivityIndicatorAnimationTypeBallClipRotate,
  JCM_ActivityIndicatorAnimationTypeBallClipMultiple,
  JCM_ActivityIndicatorAnimationTypeBallClipPulse,
  JCM_ActivityIndicatorAnimationTypeBallGridBeat,
  JCM_ActivityIndicatorAnimationTypeBallGridPulse,
  JCM_ActivityIndicatorAnimationTypeBallPulse,
  JCM_ActivityIndicatorAnimationTypeBallPulseSync,
  JCM_ActivityIndicatorAnimationTypeBallRotate,
  JCM_ActivityIndicatorAnimationTypeBallScale,
  JCM_ActivityIndicatorAnimationTypeBallScaleMultiple,
  JCM_ActivityIndicatorAnimationTypeBallScaleRipple,
  JCM_ActivityIndicatorAnimationTypeBallScaleRippleMultiple,
  JCM_ActivityIndicatorAnimationTypeBallSpinFadeLaoder,
  JCM_ActivityIndicatorAnimationTypeBallTrianglePath,
  JCM_ActivityIndicatorAnimationTypeBallZigZag,
  JCM_ActivityIndicatorAnimationTypeBallZigZagDeflect,
  JCM_ActivityIndicatorAnimationTypeCookieTerminator,
  JCM_ActivityIndicatorAnimationTypeDoubleBounce,
  JCM_ActivityIndicatorAnimationTypeFiveDots,
  JCM_ActivityIndicatorAnimationTypeLineScale,
  JCM_ActivityIndicatorAnimationTypeLineScaleParty,
  JCM_ActivityIndicatorAnimationTypeLineScalePulseOut,
  JCM_ActivityIndicatorAnimationTypeLineScalePulseOutRapid,
  JCM_ActivityIndicatorAnimationTypeNineDots,
  JCM_ActivityIndicatorAnimationTypeRotatingSandglass,
  JCM_ActivityIndicatorAnimationTypeRotatingSquares,
  JCM_ActivityIndicatorAnimationTypeRotatingTrigon,
  JCM_ActivityIndicatorAnimationTypeThreeDots,
  JCM_ActivityIndicatorAnimationTypeTriangleSkewSpin,
  JCM_ActivityIndicatorAnimationTypeTriplePulse,
  JCM_ActivityIndicatorAnimationTypeTripleRings,
  JCM_ActivityIndicatorAnimationTypeTwoDots

};

@interface JCM_ActivityIndicatorView : UIView

- (id)initWithType:(JCM_ActivityIndicatorAnimationType)type;
- (id)initWithType:(JCM_ActivityIndicatorAnimationType)type tintColor:(UIColor *)tintColor;
- (id)initWithType:(JCM_ActivityIndicatorAnimationType)type tintColor:(UIColor *)tintColor size:(CGFloat)size;

@property (nonatomic,assign) JCM_ActivityIndicatorAnimationType type;
@property (nonatomic,strong) UIColor * tintColor;
@property (nonatomic,assign) CGFloat size;

@property (nonatomic,readonly) BOOL isAnimaing;

-(void)startAnimating;
-(void)stopAnimating;

-(void)dismiss;

@end
