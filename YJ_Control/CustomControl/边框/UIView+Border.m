//
//  UIView+Border.m
//  竞彩猫
//
//  Created by yujie on 2017/4/1.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "UIView+Border.h"


@implementation UIView (Border)

-(CALayer *)addTopBorderWithColor:(UIColor *)color andHeight:(CGFloat)borderHeight{
    
    CALayer * topBorderLayer = [CALayer layer];
    topBorderLayer.frame = CGRectMake(0, 0, self.frame.size.width, borderHeight);
    [topBorderLayer setBackgroundColor:color.CGColor];
    
    [self.layer addSublayer:topBorderLayer];
    
    return topBorderLayer;
}

-(CALayer *)addBottomBorderWithColor:(UIColor *)color andHeight:(CGFloat) borderHeight{
    
    CALayer * bottomBorderLayer = [CALayer layer];
    bottomBorderLayer.frame = CGRectMake(0, self.frame.size.height - borderHeight, self.frame.size.width, borderHeight);
    [bottomBorderLayer setBackgroundColor:color.CGColor];
    
    [self.layer addSublayer:bottomBorderLayer];
    
    return bottomBorderLayer;
    
}
-(CALayer *)addLeftBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth{
    
    CALayer * leftBorderLayer = [CALayer layer];
    leftBorderLayer.frame = CGRectMake(0, 0, borderWidth, self.frame.size.height);
    [leftBorderLayer setBackgroundColor:color.CGColor];
    
    [self.layer addSublayer:leftBorderLayer];
    
    return leftBorderLayer;
    
}
-(CALayer *)addRightBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth{
    
    CALayer * rightBorderLayer = [CALayer layer];
    rightBorderLayer.frame = CGRectMake(self.frame.size.width - borderWidth, 0, borderWidth, self.frame.size.height);
    [rightBorderLayer setBackgroundColor:color.CGColor];
    
    [self.layer addSublayer:rightBorderLayer];
    
    return rightBorderLayer;
    
}

-(void)removeBorder{
    
    
    //    if ([self isKindOfClass:[UIButton class]]) {
    //        for (int i = 0; i < self.layer.sublayers.count; i ++) {
    //            if (i != 0) {
    //                CALayer * layer = [self.layer.sublayers objectAtIndex:i];
    //                [layer removeFromSuperlayer];
    //                layer = nil;
    //
    //            }
    //        }
    //    }
    
    
    for (int i = 0; i < self.layer.sublayers.count; i ++) {
        if (i != 0) {
            [[self.layer.sublayers objectAtIndex:i] removeFromSuperlayer];
        }
    }
    
}

@end
