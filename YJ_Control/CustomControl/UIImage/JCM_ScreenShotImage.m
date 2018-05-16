//
//  JCM_ScreenShotImage.m
//  竞彩猫
//
//  Created by yujie on 17/3/9.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "JCM_ScreenShotImage.h"

@implementation JCM_ScreenShotImage

#pragma mark ---  截取当前屏幕视图  ----

//截屏
+(UIImage *)getScreenShotForImageWithView:(UIView *)view{
    
    int num = SCREEN_HEIGHT<=667?2:3;
    
    CGFloat aWidth = view.bounds.size.width,aHeight = view.bounds.size.height;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(aWidth*num, aHeight*num), YES, 0);     //设置截屏大小
    [[view layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef imageRef = viewImage.CGImage;
    
    CGRect rect = CGRectMake(0, 0, aWidth*num, aHeight*num);//这里可以设置想要截图的区域
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *resultImage = [[UIImage alloc] initWithCGImage:imageRefRect];
    
    CGImageRelease(imageRefRect);
    
    CGRect shotImgRect = CGRectMake(0, aHeight * num - 180*SCALE_ELEMENT * num, aWidth * num, 180*SCALE_ELEMENT * num);
    UIImage * screenImg = [self getCompoundImageWithBaseImage:resultImage subImage:[UIImage imageNamed:@"底部二维码.png"] subImageFrame:shotImgRect];
    
    return screenImg;
}

+(UIImage *)getCompoundImageWithBaseImage:(UIImage*)baseImage subImage:(UIImage *)subImage subImageFrame:(CGRect)frame{

    CGSize size = baseImage.size;
    
    UIGraphicsBeginImageContext(size);
    
    [baseImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    [subImage drawInRect:frame];
    
    UIImage *resultImage =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultImage;

}

@end
