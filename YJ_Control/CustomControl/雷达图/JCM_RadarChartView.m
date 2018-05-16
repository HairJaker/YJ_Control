//
//  JCM_RadarChartView.m
//  竞彩猫
//
//  Created by yujie on 17/2/10.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "JCM_RadarChartView.h"

static CGFloat  buttonWidth = 40;
static CGFloat  buttonHeight = 20;
static CGFloat  xOrigin = 10;


JCM_RadarChartRankInfo JCM_RadarChartRankInfoMake(NSInteger totalNumber,NSInteger currentNumber){
    
    JCM_RadarChartRankInfo info;
    info.currentNumber = currentNumber;
    info.totalNumber = totalNumber;
    return info;
}

CGPoint center(CGFloat x,CGFloat y){
    
    return CGPointMake(x, y);
    
}

int floatToInt(float f){
    int i = 0;
    if(f>0) //正数
        i = (f*10 + 5)/10;
    else if(f<0) //负数
        i = (f*10 - 5)/10;
    else i = 0;
    
    return i;
    
}

CGFloat half(CGFloat floatValue) {
    return floatValue * 0.5;
}

UIColor* colorRGB(CGFloat r, CGFloat g, CGFloat b) {
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
}

@interface JCM_RadarChartView (){
    
    NSInteger itemsNumber;
    NSMutableArray * arrayMaxCounts;
    NSMutableArray * arrayMinCounts;
    NSMutableArray * arrayRanks;
    CGContextRef contextRef;
    CGFloat  yMaxRadius;
    NSArray * tracksColors;
    NSInteger  tracksCount;
    CGFloat  xMaxRadius ;
    
    UIBezierPath * bezier ;
    
}
@end

@implementation JCM_RadarChartView

#pragma mark - struct
- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if ( self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}
- (void)initialize {
    self.backgroundColor = [UIColor clearColor];
    
}

#pragma mark  -- setter  --

-(void)setDataSource:(id<JCM_RadarChartDataSource>)dataSource
{
    _dataSource = dataSource;
    //    [self resetData];
}
-(void)setDelegate:(id<JCM_RadarChartDelegate>)delegate
{
    _delegate = delegate;
    
}

#pragma mark  --  drawMothod --

-(void)drawRect:(CGRect)rect
{
    if (itemsNumber != 0) {
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextClearRect(context, rect);
        
        yMaxRadius = (self.frame.size.height/2 - xOrigin);
        
        xMaxRadius = yMaxRadius * sin(2*M_PI/itemsNumber);
        
        [self setTracksNumberAndColor]; // 获取圈数和填充颜色
        
        CGFloat yMargin = yMaxRadius/tracksCount;
        
        for (int i = 0; i < tracksCount; i ++) {
            BOOL isMain = i == 0?true:false;
            UIColor * trackColor = tracksColors.count != 0?[tracksColors objectAtIndex:i]:[UIColor clearColor];
            [self drawPolygonWithRadius:yMaxRadius - yMargin * i  color:trackColor isMain:isMain];
        }
        
        
        [self drawRadarView];
        
    }
    
}

-(void)setTracksNumberAndColor
{
    //  圈数
    if ([_delegate respondsToSelector:@selector(numberOfTracksInRadarChart:)]) {
        tracksCount = [_delegate numberOfTracksInRadarChart:self];
    }
    
    //  圈数填充颜色
    
    if ([_delegate respondsToSelector:@selector(tracksFillColorsInRadarChart:)]) {
        tracksColors = [_delegate tracksFillColorsInRadarChart:self];
    }
}

#pragma mark  --  reset data  --

