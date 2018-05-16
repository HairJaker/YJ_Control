//
//  JCM_ScreenShotImage.h
//  竞彩猫
//
//  Created by yujie on 17/3/9.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCM_ScreenShotImage : UIImage

+(UIImage *)getScreenShotForImageWithView:(UIView *)view;

+(UIImage *)getCompoundImageWithBaseImage:(UIImage*)baseImage subImage:(UIImage *)subImage subImageFrame:(CGRect)frame;

@end
