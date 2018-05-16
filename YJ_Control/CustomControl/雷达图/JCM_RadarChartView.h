//
//  JCM_RadarChartView.h
//  竞彩猫
//
//  Created by yujie on 17/2/10.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import <UIKit/UIKit.h>

// 总数于当前数结构体

struct JCM_RadarChartRankInfo {
    NSInteger  totalNumber;    // 总数
    NSInteger  currentNumber;  // 当前数
};

typedef struct JCM_RadarChartRankInfo JCM_RadarChartRankInfo;

// 构造函数

JCM_RadarChartRankInfo  JCM_RadarChartRankInfoMake(NSInteger totalNumber,NSInteger currentNumber);

@class JCM_RadarChartView;

//  数据源  必须实现
@protocol JCM_RadarChartDataSource <NSObject>

@required
//  数据组数
- (NSInteger)numberOfItemsInRadarChart:(JCM_RadarChartView *)radarChartView;
//  某一组最大数值
- (NSInteger)radarChart:(JCM_RadarChartView *)radarChartView maxCountAtIndex:(NSInteger)index;
//  某一组最大数值
- (NSInteger)radarChart:(JCM_RadarChartView *)radarChartView minCountAtIndex:(NSInteger)index;
//  某一组当前数值
- (NSInteger)radarChart:(JCM_RadarChartView *)radarChartView rankAtIndex:(NSInteger)index;
//  某一组数据标题
- (NSString *)radarChart:(JCM_RadarChartView *)radarChartView titleOfItemAtIndex:(NSInteger)index;

@end

// 代理方法(可选)

@protocol JCM_RadarChartDelegate <NSObject>
@optional

//  圈数
- (NSInteger)numberOfTracksInRadarChart:(JCM_RadarChartView *)radarChartView;

//  圈数填充颜色
-(NSArray *)tracksFillColorsInRadarChart:(JCM_RadarChartView *)radarChartView;

//  正多边形的某一个顶点

- (void)radarChart:(JCM_RadarChartView *)radarChartView didDisplayMaxPoint:(CGPoint)point atIndex:(NSInteger)index;

//  某一组的当前数值所在点

- (void)radarChart:(JCM_RadarChartView *)radarChartView didDisplayCurrentPoint:(CGPoint)point atIndex:(NSInteger)index;

// 某一组数据标题被选中
- (void)radarChart:(JCM_RadarChartView *)radarChartView didSelectedItemAtIndex:(NSInteger)index;

//  当前雷达显示区域颜色
-(UIColor *)radarChartCurrentFillColor:(JCM_RadarChartView *)radarChartView;

// 中心点
CGPoint center(CGFloat x,CGFloat y);

CGFloat half(CGFloat floatValue);

UIColor* colorRGB(CGFloat r, CGFloat g, CGFloat b);

@end

@interface JCM_RadarChartView : UIView

//数据源属性
@property (nonatomic, weak) id<JCM_RadarChartDataSource>dataSource;
//代理属性
@property (nonatomic, weak) id<JCM_RadarChartDelegate>delegate;

// 更新数据 刷新视图

-(void)reloadData;

//  取出对应序列号的item
- (UIButton *)radarItemAtIndex:(NSInteger)index;
//  取出对应序列号的百分比值
- (CGFloat)percentageAtIndex:(NSInteger)index;
//  获取对应序列号的 总数和当前数
- (JCM_RadarChartRankInfo)rankInfoAtIndex:(NSInteger)index;

@end
