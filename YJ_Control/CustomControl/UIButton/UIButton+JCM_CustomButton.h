//
//  UIButton+JCM_CustomButton.h
//  竞彩猫
//
//  Created by yujie on 17/1/23.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (JCM_CustomButton)

//  主要配置
+(UIButton * )createButtonWithFrame:(CGRect)frame
                              title:(NSString *)title
                           fontSize:(CGFloat)fontSize
                           fontName:(NSString *)fontName
                          backColor:(UIColor *)backColor
                         titleColor:(UIColor *)titleColor
                         showBorder:(BOOL)showBorder
                        borderColor:(UIColor *)borderColor
                        normalImage:(UIImage *)normalImage
                       cornerRadius:(CGFloat)cornerRadius
                      selectedImage:(UIImage *)selectedImage;

@end