-(void)resetData{
    
    arrayMaxCounts = [NSMutableArray array];
    arrayMinCounts = [NSMutableArray array];
    arrayRanks     = [NSMutableArray array];
    tracksCount    = 1;
    itemsNumber    = 0;
    
    //  类别数量
    if ([_dataSource respondsToSelector:@selector(numberOfItemsInRadarChart:)] && _dataSource) {
        itemsNumber = [_dataSource numberOfItemsInRadarChart:self];
    }
    
    //  每个类别的当前值
    if (_dataSource && [_dataSource respondsToSelector:@selector(radarChart:rankAtIndex:)]) {
        for (NSInteger i = 0; i < itemsNumber; i++) {
            NSNumber *rank = @([_dataSource radarChart:self rankAtIndex:i]);
            if (rank.intValue >= (int)[_dataSource radarChart:self minCountAtIndex:i]) {
                [arrayRanks addObject:rank];
            }
        }
    }
    
    //  每个类别的最大值
    if (_dataSource && [_dataSource respondsToSelector:@selector(radarChart:maxCountAtIndex:)]) {
        
        for (NSInteger i = 0; i < itemsNumber; i ++) {
            NSNumber * maxCount = @([_dataSource radarChart:self maxCountAtIndex:i]);
            [arrayMaxCounts addObject:maxCount];
        }
        
    }
    // 每个类别的最小值
    if (_dataSource && [_dataSource respondsToSelector:@selector(radarChart:minCountAtIndex:)]) {
        for (int i = 0; i < itemsNumber; i ++) {
            NSNumber *minCount = @([_dataSource radarChart:self minCountAtIndex:i]);
            [arrayMinCounts addObject:minCount];
        }
    }
    
}

-(void)reloadData{
    
    [self resetData];
    [self setNeedsDisplay];
    
}

- (void)drawPolygonWithRadius:(CGFloat)radius color:(UIColor *)color isMain:(BOOL)isMain{
    
    NSMutableArray * topPoints = [NSMutableArray array];
    
    bezier = [UIBezierPath bezierPath];
    
    [self createTracksFillWithRadius:radius topPoints:topPoints isMain:isMain fillColor:color]; // 圈数填充
    
    NSMutableArray * itemCenters = [self createTracksStorekWithTopPoints:topPoints isMain:isMain]; // 圈边框
    
    [self createDiagonalLineWithTopPoints:topPoints isMain:isMain]; // 雷达图中心对角线
    
    [self createItemButtonWithItemCenters:itemCenters]; // 雷达图对应类别
    
}

-(void)createTracksFillWithRadius:(CGFloat)radius topPoints:(NSMutableArray *)topPoints isMain:(BOOL)isMain fillColor:(UIColor *)color{
    
    CGFloat x = self.frame.size.width/2,y = self.frame.size.height/2;
    
    [bezier moveToPoint:CGPointMake(x, y - radius)];
    
    // 填充
    for (int i = 1; i <= itemsNumber; i ++) {
        
        CGPoint  point =  CGPointMake(x + radius * sin(2 * M_PI * i / itemsNumber) , y - radius * cos(2 * M_PI * i / itemsNumber));
        [topPoints addObject:[NSValue valueWithCGPoint:point]];
        
        if (isMain) {
            if ([self.delegate respondsToSelector:@selector(radarChart:didDisplayMaxPoint:atIndex:)]) {
                [self.delegate radarChart:self didDisplayMaxPoint:point atIndex:i - 1];
            }
        }
        
        [bezier addLineToPoint:point];
        
        CAShapeLayer * shapeLayer = [self createShapeLayerWithBezierPath:bezier];
        shapeLayer.fillColor = color.CGColor;
        
        [self.layer addSublayer:shapeLayer];
        
    }
    
    [bezier closePath];
    
}

