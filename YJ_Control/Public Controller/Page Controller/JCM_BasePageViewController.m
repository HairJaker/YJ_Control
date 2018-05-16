//
//  JCM_BasePageViewController.m
//  竞彩猫
//
//  Created by yujie on 17/3/9.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "JCM_BasePageViewController.h"

@interface JCM_BasePageViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,UIScrollViewDelegate>

@property (nonatomic,strong) NSMutableArray * pageControllers;
@property (nonatomic, strong) UIPageViewController *pageController;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong) UIScrollView *scrollNavigationView;
@property (nonatomic, assign) NSInteger buttonPressed;

@property (nonatomic, strong) UIScrollView *pageScrollView;
@property (nonatomic, assign) NSInteger currentPageIndex;
@property (nonatomic, strong) NSArray *connectedButtons;

@end

@implementation JCM_BasePageViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [[JCM_BasePageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    if (self) {
        
        _pageControllers = [NSMutableArray new];
        _currentPageIndex = 0;
        
        _pageType = JCM_PageTypeButton;
        
    }

    return self;
}


-(void)reloadPagesData{

    if (self.pageDelegate && [self.pageDelegate respondsToSelector:@selector(currentSelectedIndex)]) {
        _currentPageIndex = [self.pageDelegate currentSelectedIndex];
    }
    
    [self reloadPagesToCurrentPageIndex:_currentPageIndex];
}

-(void)reloadPagesToCurrentPageIndex:(NSInteger)currentPageIndex{
    
    [self loadControllerAndView];
    
    [self loadControllers];
    
    [self connectButtons];
    
    if ([self.pageDataSource respondsToSelector:@selector(otherConfiguration)]) {
        [self.pageDataSource otherConfiguration];
    }

}

-(void)otherConfiguration{

    NSLog(@"otherConfiguration");

}

-(void)moveToViewNumber:(NSInteger)viewNumber{

    [self moveToViewNumber:viewNumber animated:YES];
    
}

-(void)moveToViewNumber:(NSInteger)viewNumber animated:(BOOL)animated{

    NSAssert([_pageControllers count] > viewNumber, @"viewNumber exceeds the number of current viewcontrollers");
    
    id viewController = _pageControllers[viewNumber];
    
    [self pageViewMoveToIndex:_currentPageIndex];
    
    __weak typeof (self)weakSelf = self;
    
    UIPageViewControllerNavigationDirection direction = UIPageViewControllerNavigationDirectionForward;
    
    if (_currentPageIndex > viewNumber) {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }
    
    [self setViewControllers:@[viewController] direction:direction animated:YES completion:^(BOOL finished) {
       
        if (!weakSelf) {
            return ;
        }
        
        __strong typeof (weakSelf)strongSelf = weakSelf;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [strongSelf updateCurrentPageIndex:viewNumber];
            [strongSelf setViewControllers:@[viewController] direction:direction animated:YES completion:nil];
            
        });
        
    }];

}

-(void)loadControllerAndView{

    NSAssert([[self pageDataSource] isKindOfClass:[UIViewController class]], @"必须在UIViewController中实现");
    [(JCM_BaseViewController *)[self pageDataSource] addChildViewController:self];
    
    [[[self pageDataSource] pageContainerView] addSubview:self.view];
}

-(void)loadControllers{

    [_pageControllers removeAllObjects];
    NSArray * controllers = [[self pageDataSource] pageControllers];
    NSAssert(controllers, @"子控制器数量不能为空");
    [_pageControllers addObjectsFromArray:controllers];
    [self setupPageViewController];
    
}

