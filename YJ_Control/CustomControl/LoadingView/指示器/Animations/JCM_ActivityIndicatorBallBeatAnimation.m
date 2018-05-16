//
//  JCM_ActivityIndicatorBallBeatAnimation.m
//  竞彩猫
//
//  Created by yujie on 2017/4/13.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "JCM_ActivityIndicatorBallBeatAnimation.h"

@implementation JCM_ActivityIndicatorBallBeatAnimation

-(void)setupAnimationInLayer:(CALayer *)layer
                    withSize:(CGSize)size
                   tintColor:(UIColor *)tintColor{

    CGFloat  duration = 0.7f;
    NSArray *beginTimes = @[@0.35f,@0.0f,@0.35f];
    CGFloat  circleSpacing = 2.0f;
    CGFloat  circleSize = (size.width - circleSpacing * 2)/beginTimes.count;
    CGFloat  x = (layer.bounds.size.width - size.width)/2;
    CGFloat  y = (layer.bounds.size.height - size.height)/2;
    
    // scale animation
    
    CAKeyframeAnimation * scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];

    scaleAnimation.duration = duration;
    scaleAnimation.keyTimes = @[@0.0f,@0.5f,@1.0f];
    scaleAnimation.values = @[@1.0f,@0.75f,@1.0f];
    
    // opacity animation
    
    CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    
    opacityAnimation.duration = duration;
    opacityAnimation.keyTimes = @[@0.0f,@0.5f,@1.0f];
    opacityAnimation.values = @[@1.0f,@0.2f,@1.0f];
    
    
    // animation group
    
    CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
    
    animationGroup.duration = duration;
    animationGroup.animations = @[scaleAnimation,opacityAnimation];
    animationGroup.repeatCount = HUGE_VALF;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // draw Circle
    
    for (int i = 0; i < beginTimes.count; i ++) {
        
        CAShapeLayer * circleShapeLayer  = [CAShapeLayer layer];
        
        UIBezierPath * circlePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, circleSize, circleSize) cornerRadius:circleSize/2];
        
        animationGroup.beginTime = [[beginTimes objectAtIndex:i] floatValue];
        circleShapeLayer.fillColor = tintColor.CGColor;
        circleShapeLayer.path = circlePath.CGPath;
        [circleShapeLayer addAnimation:animationGroup forKey:@"animation"];
        circleShapeLayer.frame = CGRectMake(x + circleSize * i + circleSpacing * i, y, circleSize, circleSize);
        [layer addSublayer:circleShapeLayer];
        
    }
}

@end
