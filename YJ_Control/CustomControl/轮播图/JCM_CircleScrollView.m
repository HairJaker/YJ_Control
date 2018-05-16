//
//  JCM_CircleScrollView.m
//  竞彩猫
//
//  Created by yujie on 17/1/10.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "JCM_CircleScrollView.h"

static  NSInteger  circleImageViewCount = 3;

@interface JCM_CircleScrollView()<UIScrollViewDelegate,UIPageViewControllerDelegate>
{
    
    NSInteger _currentImageIndex;
    
    int selfWidth;
    int selfHeight;
    
}
@property (nonatomic,strong)  NSMutableArray * imageViews;
@property (nonatomic,strong)  UIPageControl  * pageControl;
@property (nonatomic,strong)  UIScrollView   * scrollView;

@property (nonatomic,strong)  JCM_CircleListModel   * circleListModel;

@property (nonatomic,strong)  NSTimer * timer;

@end

@implementation JCM_CircleScrollView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _imageViews = [NSMutableArray array];
        selfWidth = frame.size.width;
        selfHeight = frame.size.height;
        
    }
    return self;
}

-(void)addTimerAfterDelay
{
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(addTimerAfterDelay) object:nil];
    
    [self addTimer]; // 添加定时器
}

#pragma mark --  init property  ------

-(void)initProperty
{
    CGRect scrollViewRect = CGRectMake(0, 0, selfWidth, selfHeight);
    
    [_scrollView removeFromSuperview];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:scrollViewRect];
    [self addSubview:_scrollView];
    
//    if (!self.circleListModel || self.circleListModel.data.count == 0) {
//        return;
//    }
//
//    if (self.circleListModel && self.circleListModel.data.count > 3) {
//        circleImageViewCount = 3;
//    }
    
    _scrollView.scrollEnabled = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(selfWidth * circleImageViewCount, selfHeight);
    [_scrollView setContentOffset:CGPointMake(selfWidth, 0)]; //  设置当前显示位置为中间
    
    //去掉滚动条
    _scrollView.showsHorizontalScrollIndicator=NO;
    
}

#pragma mark 添加图片三个控件
-(void)addImageViews{
    
    for (int i = 0; i < circleImageViewCount; i ++) {
        CGRect imageViewRect = CGRectMake(selfWidth * i, 0, selfWidth, selfHeight);
        UIImageView * iv = [[UIImageView alloc]initWithFrame:imageViewRect];
        iv.contentMode = UIViewContentModeScaleToFill;
        iv.userInteractionEnabled = YES;
        iv.backgroundColor = [UIColor colorWithHexString:@"#bdbdbd" withAlpha:1.0f];
        [_imageViews addObject:iv];
        [_scrollView addSubview:iv];
        
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ivTapAction:)];
        [iv addGestureRecognizer:tapGesture];
    }
}

-(void)ivTapAction:(UITapGestureRecognizer *)tap{
    
//    if (self.circleListModel.data.count != 0) {
//
//        JCM_CircleModel * model = [self.circleListModel.data objectAtIndex:_currentImageIndex];
//
//        self.imgTapBlock(model);
//    }
}

-(void)reloadCircleView{
    
    [_imageViews removeAllObjects];
    [_scrollView removeFromSuperview];
    
//    if (self.circleDataSource && [self.circleDataSource circleDataModel]) {
//        _circleListModel = [self.circleDataSource circleDataModel];
//    }
//
//    if (self.circleListModel.data.count == 0) {
//        return;
//    }
    
    [self initProperty];
    
    //添加图片控件
    [self addImageViews];
    
    //加载默认图片
    [self setDefaultImage];
}

#pragma mark 设置默认显示图片
-(void)setDefaultImage{
    
//    if (!self.circleListModel || self.circleListModel.data.count == 0) {
//        return;
//    }
//
//    if (self.timer ) {
//        [self.timer invalidate];
//    }
//
//    if (self.circleListModel.data.count != 0) {
//        if ([[NSUserDefaults standardUserDefaults] valueForKey:@"currentVersion"] == nil) {
//
//            [self performSelector:@selector(addTimerAfterDelay) withObject:nil afterDelay:3];
//
//        }else [self addTimer];
//    }
    
//    //添加分页控件
//    [self addPageControl];
//
//    //加载默认图片
//    for (int i = 0; i < _imageViews.count; i++) {
//
//        UIImageView * iv = [_imageViews objectAtIndex:i];
//
//        JCM_CircleModel *model;
//
//        if (self.circleListModel.data.count > 1) {
//            model = i == 0?[self.circleListModel.data lastObject]:i == 1?[self.circleListModel.data firstObject]:[self.circleListModel.data objectAtIndex:1];
//        }else{
//            model = [self.circleListModel.data firstObject];
//        }
//
//        NSURL * imageUrl = [NSURL URLWithString:model.url_img];
//
//        [iv sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"轮播默认图"]];
//
//    }
//    _currentImageIndex=0;
//    //设置当前页
//    _pageControl.currentPage=_currentImageIndex;
}

