//
//  JCM_MenuView.h
//  竞彩猫
//
//  Created by yujie on 2017/9/4.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JCM_MenuDataSource <NSObject>

@required

-(NSMutableArray *)menuTitles;


@end

@protocol JCM_MenuDelegate <NSObject>

@optional

@end


typedef void(^MenuChooseBlock)(int  index);

@interface JCM_MenuView : UIView

@property (nonatomic ,strong) NSMutableArray * items;
@property (nonatomic ,strong) NSMutableArray * titles;

-(instancetype)initWithFrame:(CGRect)frame;

-(void)menuChooseAction:(UIButton *)sender;

-(void)reloadItmesFrameWithFrame:(CGRect)frame;

@property (nonatomic,copy) MenuChooseBlock menuChooseBlock;

@property (nonatomic,assign) id<JCM_MenuDataSource> dataSource;
@property (nonatomic,assign) id<JCM_MenuDelegate>   delegate;

-(void)reloadMenuItems;

@end
