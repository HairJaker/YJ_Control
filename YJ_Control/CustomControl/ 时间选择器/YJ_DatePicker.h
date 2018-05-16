//
//  YJ_DatePicker.h
//  YJ_Control
//
//  Created by yujie on 2018/1/19.
//  Copyright © 2018年 yujie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YJ_DatePickerView;

typedef void(^DateTimeSelectedBlock)(NSDate * selctedDate);

@interface YJ_DatePicker : UIView

@property (nonatomic,strong) NSDate * maxSelectedDate;

@property (nonatomic,strong) NSDate * minSelectedDate;

@property (nonatomic,strong) NSDate * selectedDate;

@property (assign,nonatomic) BOOL isBeforeTimeCanSelected;

@property (nonatomic,assign) UIDatePickerMode datePickerMode;

-(void)disFinishSelectedDate:(DateTimeSelectedBlock)selectedBlock;

@end
