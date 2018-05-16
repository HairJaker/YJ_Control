//
//  JCM_ActivityIndicatorBallClipRotateMultipleAnimation.m
//  竞彩猫
//
//  Created by yujie on 2017/4/13.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "JCM_ActivityIndicatorBallClipRotateMultipleAnimation.h"

@implementation JCM_ActivityIndicatorBallClipRotateMultipleAnimation

-(void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor{


    CGFloat bigDuration = 1.0f,smallDuration = bigDuration/2;
    CAMediaTimingFunction * timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    // big  Circle
    {
        CGFloat circleSize = size.width;
        CAShapeLayer * circleShaperLayer = [CAShapeLayer layer];
        UIBezierPath * circlePath = [UIBezierPath bezierPath];
        
        [circlePath addArcWithCenter:CGPointMake(circleSize/2, circleSize/2) radius:circleSize/2 startAngle:-3 * M_PI/4 endAngle:- M_PI/4 clockwise:true];
        
        [circlePath moveToPoint:CGPointMake(circleSize/2 - circleSize/2 * cosf(M_PI/4), circleSize/2 + circleSize/2 * sinf(M_PI/4))];
        [circlePath addArcWithCenter:CGPointMake(circleSize/2, circleSize/2) radius:circleSize/2 startAngle:-5*M_PI/4 endAngle:-7*M_PI/4 clockwise:false];
        circleShaperLayer.path = circlePath.CGPath;
        
        circleShaperLayer.lineWidth = 3;
        circleShaperLayer.fillColor = nil;
        circleShaperLayer.strokeColor = tintColor.CGColor;
        
        circleShaperLayer.frame = CGRectMake((layer.bounds.size.width - circleSize)/2, (layer.bounds.size.height - circleSize)/2, circleSize, circleSize);
        [circleShaperLayer addAnimation:[self createAnimationInDuration:bigDuration withTimingFunction:timingFunction reverse:false] forKey:@"animation"];
        [layer addSublayer:circleShaperLayer];
    }
    
    // small circle
    {
    
        CGFloat circleSize = size.width;
        CAShapeLayer * circleShaperLayer = [CAShapeLayer layer];
        UIBezierPath * circlePath = [UIBezierPath bezierPath];
        
        [circlePath addArcWithCenter:CGPointMake(circleSize/2, circleSize/2) radius:circleSize/2 startAngle:3 * M_PI/4 endAngle:5 * M_PI/4 clockwise:true];
        
        [circlePath moveToPoint:CGPointMake(circleSize/2 + circleSize/2 * cosf(M_PI/4), circleSize/2 - circleSize/2 * sinf(M_PI/4))];
        [circlePath addArcWithCenter:CGPointMake(circleSize/2, circleSize/2) radius:circleSize/2 startAngle:-M_PI/4 endAngle:M_PI/4 clockwise:true];
        circleShaperLayer.path = circlePath.CGPath;
        
        circleShaperLayer.lineWidth = 3;
        circleShaperLayer.fillColor = nil;
        circleShaperLayer.strokeColor = tintColor.CGColor;
        
        circleShaperLayer.frame = CGRectMake((layer.bounds.size.width - circleSize)/2, (layer.bounds.size.height - circleSize)/2, circleSize - 10, circleSize - 10);
        [circleShaperLayer addAnimation:[self createAnimationInDuration:smallDuration withTimingFunction:timingFunction reverse:true] forKey:@"animation"];
        [layer addSublayer:circleShaperLayer];
    
    }
    
}
// create animation group
-(CAAnimation *)createAnimationInDuration:(CGFloat)duration withTimingFunction:(CAMediaTimingFunction *)timingFunction reverse:(BOOL)reverse{

    // scale animation
    
    CAKeyframeAnimation * scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)],
                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.6f, 0.6f, 0.6f)],
                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)]];

    scaleAnimation.keyTimes = @[@0.0f,@0.5f,@1.0f];
    scaleAnimation.duration = duration;
    scaleAnimation.timingFunctions = @[timingFunction,timingFunction];
    
    // rotate animation
    
    CAKeyframeAnimation * rotateAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    if (reverse) {
        rotateAnimation.values = @[@0,@(-M_PI),@(-2 * M_PI)];
    }else{
        rotateAnimation.values = @[@0,@M_PI,@(2 * M_PI)];
    }
    rotateAnimation.keyTimes = scaleAnimation.keyTimes;
    rotateAnimation.duration = duration;
    rotateAnimation.timingFunctions = @[timingFunction,timingFunction];
    
    // animation group
    
    CAAnimationGroup * groupAnimation = [CAAnimationGroup animation];
    
    groupAnimation.animations = @[scaleAnimation,rotateAnimation];
    groupAnimation.repeatCount = HUGE_VALF;
    groupAnimation.duration = duration;
    
    return groupAnimation;
}

@end
