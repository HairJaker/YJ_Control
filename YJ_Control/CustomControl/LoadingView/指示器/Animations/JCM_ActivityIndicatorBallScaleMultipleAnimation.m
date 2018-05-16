//
//  JCM_ActivityIndicatorBallScaleMultipleAnimation.m
//  竞彩猫
//
//  Created by yujie on 2017/4/18.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "JCM_ActivityIndicatorBallScaleMultipleAnimation.h"

@implementation JCM_ActivityIndicatorBallScaleMultipleAnimation

-(void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor{

    CGFloat duration = 1.0f;
    NSArray *beginTimes = @[@0.0f,@0.2f,@0.4f];
    
    // scale animation
    
    CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    scaleAnimation.duration = duration;
    scaleAnimation.fromValue = @0.0f;
    scaleAnimation.toValue = @1.0f;
    
    // opacity animation
    
    CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    
    opacityAnimation.duration = duration;
    opacityAnimation.keyTimes = @[@0.0f,@0.5f,@1.0f];
    opacityAnimation.values = @[@0.0f,@1.0f,@0.5f];
    
    // group animation
    
    CAAnimationGroup * groupAnimation = [CAAnimationGroup animation];
    
    groupAnimation.duration = duration;
    groupAnimation.animations = @[scaleAnimation,opacityAnimation];
    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    groupAnimation.repeatCount = HUGE_VALF;
    
    // draw circle
    
    for (int i = 0; i < 3; i ++) {
        
        CAShapeLayer * circleShapeLayer = [CAShapeLayer layer];
        
        UIBezierPath * circlePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:size.width/2];
        
        circleShapeLayer.path = circlePath.CGPath;
        circleShapeLayer.fillColor = tintColor.CGColor;
        
        groupAnimation.beginTime = [beginTimes[i] floatValue];
        circleShapeLayer.opacity = 0.0f;
        
        [circleShapeLayer addAnimation:groupAnimation forKey:@"animation"];
        
        circleShapeLayer.frame = CGRectMake((layer.bounds.size.width - size.width)/2, (layer.bounds.size.height - size.height)/2, size.width, size.height);
        
        [layer addSublayer:circleShapeLayer];
        
    }

}

@end