-(void)setupPageViewController{

    NSAssert(_pageControllers, @"添加的子视图最少为一个");
    
    _pageController = self;
    
    _pageController.dataSource = self;
    
    _pageController.delegate = self;
    
    [_pageController setViewControllers:@[[_pageControllers objectAtIndex:_currentPageIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];

    [self syncScrollView];
    
}

-(void)syncScrollView{

    for (UIView * view in _pageController.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            _pageScrollView = (UIScrollView *)view;
            _pageScrollView.delegate = self;
        }
    }

}


-(void)connectButtons{

    NSArray * buttons = [[self pageDataSource] pageButtons];
    
    NSAssert([buttons count] > 0, @"Buttons needs to be at least 1");
    
    if (_pageType == JCM_PageTypeSegment) {
        
        NSAssert([buttons count] == 1, @"Only one segment can be used");
        NSAssert([[buttons objectAtIndex:0] isKindOfClass:[UISegmentedControl class]], @"The Object needs to be or inherit from UISegmentedControl");
        
        UISegmentedControl * segmentControl = (UISegmentedControl *)[buttons objectAtIndex:0];
        
        NSAssert(segmentControl.numberOfSegments == [_pageControllers count], @"The number of segments needs to be the same as the number of controllers");
        
        [segmentControl addTarget:self
                              action:@selector(segmentControlMode:)
                    forControlEvents:UIControlEventValueChanged];
        
        _connectedButtons = @[segmentControl];
        
        return;
    }
    
    NSAssert(_pageControllers, @"addButtonsToSegmentPage Array need to be non empty");
    
    int i = 0;
    
    for (UIButton * button in buttons) {
        NSAssert([button isKindOfClass:[UIButton class]], @"Add buttons to MBXPageButtons Array need to contain only UIButton elements");
        
        button.tag =  i;
        
        switch (_pageType) {
            case JCM_PageTypeButton:
                [button addTarget:self action:@selector(freeButtonMode:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case JCM_PageTypeArrows:
                [button addTarget:self action:@selector(arrowsMode:) forControlEvents:UIControlEventTouchUpInside];
                break;
            default:
                break;
        }
        i ++;
    }
    
    _connectedButtons = buttons;
}

#pragma mark -
#pragma mark - Button and Controller Interactions
#pragma mark - Free Buttons Mode

-(void)freeButtonMode:(UIButton *)sender{

    NSInteger  destination = sender.tag;
    
    [self controllerModeLogicForDestionation:destination];

}

-(void)arrowsMode:(UIButton *)button{

    NSInteger  tempIndex = _currentPageIndex;
    
    __weak typeof (JCM_BasePageViewController *) weakSelf = self;
    
    if (button.tag == 1) {
        
        if (!(tempIndex + 1 < _pageControllers.count)) {
            return;
        }
        
        NSInteger newIndex = tempIndex + 1;
        
        [self setPageControllerForIndex:newIndex direction:UIPageViewControllerNavigationDirectionForward currentPageViewController:weakSelf];
        
    }else if (button.tag == 0){
    
    
        if (!(tempIndex > 0)) {
            return;
        }
        
        NSInteger newIndex = tempIndex - 1;
        
        [self setPageControllerForIndex:newIndex direction:UIPageViewControllerNavigationDirectionReverse currentPageViewController:weakSelf];
    
    }

}

#pragma mark - Controller Mode Common Logic -

-(void)controllerModeLogicForDestionation:(NSInteger)destination{

    __weak  __typeof(JCM_BasePageViewController *)weakSelf = self;

        [self setPageControllerForIndex:destination
                              direction:UIPageViewControllerNavigationDirectionForward currentPageViewController:weakSelf
                           destionation:destination];

}

-(void)setPageControllerForIndex:(NSInteger)index
                       direction:(UIPageViewControllerNavigationDirection)direction
       currentPageViewController:(id)weakSelf{

    [self setPageControllerForIndex:index direction:direction currentPageViewController:weakSelf destionation:0];
}

-(void)setPageControllerForIndex:(NSInteger)index
                       direction:(UIPageViewControllerNavigationDirection)direction
       currentPageViewController:(id)weakSelf
                    destionation:(NSInteger)destionation{
    
    __block NSInteger pageModeBlock = _pageType;
    
    [_pageController setViewControllers:@[[_pageControllers objectAtIndex:index]] direction:direction animated:YES completion:^(BOOL complete) {
       
        __strong __typeof(JCM_BasePageViewController *)strongSelf = weakSelf;
        
        if (complete && strongSelf) {
            if ((pageModeBlock == JCM_PageTypeSegment)&&index != destionation) {
                return ;
            }else{
                [strongSelf updateCurrentPageIndex:index];
            }
        }
        
    }];
    
}

-(void)updateCurrentPageIndex:(NSInteger)index{

    _currentPageIndex = index;
    
    [self pageViewMoveToIndex:index];

}
// ------  delegate  ---------
-(void)pageViewMoveToIndex:(NSInteger)index{
    
    for (int i = 0; i < _connectedButtons.count; i ++) {
        UIButton * button = [_connectedButtons objectAtIndex:i];
        if (i == index) {
            button.selected = YES;
        }else{
            button.selected = NO;
        }
    }

    if (self.pageDelegate && [self.pageDelegate respondsToSelector:@selector(pageViewMoveToIndex:)]) {
        [[self pageDelegate] pageViewMoveToIndex:index];
    }
    
    if (_pageType == JCM_PageTypeSegment) {
        [self updateSegmentControllerWithDestination:index];
    }
    
}

#pragma mark  --  segment Controller mode -- 

-(void)segmentControlMode:(UISegmentedControl *)segmentControl{

    NSInteger  destination = segmentControl.selectedSegmentIndex;
    
    [self controllerModeLogicForDestionation:destination];

}

-(void)updateSegmentControllerWithDestination:(NSInteger)destination{

    UISegmentedControl * segmentControl = (UISegmentedControl *)_connectedButtons[0];
    
    [segmentControl setSelectedSegmentIndex:destination];
    
}

#pragma mark  --  pageController delegate  --

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{

    NSInteger index = [self indexOfController:viewController];
    
    if (index == NSNotFound) {
        return nil;
    }
    
    if (index == 0) {
        return nil;
    }
    
    index --;
    
    return [_pageControllers objectAtIndex:index];

}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{

    NSInteger index = [self indexOfController:viewController];
    
    if (index == NSNotFound) {
        return nil;
    }
    index ++;
    
    if (index == _pageControllers.count) {
        return nil;
    }
    return [_pageControllers objectAtIndex:index];

}

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{

    if (completed) {
        _currentPageIndex = [self indexOfController:[pageViewController.viewControllers lastObject]];
        [self pageViewMoveToIndex:_currentPageIndex];
    }

}

-(void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers{

    _buttonPressed = -1;
    
}

-(NSInteger)indexOfController:(UIViewController *)viewController{

    for (int i = 0; i < _pageControllers.count; i ++) {
        if ([viewController isEqual:[_pageControllers objectAtIndex:i]]) {
            return i;
        }
    }

    return NSNotFound;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
