//
//  UIImageView+JCM_CustomImgView.h
//  竞彩猫
//
//  Created by yujie on 2017/5/3.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (JCM_CustomImgView)

+(UIImageView *)createImgViewWithFrame:(CGRect)frame
                          cornerRadius:(CGFloat)cornerRadius
                                 image:(UIImage *)image;

@end
