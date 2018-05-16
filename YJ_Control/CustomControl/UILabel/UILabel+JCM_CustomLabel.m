//
//  UILabel+JCM_CustomLabel.m
//  竞彩猫
//
//  Created by yujie on 2017/4/1.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "UILabel+JCM_CustomLabel.h"

@implementation UILabel (JCM_CustomLabel)

+(UILabel *)createLabelWithFrame:(CGRect)frame
                            text:(NSString *)text
                       backColor:(UIColor *)backColor
                       textColor:(UIColor *)textColor
                      showBorder:(BOOL)showBorder
                        fontSize:(CGFloat)fontSize
                     borderColor:(UIColor *)borderColor
                    cornerRadius:(CGFloat)cornerRadius{

    UILabel * label = [[UILabel alloc]initWithFrame:frame];
    label.text = text;
    label.textColor = textColor;
    if (backColor) {
        label.backgroundColor = backColor;
    }else{
        label.backgroundColor = [UIColor clearColor];
    }
    
    label.font = [UIFont systemFontOfSize:fontSize];
    if (showBorder) {
        label.layer.borderWidth = 1;
        label.layer.borderColor = borderColor.CGColor;
    }
    label.layer.cornerRadius = cornerRadius;
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;

}

@end
