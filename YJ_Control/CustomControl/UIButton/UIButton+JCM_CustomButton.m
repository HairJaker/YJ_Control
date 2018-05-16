//
//  UIButton+JCM_CustomButton.m
//  竞彩猫
//
//  Created by yujie on 17/1/23.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "UIButton+JCM_CustomButton.h"

@implementation UIButton (JCM_CustomButton)

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
                      selectedImage:(UIImage *)selectedImage{
    
    UIButton * customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    customButton.frame = frame;
    [customButton setImage:normalImage forState:UIControlStateNormal];
    [customButton setImage:selectedImage forState:UIControlStateSelected];
    [customButton setBackgroundColor:backColor];
    [customButton setTitle:title forState:UIControlStateNormal];
    [customButton setTitleColor:titleColor forState:UIControlStateNormal];
    [customButton.titleLabel setFont:[UIFont systemFontOfSize:FONT_SIZE]];
    [customButton.layer setCornerRadius:cornerRadius];
    
    if (showBorder) {
        [customButton.layer setBorderWidth:1];
        [customButton.layer setBorderColor:borderColor.CGColor];
    }
    customButton.titleLabel.font = [UIFont fontWithName:fontName size:fontSize];
    
    return customButton;
}

@end
