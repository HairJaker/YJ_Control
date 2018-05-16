//
//  JCM_ActivityIndicatorBallPulseSyncAnimatioin.m
//  竞彩猫
//
//  Created by yujie on 2017/4/18.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "JCM_ActivityIndicatorBallPulseSyncAnimatioin.h"

@implementation JCM_ActivityIndicatorBallPulseSyncAnimatioin

-(void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor{
    
    CGFloat  duration = 0.6f;
    CGFloat  circleSpacing = 2;
    CGFloat  circleSize = (size.width - circleSpacing * 2)/3;
    CGFloat  x = (layer.bounds.size.width - size.width)/2;
    CGFloat  y = (layer.bounds.size.height - size.height)/2;
    
    NSArray *beginTimes = @[@0.07f,@0.14f,@0.21f];
    CGFloat  deltaY = (size.height/2 - circleSize/2)/2;
    
    CAMediaTimingFunction * timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    // animation
    
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    
    animation.duration = duration;
    animation.keyTimes = @[@0.0f,@0.33f,@0.66f,@1.0f];
    animation.values = @[@0.0f,@(deltaY),@(-deltaY),@0.0f];
    animation.timingFunctions = @[timingFunction,timingFunction,timingFunction];
    animation.repeatCount = HUGE_VALF;
    
    
    for (int i = 0; i < 3;  i ++) {
        
        CAShapeLayer * shapeLayer = [CAShapeLayer layer];
        
        UIBezierPath * bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, circleSize, circleSize) cornerRadius:circleSize/2];
        
        animation.beginTime = [beginTimes[i] floatValue];
        
        shapeLayer.fillColor = tintColor.CGColor;
        shapeLayer.path = bezierPath.CGPath;
        [shapeLayer addAnimation:animation forKey:@"animation"];
        
        shapeLayer.frame = CGRectMake(x + (circleSize + circleSpacing) * i, y, circleSize, circleSize);
        
        [layer addSublayer:shapeLayer];
        
    }


}

@end
