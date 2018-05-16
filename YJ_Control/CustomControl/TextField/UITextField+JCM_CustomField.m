//
//  UITextField+JCM_CustomField.m
//  竞彩猫
//
//  Created by yujie on 2017/5/4.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "UITextField+JCM_CustomField.h"


@implementation UITextField (JCM_CustomField)

+(UITextField *)createTextFieldWithFrame:(CGRect)frame
                             placeholder:(NSString *)placeholder
                         secureTextEntry:(BOOL)secureTextEntry
                        leftImgViewFrame:(CGRect)leftImgViewFrame
                             leftImgName:(NSString *)leftImgName{
    
    UITextField * textField = [[UITextField alloc]initWithFrame:frame];
    textField.placeholder  = placeholder;
    
    //     设置 placeholder
    if (placeholder) {
        
        NSMutableParagraphStyle *style = [textField.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
        
        style.minimumLineHeight = textField.font.lineHeight - (textField.font.lineHeight - [UIFont systemFontOfSize:38 *SCALE_ELEMENT].lineHeight) / 2.0;
        
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder
                                                                          attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#C5C5C5" withAlpha:1.0f],
                                                                                       NSFontAttributeName : [UIFont systemFontOfSize:38 * SCALE_ELEMENT]}
                                           ];
    }
    
    textField.font = [UIFont systemFontOfSize:38 * SCALE_ELEMENT];
    textField.secureTextEntry = secureTextEntry;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    if (leftImgName) {
        
        UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100 * SCALE_ELEMENT, 120 * SCALE_ELEMENT)];
        
        leftView.backgroundColor = [UIColor clearColor];
        
        UIImageView * leftImgView = [UIImageView createImgViewWithFrame:leftImgViewFrame cornerRadius:0 image:[UIImage imageNamed:leftImgName]];
        [leftView addSubview:leftImgView];
        
        textField.leftView = leftView;
        textField.leftViewMode = UITextFieldViewModeAlways;
        
    }else{
        [textField setValue:[NSNumber numberWithInt:8] forKey:@"paddingLeft"];
    }
    
    return textField;
}

@end
