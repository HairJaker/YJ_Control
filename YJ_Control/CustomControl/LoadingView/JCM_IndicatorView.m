//
//  JCM_IndicatorView.m
//  竞彩猫
//
//  Created by yujie on 17/1/17.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "JCM_IndicatorView.h"

@implementation JCM_IndicatorView
{
    BOOL isend;
    UIView * backView;
    UILabel * label;
}

- (void)drawRect:(CGRect)rect {
    
    [self drawInnerPathWithRect:rect];   //  内圈
    [self drawMiddlePathWithRect:rect];  //  中间
    [self drawOuterPathWithRect:rect];   //  外圈
    
}
//   内圈路线
-(void)drawInnerPathWithRect:(CGRect)rect
{
    CGPoint center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    CGFloat radius = rect.size.width / 2 - 19;
    CGFloat start = - M_PI_2 + self.timeFlag * 1.1*M_PI;
    CGFloat end = -M_PI_2 + 0.45 * 2 * M_PI  + self.timeFlag * 1.1 *M_PI-1.3333;
    
    UIBezierPath* innerPath = [UIBezierPath bezierPath];
    [innerPath addArcWithCenter:center radius:radius startAngle:start endAngle:end clockwise:YES];
    if (!self.innerColor) {
        self.innerColor = [UIColor colorWithRed:253/255.0 green:125.0/255.0 blue:7.0/255.0 alpha:1];
    }
    [self.innerColor setStroke];
    innerPath.lineWidth = 3;
    [innerPath stroke];
}
//   中间圈路线
-(void)drawMiddlePathWithRect:(CGRect)rect
{
    UIBezierPath* middlePath = [UIBezierPath bezierPath];
    //    NSLog(@"timeflag %f",self.timeFlag);
    
    CGPoint center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    CGFloat radius = rect.size.width / 2 - 12;
    CGFloat start = - M_PI_2 + self.timeFlag * 0.8*M_PI;
    CGFloat end = -M_PI_2 + 0.45 * 2 * M_PI  + self.timeFlag * 0.8 *M_PI-1.3333;
    [middlePath addArcWithCenter:center radius:radius startAngle:start endAngle:end clockwise:YES];
    if (!self.middleColor) {
        self.middleColor = [UIColor colorWithRed:28/255.0 green:181.0/255.0 blue:224.0/255.0 alpha:1];
    }
    [self.middleColor setStroke];
    middlePath.lineWidth = 3;
    [middlePath stroke];
}
//  外圈路线
-(void)drawOuterPathWithRect:(CGRect)rect
{
    UIBezierPath* outerPath = [UIBezierPath bezierPath];
    CGPoint center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    CGFloat radius = rect.size.width / 2 - 5;
    CGFloat start = - M_PI_2 + self.timeFlag * 0.5*M_PI;
    CGFloat end = -M_PI_2 + 0.45 * 2 * M_PI  + self.timeFlag * 0.5 *M_PI-1.3333;
    
    [outerPath addArcWithCenter:center radius:radius startAngle:start endAngle:end clockwise:YES];
    if (!self.outerColor) {
        self.outerColor = [UIColor colorWithRed:39/255.0 green:165.0/255.0 blue:97.0/255.0 alpha:1] ;
    }
    [self.outerColor setStroke];
    outerPath.lineWidth = 3;
    [outerPath stroke];
}

static JCM_IndicatorView* tmpview ;
static UIView * backView;
+(void)showInView:(UIView *)view title:(NSString *)title
{
    if (backView) {
        
        [tmpview removeFromSuperview];
        [backView removeFromSuperview];
        backView = nil;
        tmpview = nil;
        
        [tmpview stopAnimation];
    }
    CGFloat  backViewWidth = title?60.0f:50.0f;
    
    backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, backViewWidth, backViewWidth)];
    //    if (title) {
    //        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, backViewWidth, backViewWidth - 50)];
    //        label.text = @"加载中...";
    //        label.textAlignment = NSTextAlignmentCenter;
    //        label.font = [UIFont systemFontOfSize:12.0f];
    //        label.textColor = [UIColor redColor];
    //        [backView addSubview:label];
    //    }
    view = [UIApplication sharedApplication].keyWindow.rootViewController.view;
    
    backView.center = view.center;
    [view addSubview:backView];
    
    JCM_IndicatorView* indicatorView = [[JCM_IndicatorView  alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    indicatorView.backgroundColor = [UIColor clearColor];
    indicatorView.timeFlag = 0;
    [backView addSubview:indicatorView];
    
    [indicatorView startAnimation];
    tmpview = indicatorView;
}
+(void)dismiss
{
    
    [tmpview removeFromSuperview];
    [backView removeFromSuperview];
    
    backView = nil;
    tmpview = nil;
    
    [tmpview stopAnimation];
}
-(void)stopAnimation
{
    isend = YES;
    [self.timer invalidate];
    self.timer = nil;
    [self setNeedsDisplay];
}
-(void)startAnimation{
    
    isend = NO;
    [self.timer invalidate];
    self.timer = nil;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(continueAnimation) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer: self.timer forMode:NSRunLoopCommonModes];
    
    [self.timer fire];
    
}

#define speed 0.04f     //数值越小越慢

-(void)continueAnimation{
    
    self.timeFlag += speed;
    [self setNeedsDisplay];
    
}

@end
