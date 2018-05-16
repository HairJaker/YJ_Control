//
//  JCM_AcitvityIndicatorBallClipRotateAnimation.m
//  竞彩猫
//
//  Created by yujie on 2017/4/13.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "JCM_AcitvityIndicatorBallClipRotateAnimation.h"


@implementation JCM_AcitvityIndicatorBallClipRotateAnimation

-(void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor{

    
    CGFloat duration = 0.75f;
    
    // scale animation
    
    CAKeyframeAnimation * scaleAnmaiton = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    scaleAnmaiton.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.6f, 0.6f, 0.6f)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)]];
    
    scaleAnmaiton.keyTimes = @[@0.0f,@0.5f,@1.0f];
    
    // rotate animation
    
    CAKeyframeAnimation * rotateAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.values = @[@0,@M_PI,@(2 * M_PI)];
    rotateAnimation.keyTimes = scaleAnmaiton.keyTimes;
    
    // animation group
    
    CAAnimationGroup * groupAnimation = [CAAnimationGroup animation];
    groupAnimation.duration = duration;
    groupAnimation.repeatCount = HUGE_VALF;
    groupAnimation.animations = @[scaleAnmaiton,rotateAnimation];
    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // draw ball clips
    
    CAShapeLayer * circleShapeLayer = [CAShapeLayer layer];
    circleShapeLayer.lineWidth = 3;
    circleShapeLayer.fillColor = nil;
    circleShapeLayer.strokeColor = tintColor.CGColor;
    
    UIBezierPath * circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(size.width/2, size.height/2) radius:size.width/2 startAngle:1.5 * M_PI endAngle:M_PI clockwise:true];
    circleShapeLayer.path = circlePath.CGPath;
    
    circleShapeLayer.frame = CGRectMake((layer.bounds.size.width - size.width)/2, (layer.bounds.size.height - size.height)/2, size.width, size.height);
    [circleShapeLayer addAnimation:groupAnimation forKey:@"animation"];
    [layer addSublayer: circleShapeLayer];
    
}

@end
