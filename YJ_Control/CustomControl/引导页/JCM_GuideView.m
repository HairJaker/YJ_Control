//
//  JCM_GuideView.m
//  竞彩猫
//
//  Created by yujie on 17/1/18.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "JCM_GuideView.h"

#import "AppDelegate.h"

@interface JCM_GuideView()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView * guideScrollView;
@property (nonatomic,strong) UIPageControl * pageControl;

@property (nonatomic,strong) NSArray * images;

@property (nonatomic,assign) JCM_GuideType currentGuideType;
@end

@implementation JCM_GuideView

-(instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images guideType:(JCM_GuideType)guideType
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _images = images;
        
        _currentGuideType = guideType;
        
        [self addGuideScrollViewWithFrame:frame];
    }
    return self;
}

#pragma mark  -  初始化引导页 ----

-(void)addGuideScrollViewWithFrame:(CGRect)frame{
    
    _guideScrollView = [[UIScrollView alloc]initWithFrame:frame];
    _guideScrollView.backgroundColor = [UIColor redColor];
    [_guideScrollView setContentSize:CGSizeMake(frame.size.width * _images.count, frame.size.height)];
    [_guideScrollView setPagingEnabled:YES];
    [_guideScrollView setBounces:NO];
    _guideScrollView.delegate = self;
    _guideScrollView.userInteractionEnabled = YES;
    //    去掉滚动条
    [_guideScrollView setShowsHorizontalScrollIndicator:NO];
    [_guideScrollView setShowsVerticalScrollIndicator:NO];
    [self addSubview:_guideScrollView];
    
    CGRect rect  = CGRectZero;
    
    for (int i = 0 ; i < _images.count; i ++) {
        
        rect  = CGRectMake(frame.size.width * i, 0, frame.size.width, frame.size.height);
        
        UIImageView *iv = [[UIImageView alloc]init];
        iv.frame = rect;
        iv.userInteractionEnabled = YES;
        iv.image = [_images objectAtIndex:i];
        [_guideScrollView addSubview:iv];
        
        if (_currentGuideType == JCM_GuideTypeHome) {
            if (i == _images.count - 1) {
                [self addStartButton];
            }
        }else{
            
            [self addGuideButtonWithImgView:iv index:i];
            
        }
    }
    
    //    CGFloat  margin  = BIG_MARGIN  * _images.count;
    
    if (_currentGuideType == JCM_GuideTypeHome) {
        //        rect = CGRectMake(_images.count/2*margin, frame.size.height - margin, frame.size.width - margin * _images.count, 20);
        //
        //        _pageControl = [[UIPageControl alloc]initWithFrame:rect];
        //        _pageControl.numberOfPages = _images.count;
        //        _pageControl.tintColor = [UIColor whiteColor];
        //        [self addSubview:_pageControl];
    }
    
}

#pragma mark  -- 欧亚引导按钮  --

-(void)addGuideButtonWithImgView:(UIImageView *)iv index:(int)index{
    
    int  startButtonWidth = 362 * SCALE_ELEMENT,buttonHeight = 142 * SCALE_ELEMENT;
    int  xMar = (SCREEN_WIDTH - startButtonWidth)/2;
    int  bottomY  = 226 * SCALE_ELEMENT;
    
    CGRect  startButtonRect = CGRectMake(xMar, SCREEN_HEIGHT - (buttonHeight + bottomY), startButtonWidth, buttonHeight);
    
    UIButton * startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [startButton setFrame:startButtonRect];
    startButton.tag = index;
    [startButton addTarget:self action:@selector(euroGuideStart:) forControlEvents:UIControlEventTouchUpInside];
    [iv addSubview:startButton];
    
}

-(void)euroGuideStart:(UIButton *)sender{
    
    switch (sender.tag) {
        case 0:
            [_guideScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0)];
            break;
        case 1:
            [self guideStart];
            break;
        default:
            break;
    }
    
}

#pragma mark -----   启动按钮  -------

-(void)addStartButton
{
    
    int  startButtonWidth = 232 * SCALE_ELEMENT,startButtonHeight = 70 * SCALE_ELEMENT,bottonY = 32 * SCALE_ELEMENT;
    
    CGRect  startButtonRect = CGRectMake(_guideScrollView.contentSize.width - SCREEN_WIDTH/2 - startButtonWidth/2, SCREEN_HEIGHT - (startButtonHeight + bottonY), startButtonWidth, startButtonHeight);
    
    UIButton * startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [startButton setFrame:startButtonRect];
    [startButton addTarget:self action:@selector(guideStart) forControlEvents:UIControlEventTouchUpInside];
    [_guideScrollView addSubview:startButton];
    
}
//  --------  start  -----

-(void)guideStart{
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    if (_currentGuideType == JCM_GuideTypeHome) {
        [userDefaults setValue:CURRENT_VERSION forKey:@"currentVersion"];
    }else{
        [userDefaults setValue:@"1" forKey:@"euroGuideIsNotShow"];
        
        self.euroTypeStartBlock();
        
    }
    
    [UIView animateWithDuration:.2 animations:^{
        _guideScrollView.alpha = 0.0f;
        _pageControl.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        [_guideScrollView removeFromSuperview];
        [_pageControl removeFromSuperview];
        [self removeFromSuperview];
        
    }];
    
    //    AppDelegate * deleg = [[AppDelegate alloc]init];
    //    [deleg.window requestTabBarState];
    
}

#pragma mark  -  scroll view delegate  ---

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int index= scrollView.contentOffset.x/scrollView.bounds.size.width;
    
    [_pageControl setCurrentPage:index];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (scrollView.contentOffset.x == (GUIDE_COUNT - 1) * SCREEN_WIDTH) {
        [self guideStart];
        if (_currentGuideType == JCM_GuideTypeEuro) {
            self.euroTypeStartBlock();
        }
    }
}

@end