-(NSMutableArray * )createTracksStorekWithTopPoints:(NSMutableArray *)topPoints isMain:(BOOL)isMain {
    
    CGFloat x = self.frame.size.width/2,y = self.frame.size.height/2;
    
    NSMutableArray  * itemCenters = [NSMutableArray array];
    
    if (isMain) {
        
        for (int i = 0; i < topPoints.count; i ++) {
            
            NSValue *valuePoint = topPoints[i];
            CGPoint point = valuePoint.CGPointValue;
            
            int xValue = floatToInt(point.x), yValue = floatToInt(point.y);
            x = floatToInt(x);
            y = floatToInt(y);
            point = CGPointMake(xValue, yValue);
            
            [bezier moveToPoint:CGPointMake(x, y)];
            
            CGPoint itemCenter;
            if (isMain) {
                
                if (point.x == x && point.y == y - yMaxRadius) {//正上方
                    itemCenter = CGPointMake(point.x , point.y - half(buttonHeight));
                }else if (point.x == x && point.y == y + yMaxRadius) {//正下方
                    itemCenter = CGPointMake(point.x , point.y + half(buttonHeight));
                }else if (point.y == y && point.x == x - yMaxRadius) {//正左方
                    itemCenter = CGPointMake(point.x - buttonWidth + xOrigin * 2, point.y);
                }else if (point.y == y && point.x == x + yMaxRadius) {//正右方
                    itemCenter = CGPointMake(point.x + buttonWidth - xOrigin * 2, point.y);
                }else if (point.x < x && point.x > x - yMaxRadius && point.y < y && point.y > y - yMaxRadius) {//左上
                    itemCenter = CGPointMake(point.x - buttonWidth + xOrigin * 2, point.y);
                }else if (point.x > x && point.x < x + yMaxRadius && point.y < y && point.y > y - yMaxRadius) {//右上
                    itemCenter = CGPointMake(point.x + buttonWidth - xOrigin * 2, point.y);
                }else if (point.x < x && point.x > x - yMaxRadius && point.y > y && point.y < y + yMaxRadius) {//左下
                    itemCenter = CGPointMake(point.x - buttonWidth + xOrigin * 2 , point.y );
                }else{//右下
                    itemCenter = CGPointMake(point.x + buttonWidth - xOrigin * 2, point.y);
                }
                
                [itemCenters addObject:[NSValue valueWithCGPoint:itemCenter]];
            }
            
            [bezier addLineToPoint:CGPointMake(point.x, point.y)];
            
            CAShapeLayer * shapeLayer = [self createShapeLayerWithBezierPath:bezier];
            shapeLayer.fillColor = nil;
            shapeLayer.strokeColor = [UIColor grayColor].CGColor;
            [self.layer addSublayer:shapeLayer];
            
        }
        [bezier closePath];
    }
    
    return  itemCenters;
    
}

-(void)createDiagonalLineWithTopPoints:(NSMutableArray *)topPoints isMain:(BOOL)isMain{
    
    NSValue *firstPointValue = [topPoints lastObject];
    CGPoint firstPoint = firstPointValue.CGPointValue;
    
    [bezier moveToPoint:firstPoint];
    
    for (int i = 0; i < topPoints.count; i ++) {
        
        NSValue *valuePoint = topPoints[i];
        CGPoint point = valuePoint.CGPointValue;
        
        [bezier addLineToPoint:point];
        
        CAShapeLayer * shapeLayer = [self createShapeLayerWithBezierPath:bezier];
        shapeLayer.fillColor = nil;
        shapeLayer.strokeColor = [UIColor grayColor].CGColor;
        [self.layer addSublayer:shapeLayer];
        
    }
    
    [bezier closePath];
    
}

