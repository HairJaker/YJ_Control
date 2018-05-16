//
//  UIView+Border.h
//  竞彩猫
//
//  Created by yujie on 2017/4/1.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Border)

-(CALayer *)addBottomBorderWithColor: (UIColor *) color andHeight:(CGFloat) borderHeight;
-(CALayer *)addLeftBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;
-(CALayer *)addRightBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;
-(CALayer *)addTopBorderWithColor: (UIColor *) color andHeight:(CGFloat) borderHeight;

-(void)removeBorder;

@end
