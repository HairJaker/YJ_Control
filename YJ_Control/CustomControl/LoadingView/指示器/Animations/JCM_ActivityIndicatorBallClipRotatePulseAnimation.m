//
//  JCM_ActivityIndicatorBallClipRotatePulseAnimation.m
//  竞彩猫
//
//  Created by yujie on 2017/4/13.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "JCM_ActivityIndicatorBallClipRotatePulseAnimation.h"

@implementation JCM_ActivityIndicatorBallClipRotatePulseAnimation

-(void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor{

    CGFloat duration = 1.0f;
    CAMediaTimingFunction * timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.09f :0.57f :0.49f :0.9f];
    
    // small circle
    {
    
        CAKeyframeAnimation * scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"
                                                ];
        scaleAnimation.duration = duration;
        scaleAnimation.keyTimes = @[@0.0f,@0.3f,@1.0f];
        scaleAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)],
                                  [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.3f, 0.3f, 1.0f)],
                                  [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)]];
        scaleAnimation.repeatCount = HUGE_VALF;
        scaleAnimation.timingFunctions = @[timingFunction,timingFunction];
        
        CGFloat circleSize = size.width/2;
        CALayer * circleLayer = [CALayer layer];
        
        circleLayer.frame = CGRectMake((circleLayer.bounds.size.width - circleSize)/2, (circleLayer.bounds.size.height - circleSize)/2, circleSize, circleSize);
        circleLayer.backgroundColor = tintColor.CGColor;
        circleLayer.cornerRadius = circleSize/2;
        
        [circleLayer addAnimation:scaleAnimation forKey:@"animation"];
        
        [layer addSublayer:circleLayer];
    
    }
    
    // big circle
    {
    
        // scale animation
        
        CAKeyframeAnimation * scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"tramsform.scale"];
        scaleAnimation.keyTimes = @[@0.0f,@0.5f,@1.0f];
        scaleAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)],
                                  [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.6f, 0.6f, 1.0f)],
                                  [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)]];
        scaleAnimation.duration = duration;
        scaleAnimation.timingFunctions = @[timingFunction,timingFunction];
        
        // rotate animation
        
        CAKeyframeAnimation * rotateAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotateAnimation.values = @[@0,@M_PI,@(2 * M_PI)];
        rotateAnimation.keyTimes = scaleAnimation.keyTimes;
        rotateAnimation.duration = duration;
        rotateAnimation.timingFunctions = @[timingFunction,timingFunction];
        
        // animation group
        
        CAAnimationGroup * groupAnimation = [CAAnimationGroup animation];
        
        groupAnimation.duration = duration;
        groupAnimation.repeatCount = HUGE_VALF;
        groupAnimation.animations = @[scaleAnimation,rotateAnimation];

        
        // draw big circle
        CGFloat  circleSize = size.width;
        CAShapeLayer * circleShapeLayer = [CAShapeLayer layer];
        
        UIBezierPath * circlePath = [UIBezierPath bezierPath];
        
        [circlePath addArcWithCenter:CGPointMake(circleSize/2, circleSize/2) radius:circleSize/2 startAngle:-3 * M_PI/4 endAngle:-M_PI/4 clockwise:true];
        [circlePath moveToPoint:CGPointMake(circleSize/2 - circleSize/2 * cosf(M_PI/4), circleSize/2 + circleSize/2 * sinf(M_PI/4))];
        [circlePath addArcWithCenter:CGPointMake(circleSize/2, circleSize/2) radius:circleSize/2 startAngle:-5 * M_PI/4 endAngle:-7 * M_PI/4 clockwise:false];
        
        circleShapeLayer.path = circlePath.CGPath;
        circleShapeLayer.fillColor = nil;
        circleShapeLayer.lineWidth = 3;
        circleShapeLayer.strokeColor = tintColor.CGColor;
        [circleShapeLayer addAnimation:groupAnimation forKey:@"animation"];
        
        circleShapeLayer.frame = CGRectMake((layer.bounds.size.width - circleSize)/2, (layer.bounds.size.height - circleSize)/2, circleSize, circleSize);
        
        [layer addSublayer:circleShapeLayer];
    
    }

}

@end
