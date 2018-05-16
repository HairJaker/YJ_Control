//
//  JCM_AlertView.h
//  竞彩猫
//
//  Created by yujie on 2017/4/1.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCM_AlertView : UIView

- (id)initWithTitle:(NSString *)title
        contentText:(NSString *)contentText
    removeLoginTime:(NSString *)removeLoginTime
         deviceName:(NSString *)deviceName
    leftButtonTitle:(NSString *)leftButtonTitle
   rightButtonTitle:(NSString *)rightButtonTitle
      alertViewType:(JCM_AlertViewType)alertType
              price:(NSString *)price
            balance:(NSString *)balance
  customContentText:(NSMutableAttributedString *)customContentText;

-(void)show;

@property (nonatomic,copy) dispatch_block_t leftBlock;
@property (nonatomic,copy) dispatch_block_t rightBlock;
@property (nonatomic,copy) dispatch_block_t dismissBlock;

@end


@interface UIImage (colorful)

+ (UIImage *)imageWithColor:(UIColor *)color;

@end
