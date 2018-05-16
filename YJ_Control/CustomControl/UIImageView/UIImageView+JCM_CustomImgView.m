//
//  UIImageView+JCM_CustomImgView.m
//  竞彩猫
//
//  Created by yujie on 2017/5/3.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "UIImageView+JCM_CustomImgView.h"

@implementation UIImageView (JCM_CustomImgView)

+(UIImageView *)createImgViewWithFrame:(CGRect)frame
                          cornerRadius:(CGFloat)cornerRadius
                                 image:(UIImage *)image{

    UIImageView * imgView = [[UIImageView alloc]initWithFrame:frame];
    
    if (image) {
        imgView.image = image;
    }

    imgView.contentMode = UIViewContentModeScaleToFill;
    
    imgView.clipsToBounds = YES;
    
    imgView.layer.cornerRadius = cornerRadius;
    
    imgView.userInteractionEnabled = YES;
    
    return imgView;

}

@end
