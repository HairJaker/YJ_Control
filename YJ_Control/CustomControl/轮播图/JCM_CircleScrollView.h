//
//  JCM_CircleScrollView.h
//  竞彩猫
//
//  Created by yujie on 17/1/10.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JCM_CircleListModel;

@protocol JCM_CircleDataSource

@required

-(JCM_CircleListModel *)circleDataModel;

@end

@protocol JCM_CircleDelegate

@optional


@end

//typedef void(^CircleImgViewTapBlock)(JCM_CircleModel * model);

@interface JCM_CircleScrollView : UIView

@property (nonatomic,assign) id<JCM_CircleDataSource> circleDataSource;

@property (nonatomic,assign) id<JCM_CircleDelegate> circleDelegate;

//@property (nonatomic,copy)CircleImgViewTapBlock imgTapBlock;

-(instancetype)initWithFrame:(CGRect)frame;

-(void)reloadCircleView;

-(void)setDefaultImage;

@end
