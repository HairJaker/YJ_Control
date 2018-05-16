//
//  JCM_ActivityIndicatorAnimationProtocol.h
//  竞彩猫
//
//  Created by yujie on 2017/4/13.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JCM_ActivityIndicatorAnimationProtocol <NSObject>

-(void)setupAnimationInLayer:(CALayer*)layer
                    withSize:(CGSize)size
                   tintColor:(UIColor*)tintColor;

@end
