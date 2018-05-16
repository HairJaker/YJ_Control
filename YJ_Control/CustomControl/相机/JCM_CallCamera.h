//
//  JCM_CallCamera.h
//  竞彩猫
//
//  Created by yujie on 2017/5/11.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^JCM_ChoosedPhotoBlock)(UIImage * img);

@interface JCM_CallCamera : NSObject

@property (nonatomic,copy) JCM_ChoosedPhotoBlock  choosedPhotoBlock;

@property (nonatomic,strong) JCM_BaseViewController *  baseViewController;

+ (JCM_CallCamera *)sharedModel;

+(void)sendImageWithBlock:(JCM_ChoosedPhotoBlock)choosedPhotoBlock;

@end
