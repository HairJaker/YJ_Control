//
//  JCM_ActivityIndicatorBallGridBeatAnimation.m
//  竞彩猫
//
//  Created by yujie on 2017/4/14.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "JCM_ActivityIndicatorBallGridBeatAnimation.h"

@implementation JCM_ActivityIndicatorBallGridBeatAnimation

-(void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor{


    NSArray * durations = @[@0.96f, @0.93f, @1.19f, @1.13f, @1.34f, @0.94f, @1.2f, @0.82f, @1.19f];
    NSArray * timeOffsets = @[@0.36f, @0.4f, @0.68f, @0.41f, @0.71f, @-0.15f, @-0.12f, @0.01f, @0.32f];
    
    CAMediaTimingFunction * timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    CGFloat circleSpacing = 2;
    CGFloat circleSize = (size.width - circleSpacing * 2)/3;
    CGFloat x = (layer.bounds.size.width - circleSize)/2;
    CGFloat y = (layer.bounds.size.height - circleSize)/2;
    
    // animation
    
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];

    animation.beginTime = CACurrentMediaTime();
    animation.keyTimes = @[@0.0f,@0.5f,@1.0f];
    animation.values = @[@1.0f,@0.7f,@1.0f];
    animation.repeatCount = HUGE_VALF;
    animation.timingFunctions = @[timingFunction,timingFunction];
    
    // draw circle
    
    for (int i = 0; i < 3; i ++) {
        for (int j = 0 ; j < 3; j ++) {
            
            CALayer * circleLayer =[self createLayerWithSize:circleSize fillColor:tintColor];
            
            animation.duration = [durations[3 * i + j] floatValue];
            animation.timeOffset = [timeOffsets[3 * i + j] floatValue];
            circleLayer.frame = CGRectMake(x + circleSize * j + circleSpacing * j, y + circleSize * i + circleSpacing * i, circleSize, circleSize);
            [circleLayer addAnimation:animation forKey:@"animation"];
            [layer addSublayer: circleLayer];
            
        }
    }
    
}

-(CALayer *)createLayerWithSize:(CGFloat)circleSize fillColor:(UIColor *)fillColor{

    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    
    UIBezierPath * circlePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, circleSize, circleSize) cornerRadius:circleSize/2];
    
    shapeLayer.fillColor = fillColor.CGColor;
    shapeLayer.path = circlePath.CGPath;
    
    return shapeLayer;

}

@end
