//
//  JCM_ActivityIndicatorView.m
//  竞彩猫
//
//  Created by yujie on 2017/4/13.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "JCM_ActivityIndicatorView.h"

#import "JCM_ActivityIndicatorBallBeatAnimation.h"

#import "JCM_AcitvityIndicatorBallClipRotateAnimation.h"

#import "JCM_ActivityIndicatorBallClipRotateMultipleAnimation.h"

#import "JCM_ActivityIndicatorBallClipRotatePulseAnimation.h"

#import "JCM_ActivityIndicatorBallGridBeatAnimation.h"

#import "JCM_ActivityIndicatorBallGridPulseAnimation.h"

#import "JCM_ActivityIndicatorBallPulseAnimation.h"

#import "JCM_ActivityIndicatorBallPulseSyncAnimatioin.h"

#import "JCM_ActivityIndicatorBallRotateAnimation.h"

#import "JCM_ActivityIndicatorBallScaleAnimation.h"

#import "JCM_ActivityIndicatorBallScaleMultipleAnimation.h"

#import "JCM_ActivityIndicatorBallScaleRippleAnimation.h"

#import "JCM_ActivityIndicatorBallScaleRippleMultipleAnimation.h"

#import "JCM_ActivityIndicatorBallSpinFadeLaoderAnimation.h"

#import "JCM_AcitivityIndicatorBallTrianglePathAnimation.h"

#import "JCM_ActivityIndicatorBallZigZagAnimation.h"

#import "JCM_ActivityIndicatorBallZigZagDeflectAnimation.h"

#import "JCM_ActivityIndicatorCookieTerminatorAnimation.h"

#import "JCM_ActivityIndicatorDoubleBounceAnimation.h"

#import "JCM_ActivityIndicatorFiveDotsAnimation.h"

#import "JCM_ActivityIndicatorLineScaleAnimation.h"

#import "JCM_ActivityIndicatorLineScalePartyAnimation.h"

#import "JCM_ActivityIndicatorLineScalePulseOutAnimation.h"

#import "JCM_ActivityIndicatorLineScalePulseOutRapidAnimation.h"

#import "JCM_ActivityIndicatorNineDotsAnimation.h"

#import "JCM_ActivityIndicatorRotatingSandglassAnimation.h"

#import "JCM_ActivityIndicatorRotatingSquaresAnimation.h"

#import "JCM_ActivityIndicatorRotatingTrigonAnimation.h"

#import "JCM_ActivityIndicatorThreeDotsAnimation.h"

#import "JCM_ActivityIndicatorTriangleSkewSpinAnimation.h"

#import "JCM_ActivityIndicatorTriplePulseAnimation.h"

#import "JCM_ActivityIndicatorTripleRingsAnimation.h"

#import "JCM_ActivityIndicatorTwoDotsAnimation.h"

static const CGFloat kActivityIndicatorDefaultSize = 40.0f;

@implementation JCM_ActivityIndicatorView

-(id)initWithType:(JCM_ActivityIndicatorAnimationType)type{

    return [self initWithType:type tintColor:[UIColor whiteColor] size:kActivityIndicatorDefaultSize];
}

-(id)initWithType:(JCM_ActivityIndicatorAnimationType)type tintColor:(UIColor *)tintColor{

    return [self initWithType:type tintColor:tintColor size:kActivityIndicatorDefaultSize];

}

-(id)initWithType:(JCM_ActivityIndicatorAnimationType)type tintColor:(UIColor *)tintColor size:(CGFloat)size{

    self = [super init];
    
    if (self) {
        
        _type = type;
        _tintColor = tintColor;
        _size = size;
        self.userInteractionEnabled = NO;
        self.hidden = YES;
    }
    
    return  self;

}

#pragma mark  -- method  --

-(void)setupAnimation{

    self.layer.sublayers = nil;
    
    id<JCM_ActivityIndicatorAnimationProtocol> animation = [JCM_ActivityIndicatorView activityIndicatorAnimationForAnimationType:_type];
    
    if ([animation respondsToSelector:@selector(setupAnimationInLayer:withSize:tintColor:)]) {
        [animation setupAnimationInLayer:self.layer withSize:CGSizeMake(_size, _size) tintColor:_tintColor];
        self.layer.speed = 0.0f;
    }

}

-(void)startAnimating{

    if (!self.layer.sublayers) {
        [self setupAnimation];
    }
    self.hidden = NO;
    self.layer.speed = 1.0f;
    _isAnimaing = YES;

}

-(void)stopAnimating{

    self.layer.speed = 0.0f;
    self.hidden = YES;
    _isAnimaing = NO;

}

#pragma mark  -- setter  --

-(void)setType:(JCM_ActivityIndicatorAnimationType)type{

    if (_type != type) {
        _type = type;
    }
    [self setupAnimation];

}

-(void)setSize:(CGFloat)size{

    if (_size != size) {
        _size = size;
    }

    [self setupAnimation];
}

-(void)setTintColor:(UIColor *)tintColor{

    if (![_tintColor isEqual:tintColor]) {
        _tintColor = tintColor;
    }
    for (CALayer * layer in self.layer.sublayers) {
        layer.backgroundColor = tintColor.CGColor;
    }

}

-(void)dismiss{

    [self stopAnimating];
    [self removeFromSuperview];
}

#pragma mark  -- getter  --

