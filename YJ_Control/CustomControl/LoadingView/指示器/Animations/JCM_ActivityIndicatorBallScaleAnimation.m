//
//  JCM_ActivityIndicatorBallScaleAnimation.m
//  竞彩猫
//
//  Created by yujie on 2017/4/18.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "JCM_ActivityIndicatorBallScaleAnimation.h"

@implementation JCM_ActivityIndicatorBallScaleAnimation

-(void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor{

    CGFloat  duration = 1.0f;
    
    // scale animation
    
    CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    scaleAnimation.duration = duration;
    scaleAnimation.fromValue = @0.0f;
    scaleAnimation.toValue = @1.0f;
    
    // opacity animation
    
    CABasicAnimation * opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];

    opacityAnimation.duration = duration;
    opacityAnimation.fromValue = @1.0f;
    opacityAnimation.toValue = @0.0f;
    
    // group animation
    
    CAAnimationGroup * groupAnimation = [CAAnimationGroup animation];
    
    groupAnimation.duration = duration;
    groupAnimation.animations = @[scaleAnimation,opacityAnimation];
    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    groupAnimation.repeatCount = HUGE_VALF;
    
    // draw circle
    
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    
    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:size.width/2];
    
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.fillColor = tintColor.CGColor;
    
    [shapeLayer addAnimation:groupAnimation forKey:@"animation"];
    
    shapeLayer.frame = CGRectMake((layer.bounds.size.width - size.width)/2, (layer.bounds.size.height - size.height)/2, size.width, size.height);
    
    [layer addSublayer:shapeLayer];
}

@end
