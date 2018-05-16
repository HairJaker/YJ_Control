//
//  JCM_BasePageViewController.h
//  竞彩猫
//
//  Created by yujie on 17/3/9.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,JCM_PageType){

    JCM_PageTypeButton,
    JCM_PageTypeArrows,
    JCM_PageTypeSegment

};

@protocol JCM_BasePageViewDataSource <NSObject>

@required

-(NSArray *)pageButtons;

-(NSArray *)pageControllers;

-(UIView *)pageContainerView;

@optional

-(void)otherConfiguration;

@end

@protocol JCM_BasePageViewDelegate <NSObject>

@optional

-(void)pageViewMoveToIndex:(NSInteger)index;

-(NSInteger)currentSelectedIndex;

@end


@interface JCM_BasePageViewController : UIPageViewController

@property (nonatomic,assign) id<JCM_BasePageViewDataSource> pageDataSource;

@property (nonatomic,assign) id<JCM_BasePageViewDelegate> pageDelegate;

@property (nonatomic,assign) JCM_PageType pageType;

-(void)reloadPagesData;

- (void)reloadPagesToCurrentPageIndex:(NSInteger)currentPageIndex;

- (void)moveToViewNumber:(NSInteger)viewNumber ;
- (void)moveToViewNumber:(NSInteger)viewNumber animated:(BOOL)animated;

@end
