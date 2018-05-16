//
//  JCM_FiltrateView.h
//  竞彩猫
//
//  Created by yujie on 2017/5/26.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FiltrateViewBackActBlock)(NSMutableArray * chooseArray);

@interface JCM_FiltrateView : UIView

@property (nonatomic,strong) UIView * headView;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UIButton * backButton;
@property (nonatomic,strong) UITableView * filtrateTableView;

@property (nonatomic,strong) UIButton * allChooseButton;
@property (nonatomic,strong) UIButton * affirmButton;

@property (nonatomic,strong) NSMutableArray * filtrateSclassData;
@property (nonatomic,strong) NSMutableArray * normalChooseData;

-(instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic,copy) FiltrateViewBackActBlock filtrateBackBlock;

-(void)setBackButtonTitle:(NSString *)title imageName:(NSString *)imageName;

-(void)setHeadViewTitleLabelTextWith:(NSString *)text;


@end
