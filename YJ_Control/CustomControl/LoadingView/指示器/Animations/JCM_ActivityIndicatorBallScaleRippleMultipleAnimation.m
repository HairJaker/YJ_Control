//
//  JCM_ActivityIndicatorBallScaleRippleMultipleAnimation.m
//  竞彩猫
//
//  Created by yujie on 2017/4/19.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "JCM_ActivityIndicatorBallScaleRippleMultipleAnimation.h"

@implementation JCM_ActivityIndicatorBallScaleRippleMultipleAnimation

-(void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor{

    CGFloat duration = 1.25f;
    CAMediaTimingFunction * timingFunction = [CAMediaTimingFunction functionWithControlPoints: 0.21f :0.53f :0.56f :0.8f];
    NSArray * timeOffsets = @[@0.0f,@0.2f,@0.4f];
    
    // scale animation
    
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    scaleAnimation.duration = duration;
    scaleAnimation.keyTimes = @[@0.0f, @0.7f];
    scaleAnimation.values = @[@0.1f, @1.0f];
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
    groupAnimation.duration   = duration;
    groupAnimation.repeatCount = HUGE_VALF;
    groupAnimation.beginTime = CACurrentMediaTime();
    
    // draw circle
    
    for (int i = 0; i < 3; i ++) {
        
        CAShapeLayer * shapeLayer = [CAShapeLayer layer];
        
        UIBezierPath * circlePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:size.width/2];
        
        groupAnimation.timeOffset = [timeOffsets[i] floatValue];
        
        shapeLayer.fillColor = nil;
        shapeLayer.lineWidth = 2;
        shapeLayer.strokeColor = tintColor.CGColor;
        shapeLayer.path = circlePath.CGPath;
        
        [shapeLayer addAnimation:groupAnimation forKey:@"animation"];
        shapeLayer.frame = CGRectMake((layer.bounds.size.width - size.width)/2, (layer.bounds.size.height - size.height)/2, size.width, size.height);
        
        [layer addSublayer:shapeLayer];
        
    }

}

@end