-(void)createItemButtonWithItemCenters:(NSMutableArray *)itemCenters {
    
    //    for (NSInteger i = 0; i < itemCenters.count; i++) {
    //        UIButton *itemButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, buttonHeight)];
    //        itemButton.tag = 200 + i;
    //        NSValue *pValue = itemCenters[i];
    //        CGPoint itemButtonCenter = pValue.CGPointValue;
    //        itemButton.center = itemButtonCenter;
    //        [itemButton setBackgroundColor:[UIColor redColor]];
    //        [itemButton setTitleColor:[UIColor colorWithHexString:@"#343434" withAlpha:1.0f] forState:UIControlStateNormal];
    //        if ([_dataSource respondsToSelector:@selector(radarChart:titleOfItemAtIndex:)]) {
    //            [itemButton setTitle:[_dataSource radarChart:self titleOfItemAtIndex:i] forState:UIControlStateNormal];
    //        }
    //        [itemButton.titleLabel setFont:[UIFont systemFontOfSize:34 * scaleElement]];
    //        if (i < 2) {
    //            itemButton.titleLabel.textAlignment = NSTextAlignmentRight;
    //        }else if(i > 2 && i < 5){
    //            itemButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    //        }
    //        [self addSubview:itemButton];
    //        [itemButton addTarget:self action:@selector(itemButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    //    }
    
    for (NSInteger i = 0; i < itemCenters.count; i++) {
        UILabel *itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, buttonHeight)];
        itemLabel.tag = 200 + i;
        NSValue *pValue = itemCenters[i];
        CGPoint itemButtonCenter = pValue.CGPointValue;
        itemLabel.center = itemButtonCenter;
        [itemLabel setBackgroundColor:[UIColor clearColor]];
        [itemLabel setTextColor:[UIColor colorWithHexString:@"#343434" withAlpha:1.0f]];
        if ([_dataSource respondsToSelector:@selector(radarChart:titleOfItemAtIndex:)]) {
            [itemLabel setText:[_dataSource radarChart:self titleOfItemAtIndex:i]];
        }
        [itemLabel setFont:[UIFont systemFontOfSize:34 * SCALE_ELEMENT]];
        if (i < 2) {
            itemLabel.textAlignment = NSTextAlignmentLeft;
        }else if(i > 2 && i < 5){
            itemLabel.textAlignment = NSTextAlignmentRight;
        }else{
            itemLabel.textAlignment = NSTextAlignmentCenter;
        }
        [self addSubview:itemLabel];
        //        [itemButton addTarget:self action:@selector(itemButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (void)itemButtonClick:(UIButton *)btn {
    if ([_delegate respondsToSelector:@selector(radarChart:didSelectedItemAtIndex:)]) {
        [_delegate radarChart:self didSelectedItemAtIndex:btn.tag - 200];
    }
}

- (void)drawRadarView{
    
    CGFloat x = half(self.frame.size.width), y = half(self.frame.size.height);
    
    NSMutableArray * lengths = [NSMutableArray array];
    
    if (arrayRanks.count == 0) {
        return;
    }
    
    for (NSInteger i = 1; i <= itemsNumber; i++) {
        
        NSInteger rankNumer = ((NSNumber *)arrayRanks[i - 1]).integerValue - ((NSNumber *)arrayMinCounts[i - 1]).integerValue;
        NSInteger rankDiff = ((NSNumber *)arrayMaxCounts[i - 1]).integerValue - ((NSNumber *)arrayMinCounts[i - 1]).integerValue;
        
        CGFloat  radius = yMaxRadius * rankNumer/rankDiff;
        if (radius >= 0) {
            [lengths addObject:@(radius)];
        }
        
        //计算当前点的位置
        CGPoint point = CGPointMake(x + radius * sin( 2 * M_PI * i / itemsNumber), y - radius * cos(2 * M_PI * i / itemsNumber));
        
        if ([self.delegate respondsToSelector:@selector(radarChart:didDisplayCurrentPoint:atIndex:)]) {
            [self.delegate radarChart:self didDisplayCurrentPoint:point atIndex:i - 1];
        }
        
    }
    
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor clearColor].CGColor;
    UIColor * fillColor = [UIColor  colorWithHexString:@"0xfa8642" withAlpha:0.5];
    if (self.delegate && [self.delegate respondsToSelector:@selector(radarChartCurrentFillColor:)]) {
        fillColor = [self.delegate radarChartCurrentFillColor:self];
    }
    shapeLayer.lineWidth = 1.5;
    shapeLayer.fillColor = fillColor.CGColor;
    shapeLayer.strokeColor = fillColor.CGColor;
    
    NSArray *lengthsArray = lengths;
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.fromValue = (id)[self drawPentagonWithCenter:CGPointMake(x, y) Length:0];
    pathAnimation.duration = 0.75;
    pathAnimation.autoreverses = NO;
    pathAnimation.repeatCount = 0;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [shapeLayer addAnimation:pathAnimation forKey:@"scale"];
    shapeLayer.path = [self drawPentagonWithCenter:CGPointMake(x, y) LengthArray:lengthsArray];
    [self.layer addSublayer:shapeLayer];
    
}

