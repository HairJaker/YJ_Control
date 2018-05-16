//
//  UILabel+JCM_CustomLabel.h
//  竞彩猫
//
//  Created by yujie on 2017/4/1.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (JCM_CustomLabel)

+(UILabel *)createLabelWithFrame:(CGRect)frame
                            text:(NSString *)text
                       backColor:(UIColor *)backColor
                       textColor:(UIColor *)textColor
                      showBorder:(BOOL)showBorder
                        fontSize:(CGFloat)fontSize
                     borderColor:(UIColor *)borderColor
                    cornerRadius:(CGFloat)cornerRadius;

@end
