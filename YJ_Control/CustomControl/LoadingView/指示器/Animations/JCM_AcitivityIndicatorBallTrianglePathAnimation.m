//
//  JCM_AcitivityIndicatorBallTrianglePathAnimation.m
//  竞彩猫
//
//  Created by yujie on 2017/5/2.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "JCM_AcitivityIndicatorBallTrianglePathAnimation.h"

@implementation JCM_AcitivityIndicatorBallTrianglePathAnimation

-(void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor{

    CGFloat  duration = 2.0f;
    CGFloat  circleSize = size.width/5;
    CGFloat  deltaX = size.width/2 - circleSize/2;
    CGFloat  deltaY = size.height/2 - circleSize/2;
    CGFloat  x = (layer.bounds.size.width - size.width)/2;
    CGFloat  y = (layer.bounds.size.height - size.height)/2;
    
    CAMediaTimingFunction * timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    // transform animation
    
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.keyTimes = @[@0.0f,@0.33f,@0.66f,@1.0f];
    animation.duration = duration;
    animation.timingFunctions = @[timingFunction,timingFunction,timingFunction,timingFunction,timingFunction];
    animation.repeatCount = HUGE_VALF;
    
    // top - center circle
    
    CALayer * topCenterCircle = [self createCircleWithSize:circleSize color:tintColor];

    [self changeAnimation:animation values:@[@"{0,0}",@"{hx,hy}",@"-hx,fy",@"0,0"] delatX:deltaX delatY:deltaY];
    topCenterCircle.frame = CGRectMake(x + (size.width - circleSize)/2, y, circleSize, circleSize);
    [layer addSublayer:topCenterCircle];
    
    // bottom - left circle
    CALayer *bottomLeftCircle = [self createCircleWithSize:circleSize color:tintColor];
    
    [self changeAnimation:animation values:@[@"{0,0}", @"{hx,-fy}", @"{fx,0}", @"{0,0}"] delatX:deltaX delatY:deltaY];
    bottomLeftCircle.frame = CGRectMake(x, y + size.height - circleSize, circleSize, circleSize);
    [bottomLeftCircle addAnimation:animation forKey:@"animation"];
    [layer addSublayer:bottomLeftCircle];
    
    // Bottom-right circle
    CALayer *bottomRigthCircle = [self createCircleWithSize:circleSize color:tintColor];
    
    [self changeAnimation:animation values:@[@"{0,0}", @"{-fx,0}", @"{-hx,-fy}", @"{0,0}"] delatX:deltaX delatY:deltaY];
    bottomRigthCircle.frame = CGRectMake(x + size.width - circleSize, y + size.height - circleSize, circleSize, circleSize);
    [bottomRigthCircle addAnimation:animation forKey:@"animation"];
    [layer addSublayer:bottomRigthCircle];

}

-(CALayer *)createCircleWithSize:(CGFloat)size color:(UIColor *)color{

    CAShapeLayer * circleShapeLayer = [CAShapeLayer layer];
    
    UIBezierPath * circlePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size, size) cornerRadius:size/2];
    
    circleShapeLayer.fillColor = nil;
    circleShapeLayer.strokeColor = color.CGColor;
    circleShapeLayer.path = circlePath.CGPath;
    circleShapeLayer.lineWidth = 1;
    
    return circleShapeLayer;

}

-(CAAnimation *)changeAnimation:(CAKeyframeAnimation *)animation
                         values:(NSArray *)rawValues
                         delatX:(CGFloat)delatX
                         delatY:(CGFloat)delatY{

    NSMutableArray * values = [NSMutableArray arrayWithCapacity:5];
    
    for (NSString * rawValue in rawValues) {
        
        CGPoint point = CGPointFromString([self translate:rawValue withDelatX:delatX withDelatY:delatY]);
        
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(point.x, point.y, 0.0f)]];
    }
    animation.values = values;
    
    return animation;

}

-(NSString *)translate:(NSString *)valueString
            withDelatX:(CGFloat)delatX
            withDelatY:(CGFloat)delatY{

    NSMutableString * valueMutableString = [NSMutableString stringWithString:valueString];
    
    CGFloat fullDelatX = 2 * delatX;
    CGFloat fullDelatY = 2 * delatY;
    NSRange rang ;
    
    rang.location = 0;
    
    rang.length = valueString.length;
    [valueMutableString replaceOccurrencesOfString:@"hx" withString:[NSString stringWithFormat:@"%f",delatX] options:NSCaseInsensitiveSearch range:rang];
    
    rang.length = valueMutableString.length;
    [valueMutableString replaceOccurrencesOfString:@"fx" withString:[NSString stringWithFormat:@"%f",fullDelatX] options:NSCaseInsensitiveSearch range:rang];
    
    rang.length = valueMutableString.length;
    [valueMutableString replaceOccurrencesOfString:@"hy" withString:[NSString stringWithFormat:@"%f",delatY] options:NSCaseInsensitiveSearch range:rang];
    
    rang.length = valueMutableString.length;
    [valueMutableString replaceOccurrencesOfString:@"fy" withString:[NSString stringWithFormat:@"%f",fullDelatY] options:NSCaseInsensitiveSearch range:rang];
    
    return valueMutableString;
}

@end