- (UIButton *)radarItemAtIndex:(NSInteger)index {
    UIButton *button = (UIButton *)[self viewWithTag:200 + index];
    return button;
}
- (CGFloat)percentageAtIndex:(NSInteger)index {
    NSNumber *max = arrayMaxCounts[index];
    NSNumber *cur = arrayRanks[index];
    CGFloat maxF = max.floatValue, curF = cur.floatValue;
    CGFloat percentage = curF / maxF * 100;
    return percentage;
}
- (JCM_RadarChartRankInfo)rankInfoAtIndex:(NSInteger)index {
    NSInteger total = ((NSNumber *)arrayMaxCounts[index]).integerValue;
    NSInteger current = ((NSNumber *)arrayRanks[index]).integerValue;
    return JCM_RadarChartRankInfoMake(total, current);
}


-(CAShapeLayer *)createShapeLayerWithBezierPath:(UIBezierPath *)bezierPath{
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 0.2;
    shapeLayer.path = bezierPath.CGPath;
    
    CABasicAnimation *anmi = [CABasicAnimation animation];
    anmi.keyPath = @"strokeEnd";
    anmi.fromValue = [NSNumber numberWithFloat:0];
    anmi.toValue = [NSNumber numberWithFloat:1.0f];
    anmi.duration = 2;
    anmi.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anmi.autoreverses = NO;
    
    [shapeLayer addAnimation:anmi forKey:@"strokeEnd"];
    
    return shapeLayer;
}

#pragma mark  --  beizer path  --

-(CGPathRef)drawPentagonWithCenter:(CGPoint)center LengthArray:(NSArray *)lengths{
    
    NSArray *coordinates = [self converCoordinateFromLength:lengths Center:center];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    for (int i = 0; i < [coordinates count]; i++) {
        CGPoint point = [[coordinates objectAtIndex:i] CGPointValue];
        if (i == 0) {
            [bezierPath moveToPoint:point];
        } else {
            [bezierPath addLineToPoint:point];
        }
    }
    [bezierPath closePath];
    
    return bezierPath.CGPath;
    
}

-(CGPathRef)drawPentagonWithCenter:(CGPoint)center Length:(double)length{
    
    NSMutableArray * lengths = [NSMutableArray array];
    
    for (int i = 0; i < itemsNumber; i ++) {
        [lengths addObject:@(length)];
    }
    
    return [self drawPentagonWithCenter:center LengthArray:lengths];
    
}

-(NSArray *)converCoordinateFromLength:(NSArray *)lengthArray Center:(CGPoint)center{
    
    NSMutableArray *coordinateArray = [NSMutableArray array];
    for (NSInteger i = 1; i <= lengthArray.count; i++) {
        CGFloat radius = [lengthArray[i - 1] floatValue];
        //计算当前点的位置
        CGPoint point = CGPointMake(center.x + radius * sin( 2 * M_PI * i / lengthArray.count), center.y - radius * cos(2 * M_PI * i / lengthArray.count));
        
        [coordinateArray addObject:[NSValue valueWithCGPoint:point]];
    }
    
    return coordinateArray;
    
}

@end