/**
 *  压缩图片
 *  image:将要压缩的图片   size：压缩后的尺寸
 */
-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(size, NO, SCALE_ELEMENT);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

#pragma mark 添加分页控件
-(void)addPageControl{
    
    _pageControl=[[UIPageControl alloc]init];
    
//    //注意此方法可以根据页数返回UIPageControl合适的大小
//    CGSize size= [_pageControl sizeForNumberOfPages:self.circleListModel.data.count];
//    _pageControl.bounds=CGRectMake(0, 0, size.width, size.height);
//    _pageControl.center=CGPointMake(selfWidth/2,selfHeight - size.height/3);
    //设置颜色
    _pageControl.pageIndicatorTintColor=[UIColor colorWithRed:193/255.0 green:219/255.0 blue:249/255.0 alpha:1];
    //设置当前页颜色
    _pageControl.currentPageIndicatorTintColor=[UIColor colorWithRed:0 green:150/255.0 blue:1 alpha:1];
    //设置总页数
//    _pageControl.numberOfPages= self.circleListModel.data.count;
    
    [self addSubview:_pageControl];
}

#pragma mark - delegate -

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger leftImageIndex = 0, rightImageIndex = 0,imageCounts = 0;
    
//    imageCounts = self.circleListModel.data.count;
    
    if (imageCounts == 0) {
        return;
    }
    
    CGPoint  current = [_scrollView contentOffset];
    
    if (current.x > selfWidth) {
        _currentImageIndex = (_currentImageIndex + 1) % imageCounts;
    }else{
        
        _currentImageIndex = (_currentImageIndex + imageCounts - 1)%imageCounts;
    }
    
    _pageControl.currentPage = _currentImageIndex;
    
    leftImageIndex = (_currentImageIndex + imageCounts - 1)%imageCounts;
    rightImageIndex = (_currentImageIndex + 1) % imageCounts;
    
    NSArray * indexs = @[@(leftImageIndex),@(_currentImageIndex),@(rightImageIndex)];
    
//    for (int i = 0; i < _imageViews.count; i++) {
//        UIImageView * iv = [_imageViews objectAtIndex:i];
//        JCM_CircleModel * circleModel = [self.circleListModel.data objectAtIndex:[[indexs objectAtIndex:i] intValue]];
//        [iv sd_setImageWithURL:[NSURL URLWithString:circleModel.url_img] placeholderImage:[UIImage imageNamed:@"轮播默认图"]];
//
//    }
    
    [_scrollView setContentOffset:CGPointMake(selfWidth, 0)];
    
}

//  开始拖拽 关闭定时器
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self closeTimer];
}

//  结束拖拽 添加定时器
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    if (self.circleListModel.data.count != 0) {
//        [self addTimer];
//    }
}

#pragma mark - timer方法
//  添加定时器
-(void)addTimer
{
    
    if (self.timer) {
        [self.timer invalidate];
    }
    
    self.timer =  [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(showNextImage) userInfo:nil repeats:YES];
    //多线程 UI IOS程序默认只有一个主线程，处理UI的只有主线程。如果拖动第二个UI，则第一个UI事件则会失效。
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

// 关闭定时器
-(void)closeTimer
{
    [self.timer invalidate];
    self.timer = nil;
    
}

#pragma mark -  自动轮播图片调用方法 --

-(void)showNextImage
{
    NSInteger leftImageIndex = 0, rightImageIndex = 0, imageCounts = _imageViews.count;
    
//    if (self.circleListModel.data.count != 0) {
//        imageCounts = self.circleListModel.data.count;
//    }
//
//    if (imageCounts == 0 || self.circleListModel.data.count == 0) {
//        return;
//    }
    
    [_pageControl setCurrentPage:(_currentImageIndex + 1) % imageCounts];
    
    leftImageIndex = (_pageControl.currentPage + imageCounts - 1)%imageCounts;
    rightImageIndex = (_pageControl.currentPage + 1) % imageCounts;
    
    NSArray * indexs = @[@(leftImageIndex),@(_pageControl.currentPage),@(rightImageIndex)];
    
//    for (int i = 0; i < indexs.count; i++) {
//        UIImageView * iv = [_imageViews objectAtIndex:i];
//        JCM_CircleModel * circleModel = [self.circleListModel.data objectAtIndex:[[indexs objectAtIndex:i] intValue]];
//        [iv sd_setImageWithURL:[NSURL URLWithString:circleModel.url_img] placeholderImage:[UIImage imageNamed:@"轮播默认图"]];
//    }
    
    _currentImageIndex = _pageControl.currentPage;
    
    [_scrollView setContentOffset:CGPointMake(selfWidth, 0)];
}

@end
