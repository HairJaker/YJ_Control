//
//  JCM_ActivityIndicatorBallGridPulseAnimation.m
//  竞彩猫
//
//  Created by yujie on 2017/4/14.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "JCM_ActivityIndicatorBallGridPulseAnimation.h"

@implementation JCM_ActivityIndicatorBallGridPulseAnimation

-(void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor{

    NSArray *durations = @[@0.72f, @1.02f, @1.28f, @1.42f, @1.45f, @1.18f, @0.87f, @1.45f, @1.06f];
    NSArray *timeOffsets = @[@-0.06f, @0.25f, @-0.17f, @0.48f, @0.31f, @0.03f, @0.46f, @0.78f, @0.45f];
    
    CAMediaTimingFunction * timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    CGFloat  circleSpacing = 2;
    CGFloat  circleSize = (size.width - circleSpacing)/3;
    CGFloat  x = (layer.bounds.size.width - size.width)/2;
    CGFloat  y = (layer.bounds.size.height - size.height)/2;
    
    // scale animation
    
    CAKeyframeAnimation * scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    scaleAnimation.keyTimes = @[@0.0,@0.5,@1.0];
    scaleAnimation.values = @[@1.0,@0.5,@1.0];
    scaleAnimation.timingFunctions = @[timingFunction,timingFunction];
    
    // opacity animation
    
    CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    
    opacityAnimation.keyTimes = @[@0.0f,@0.5f,@1.0f];
    opacityAnimation.values = @[@1.0f,@0.7f,@1.0f];
    opacityAnimation.timingFunctions = @[timingFunction,timingFunction];
    
    
    // group animation
    
    CAAnimationGroup * groupAnimation = [CAAnimationGroup animation];
    
    groupAnimation.animations = @[scaleAnimation,opacityAnimation];
    groupAnimation.beginTime = CACurrentMediaTime();
    groupAnimation.repeatCount = HUGE_VALF;
    
    
    // draw circle
    
    for (int i = 0; i < 3; i ++) {
        for (int j = 0; j < 3; j ++) {
            
            CALayer *circle = [self creatCircleWith:circleSize color:tintColor];
            
            groupAnimation.duration = [durations[3 * i + j] floatValue];
            groupAnimation.timeOffset = [timeOffsets[3 * i + j] floatValue];
            circle.frame = CGRectMake(x + circleSize * j + circleSpacing * j, y + circleSize * i + circleSpacing * i, circleSize, circleSize);
            [circle addAnimation:groupAnimation forKey:@"animation"];
            [layer addSublayer:circle];
        }
    }
    
}

-(CALayer *)creatCircleWith:(CGFloat)size color:(UIColor *)color{

    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    
    UIBezierPath * circlePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size, size) cornerRadius:size/2];
    
    shapeLayer.fillColor = color.CGColor;
    shapeLayer.path = circlePath.CGPath;
    
    
    return shapeLayer;

}

@end
