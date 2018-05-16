//
//  JCM_ShakerView.m
//  竞彩猫
//
//  Created by yujie on 2017/5/5.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "JCM_ShakerView.h"

static  NSTimeInterval const kShakerViewDefaultDutation = 0.5;
static  NSString * const kShakerViewAnimationKey = @"kShakerViewAnimationKey";

@interface JCM_ShakerView ()<CAAnimationDelegate>

@property (nonatomic, strong) NSArray * views;
@property (nonatomic, assign) NSUInteger completedAnimations;
@property (nonatomic, copy) void (^completionBlock)(void);

@end

@implementation JCM_ShakerView

- (instancetype)initWithView:(UIView *)view {
    return [self initWithViews:@[view]];
}

- (instancetype)initWithViews:(NSArray *)views{
    self = [super init];
    if ( self ) {
        self.views = views;
    }
    return self;
}

#pragma mark  -- methods --

-(void)shake{
    
    [self shakeWithDuration:kShakerViewDefaultDutation completion:nil];
    
}

- (void)shakeWithDuration:(NSTimeInterval)duration completion:(void (^)(void))completion {
    self.completionBlock = completion;
    for (UIView * view in self.views) {
        [self addShakeAnimationForView:view withDuration:duration];
    }
}

#pragma mark - Shake Animation

- (void)addShakeAnimationForView:(UIView *)view withDuration:(NSTimeInterval)duration {
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.delegate = self;
    animation.duration = duration;
    animation.values = @[ @(0), @(10), @(-8), @(8), @(-5), @(5), @(0) ];
    animation.keyTimes = @[ @(0), @(0.225), @(0.425), @(0.6), @(0.75), @(0.875), @(1) ];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer addAnimation:animation forKey:kShakerViewAnimationKey];
}


#pragma mark - CAAnimation Delegate

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag {
    self.completedAnimations += 1;
    if ( self.completedAnimations >= self.views.count ) {
        self.completedAnimations = 0;
        if ( self.completionBlock ) {
            self.completionBlock();
        }
    }
}


@end
