//
//  JCM_ActivityIndicatorBallRotateAnimation.m
//  竞彩猫
//
//  Created by yujie on 2017/4/18.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "JCM_ActivityIndicatorBallRotateAnimation.h"

@implementation JCM_ActivityIndicatorBallRotateAnimation

-(void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor{

    CGFloat  duration = 1.0f;
    CGFloat  circleSize = size.width/5;
    CAMediaTimingFunction * timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.7f :-0.13f :0.22f :0.86f];
    
    // scale animation
    
    CAKeyframeAnimation * scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    scaleAnimation.keyTimes = @[@0.0f, @0.5f, @1.0f];
    scaleAnimation.values   = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)],
                                [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.6f, 0.6f, 1.0f)],
                                [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)]];
    scaleAnimation.duration = duration;
    scaleAnimation.timingFunctions = @[timingFunction,timingFunction];
    
    // rotate animation
    
    CAKeyframeAnimation * rotateAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.ratition.z"];
    
    rotateAnimation.keyTimes = @[@0.0f, @0.5f, @1.0f];
    rotateAnimation.values   = @[@0.0f,@-M_PI,@(-2 * M_PI)];
    rotateAnimation.duration = duration;
    rotateAnimation.timingFunctions = @[timingFunction,timingFunction];
    
    // animation
    CAAnimationGroup * groupAnimation = [CAAnimationGroup animation];
    
    groupAnimation.animations = @[scaleAnimation,rotateAnimation];
    groupAnimation.duration = duration;
    groupAnimation.repeatCount = HUGE_VALF;
    
    // draw circles
    
    
    // left layer
    CGRect layerFrame = CGRectMake(0, (size.height - circleSize)/2, circleSize, circleSize);
    
    CALayer * leftLayer = [self createLayerWithFrame:layerFrame color:tintColor cornerRadius:circleSize];
    
    // right layer
    layerFrame = CGRectMake(size.width - circleSize, (size.height - circleSize) / 2, circleSize, circleSize);
    
    CALayer * rightLayer = [self createLayerWithFrame:layerFrame color:tintColor cornerRadius:circleSize];
    
    // center layer
    
    layerFrame = CGRectMake((size.width - circleSize)/2, (size.height - circleSize)/2, circleSize, circleSize);
    CALayer * centerLayer = [self createLayerWithFrame:layerFrame color:tintColor cornerRadius:circleSize];
    
    
    // layer
    
    CALayer * circleLayer = [CALayer layer];
    
    circleLayer.frame = CGRectMake((layer.bounds.size.width - size.width)/2, (layer.bounds.size.height - size.height)/2, size.width, size.height);
    
    [circleLayer addSublayer:leftLayer];
    [circleLayer addSublayer:rightLayer];
    [circleLayer addSublayer:centerLayer];
    
    [circleLayer addAnimation:groupAnimation forKey:@"animation"];
    
    [layer addSublayer:circleLayer];

}

-(CALayer *)createLayerWithFrame:(CGRect)frame
                           color:(UIColor *)color
                    cornerRadius:(CGFloat)cornerRadius{

    CALayer * layer = [CALayer layer];
    
    layer.backgroundColor = color.CGColor;
    layer.opacity = 0.8f;
    layer.cornerRadius = cornerRadius/2;

    layer.frame = frame;
    
    return layer;
}

@end