+(id<JCM_ActivityIndicatorAnimationProtocol>)activityIndicatorAnimationForAnimationType:(JCM_ActivityIndicatorAnimationType)type{

    switch (type) {
        case JCM_ActivityIndicatorAnimationTypeBallBeat:
            return [[JCM_ActivityIndicatorBallBeatAnimation alloc]init];
            break;
        case JCM_ActivityIndicatorAnimationTypeBallClipRotate:
            return [[JCM_AcitvityIndicatorBallClipRotateAnimation alloc]init];
            break;
        case JCM_ActivityIndicatorAnimationTypeBallClipMultiple:
            return [[JCM_ActivityIndicatorBallClipRotateMultipleAnimation alloc]init];
            break;
        case JCM_ActivityIndicatorAnimationTypeBallClipPulse:
            return [[JCM_ActivityIndicatorBallClipRotatePulseAnimation alloc]init];
            break;
        case JCM_ActivityIndicatorAnimationTypeBallGridBeat:
            return [[JCM_ActivityIndicatorBallGridBeatAnimation alloc]init];
            break;
        case JCM_ActivityIndicatorAnimationTypeBallGridPulse:
            return [[JCM_ActivityIndicatorBallGridPulseAnimation alloc]init];
            break;
        case JCM_ActivityIndicatorAnimationTypeBallPulse:
            return [[JCM_ActivityIndicatorBallPulseAnimation alloc]init];
            break;
        case JCM_ActivityIndicatorAnimationTypeBallPulseSync:
            return [[JCM_ActivityIndicatorBallPulseSyncAnimatioin alloc]init];
            break;
        case JCM_ActivityIndicatorAnimationTypeBallRotate:
            return [[JCM_ActivityIndicatorBallRotateAnimation alloc]init];
            break;
        case JCM_ActivityIndicatorAnimationTypeBallScale:
            return [[JCM_ActivityIndicatorBallScaleAnimation alloc]init];
            break;
        case JCM_ActivityIndicatorAnimationTypeBallScaleMultiple:
            return [[JCM_ActivityIndicatorBallScaleMultipleAnimation alloc]init];
            break;
        case JCM_ActivityIndicatorAnimationTypeBallScaleRipple:
            return [[JCM_ActivityIndicatorBallScaleRippleAnimation alloc]init];
            break;
        case JCM_ActivityIndicatorAnimationTypeBallScaleRippleMultiple:
            return [[JCM_ActivityIndicatorBallScaleRippleMultipleAnimation alloc]init];
            break;
        case JCM_ActivityIndicatorAnimationTypeBallSpinFadeLaoder:
            return [[JCM_ActivityIndicatorBallSpinFadeLaoderAnimation alloc]init];
            break;
        case JCM_ActivityIndicatorAnimationTypeBallTrianglePath:
            return [[JCM_AcitivityIndicatorBallTrianglePathAnimation alloc]init];
            break;
        case JCM_ActivityIndicatorAnimationTypeBallZigZag:
            return [[JCM_ActivityIndicatorBallZigZagAnimation alloc]init];
            break;
        case JCM_ActivityIndicatorAnimationTypeBallZigZagDeflect:
            return [[JCM_ActivityIndicatorBallZigZagDeflectAnimation alloc]init];
            break;
        case JCM_ActivityIndicatorAnimationTypeCookieTerminator:
            return [[JCM_ActivityIndicatorCookieTerminatorAnimation alloc]init];
            break;
        case JCM_ActivityIndicatorAnimationTypeDoubleBounce:
            return [[JCM_ActivityIndicatorDoubleBounceAnimation alloc]init];
            break;
        case JCM_ActivityIndicatorAnimationTypeFiveDots:
            return [[JCM_ActivityIndicatorFiveDotsAnimation alloc]init];
            break;
        case JCM_ActivityIndicatorAnimationTypeLineScale:
            return [[JCM_ActivityIndicatorLineScaleAnimation alloc]init];
            break;
        case JCM_ActivityIndicatorAnimationTypeLineScaleParty:
            return [[JCM_ActivityIndicatorLineScalePartyAnimation alloc]init];
            break;
        case JCM_ActivityIndicatorAnimationTypeLineScalePulseOut:
            return [[JCM_ActivityIndicatorLineScalePulseOutAnimation alloc]init];
            break;
        case JCM_ActivityIndicatorAnimationTypeLineScalePulseOutRapid:
            return [[JCM_ActivityIndicatorLineScalePulseOutRapidAnimation alloc]init];
            break;
        case JCM_ActivityIndicatorAnimationTypeNineDots:
            return [[JCM_ActivityIndicatorNineDotsAnimation alloc]init];
            break;
        case JCM_ActivityIndicatorAnimationTypeRotatingSandglass:
            return [[JCM_ActivityIndicatorRotatingSandglassAnimation alloc]init];
            break;
        case JCM_ActivityIndicatorAnimationTypeRotatingSquares:
            return [[JCM_ActivityIndicatorRotatingSquaresAnimation alloc]init];
            break;
        case JCM_ActivityIndicatorAnimationTypeRotatingTrigon:
            return [[JCM_ActivityIndicatorRotatingTrigonAnimation alloc]init];
            break;
        case JCM_ActivityIndicatorAnimationTypeThreeDots:
            return [[JCM_ActivityIndicatorThreeDotsAnimation alloc]init];
            break;
        case JCM_ActivityIndicatorAnimationTypeTriangleSkewSpin:
            return [[JCM_ActivityIndicatorTriangleSkewSpinAnimation alloc]init];
            break;
        case JCM_ActivityIndicatorAnimationTypeTriplePulse:
            return [[JCM_ActivityIndicatorTriplePulseAnimation alloc]init];
            break;
        case JCM_ActivityIndicatorAnimationTypeTripleRings:
            return [[JCM_ActivityIndicatorTripleRingsAnimation alloc]init];
            break;
        case JCM_ActivityIndicatorAnimationTypeTwoDots:
            return [[JCM_ActivityIndicatorTwoDotsAnimation alloc]init];
            break;
        default:
            break;
    }

    return nil;

}

@end
