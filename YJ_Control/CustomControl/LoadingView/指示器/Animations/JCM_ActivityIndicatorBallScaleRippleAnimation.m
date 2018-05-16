//
//  JCM_ActivityIndicatorBallScaleRippleAnimation.m
//  竞彩猫
//
//  Created by yujie on 2017/4/18.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "JCM_ActivityIndicatorBallScaleRippleAnimation.h"

@implementation JCM_ActivityIndicatorBallScaleRippleAnimation

-(void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor{

    CGFloat  duration = 1.0f;
    CAMediaTimingFunction * timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.21f :0.53f :0.56f :0.8f];
    
    // scale animation
    
    CAKeyframeAnimation * scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    scaleAnimation.duration = duration;
    scaleAnimation.keyTimes = @[@0.0f,@0.7f];
    scaleAnimation.values   = @[@0.1f,@1.0f];
    scaleAnimation.timingFunction = timingFunction;
    
    // opacity animation
    
    CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    
    opacityAnimation.duration = duration;
    opacityAnimation.keyTimes = @[@0.0f,@0.7f,@1.0f];
    opacityAnimation.values   = @[@1.0f,@0.7f,@0.0f];
    opacityAnimation.timingFunctions = @[timingFunction,timingFunction];
    
    // group animation
    
    CAAnimationGroup * groupAnimation = [CAAnimationGroup animation];
    
    groupAnimation.animations = @[scaleAnimation,opacityAnimation];
    groupAnimation.repeatCount = HUGE_VALF;
    groupAnimation.duration    = duration;
    
    // draw circle
    
    CAShapeLayer * circleShapeLayer = [CAShapeLayer layer];
    
    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:size.width/2];
    circleShapeLayer.fillColor = nil;
    circleShapeLayer.lineWidth = 2;
    circleShapeLayer.strokeColor = tintColor.CGColor;
    circleShapeLayer.path = bezierPath.CGPath;
    
    [circleShapeLayer addAnimation:groupAnimation forKey:@"animation"];
    
    circleShapeLayer.frame = CGRectMake((layer.bounds.size.width - size.width)/2, (layer.bounds.size.height - size.height)/2, size.width, size.height);
    
    [layer addSublayer: circleShapeLayer];

}

@end
