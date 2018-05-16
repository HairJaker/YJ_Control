//
//  MBProgressHUD+JCM_Progress.h
//  竞彩猫
//
//  Created by yujie on 17/1/10.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (JCM_Progress)

+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view;

+ (void)hideHUD;

+ (void)hideHUDForView:(UIView *)view;

+ (MBProgressHUD *)showProgress:(NSString *)title toView:(UIView *)view afterDelay:(NSTimeInterval)delay;

+ (MBProgressHUD *)showProgress:(UIView *)view;

@end
