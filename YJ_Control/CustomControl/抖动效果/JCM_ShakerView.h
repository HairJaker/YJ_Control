//
//  JCM_ShakerView.h
//  竞彩猫
//
//  Created by yujie on 2017/5/5.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCM_ShakerView : NSObject

-(instancetype)initWithView:(UIView *)view;

-(instancetype)initWithViews:(NSArray *)views;

-(void)shake;

-(void)shakeWithDuration:(NSTimeInterval)duration completion:(void(^)(void))completion;

@end
