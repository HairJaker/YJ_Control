//
//  JCM_ActivityIndicatorBallPulseAnimation.m
//  竞彩猫
//
//  Created by yujie on 2017/4/18.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "JCM_ActivityIndicatorBallPulseAnimation.h"

@implementation JCM_ActivityIndicatorBallPulseAnimation

-(void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor{


    CGFloat  circlePadding = 5.0f;
    CGFloat  circleSize = (size.width - circlePadding * 2)/3;
    CGFloat  x = (layer.bounds.size.width - size.width)/2;
    CGFloat  y = (layer.bounds.size.height - size.height)/2;
    CGFloat  duration = 0.75;
    NSArray *beginTimes = @[@0.12,@0.24,@0.36];
    
    CAMediaTimingFunction * timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.2f :0.68f :0.18f :1.08f];
    
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.3f, 0.3f, 1.0f)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)]];
    animation.keyTimes = @[@0.0f,@0.3f,@1.0f];
    animation.timingFunctions = @[timingFunction,timingFunction];
    animation.duration = duration;
    animation.repeatCount = HUGE_VALF;
    
    for (int i = 0; i < 3; i ++) {
        CALayer * circleLayer = [CALayer layer];
        
        circleLayer.frame = CGRectMake(x + (circleSize + circlePadding) * i, y , circleSize, circleSize);
        circleLayer.beginTime = [beginTimes[i] floatValue];
        circleLayer.backgroundColor = tintColor.CGColor;
        circleLayer.cornerRadius = circleLayer.bounds.size.width/2;
        [circleLayer addAnimation:animation forKey:@"animation"];
        
        [layer addSublayer:circleLayer];
    }

}

@end
