//
//  JCM_GuideView.h
//  竞彩猫
//
//  Created by yujie on 17/1/18.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EuroTypeStartBlock)(void);

@interface JCM_GuideView : UIView

@property (nonatomic,copy) EuroTypeStartBlock euroTypeStartBlock;

-(instancetype)initWithFrame:(CGRect)frame
                      images:(NSArray *)images
                   guideType:(JCM_GuideType)guideType;

@end
