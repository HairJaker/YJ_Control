//
//  JCM_ActivityIndicatorBallSpinFadeLaoderAnimation.m
//  竞彩猫
//
//  Created by yujie on 2017/4/19.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "JCM_ActivityIndicatorBallSpinFadeLaoderAnimation.h"

@implementation JCM_ActivityIndicatorBallSpinFadeLaoderAnimation



-(void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor{

    CGFloat circleSpacing = -2;
    CGFloat circleSize    = (size.width - 4 * circleSpacing)/5;
    
    CGFloat x = (layer.bounds.size.width - size.width)/2;
    CGFloat y = (layer.bounds.size.height - size.height)/2;
    
    CFTimeInterval duration = 1;
    NSTimeInterval beginTime = CACurrentMediaTime();
    
    NSArray * beginTimes = @[@0, @0.12, @0.24, @0.36, @0.48, @0.6, @0.72, @0.84];

    // scale animation
    
    CAKeyframeAnimation * scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    scaleAnimation.keyTimes = @[@0.0f,@0.5f,@1.0f];
    scaleAnimation.values = @[@1,@0.4,@1];
    scaleAnimation.duration = duration;
    
    // opacity animation
    
    CAKeyframeAnimation *opacityAnimaton = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    
    opacityAnimaton.keyTimes = @[@0, @0.5, @1];
    opacityAnimaton.values = @[@1, @0.3, @1];
    opacityAnimaton.duration = duration;
    
    // group animation
    
    CAAnimationGroup * groupAnimation = [CAAnimationGroup animation];
    
    groupAnimation.animations = @[scaleAnimation,opacityAnimaton];
    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    groupAnimation.duration = duration;
    groupAnimation.repeatCount = HUGE;
    groupAnimation.removedOnCompletion = NO;
    
    
    for (int i = 0; i < 8; i ++) {
        
        CALayer * circleLayer = [self circleLayer:(M_PI_4 * i) size:circleSize origin:CGPointMake(x, y) containerSize:size color:tintColor];
        
        groupAnimation.beginTime = beginTime + [beginTimes[i] doubleValue];
        
        [layer addSublayer:circleLayer];
        
        [circleLayer addAnimation:groupAnimation forKey:@"animation"];
        
    }
}

-(CALayer *)circleLayer:(CGFloat)angle
                   size:(CGFloat)size
                 origin:(CGPoint)origin
          containerSize:(CGSize)containerSize
                  color:(UIColor *)color{

    CGFloat radius = containerSize.width/2;
    
    CALayer * layer = [self createLayerWithSize:CGSizeMake(size, size) color:color];
    
    CGRect frame = CGRectMake((origin.x + radius * (cos(angle) + 1) - size/2), origin.y+radius * (sin(angle) + 1) - size/2, size, size);
    
    layer.frame = frame;
    
    return layer;

}

-(CALayer *)createLayerWithSize:(CGSize)size
                          color:(UIColor *)color{

    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    
    [bezierPath addArcWithCenter:CGPointMake(size.width/2, size.height/2) radius:size.width/2 startAngle:0 endAngle:2 * M_PI clockwise:NO];
    
    shapeLayer.fillColor = color.CGColor;
    shapeLayer.backgroundColor = nil;
    shapeLayer.path = bezierPath.CGPath;
    
    return shapeLayer;
    

}

@end
