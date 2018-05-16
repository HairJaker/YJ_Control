//
//  UITextField+JCM_CustomField.h
//  竞彩猫
//
//  Created by yujie on 2017/5/4.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (JCM_CustomField)

+(UITextField *)createTextFieldWithFrame:(CGRect)frame
                             placeholder:(NSString *)placeholder
                         secureTextEntry:(BOOL)secureTextEntry
                        leftImgViewFrame:(CGRect)leftImgViewFrame
                             leftImgName:(NSString *)leftImgName;

@end
