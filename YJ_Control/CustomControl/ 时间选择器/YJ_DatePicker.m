//
//  YJ_DatePicker.m
//  YJ_Control
//
//  Created by yujie on 2018/1/19.
//  Copyright © 2018年 yujie. All rights reserved.
//

#import "YJ_DatePicker.h"

#import "YJ_DatePickerView.h"

#define kPickerViewHeight (SCREEN_WIDTH*0.35>230?230:(SCREEN_WIDTH*0.35<200?200:SCREEN_WIDTH*0.35))

@interface YJ_DatePicker()

@property (nonatomic,strong) UIButton * bgButton;
@property (nonatomic,strong) YJ_DatePickerView * datePickerView;
@property (nonatomic,copy) DateTimeSelectedBlock selectedBlock;

@end

@implementation YJ_DatePicker

-(instancetype)init{
    
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        
        [[UIApplication sharedApplication].keyWindow addSubview:self];

        [self addSubview:self.bgButton];  // 透明背景
        
        [self addSubview:self.datePickerView];
        
        [self pushDatePicker];
        
        
    }
    return  self;
}


/**
 透明背景

 @return 透明背景
 */
-(UIButton *)bgButton{
    if (!_bgButton) {
        _bgButton = [[UIButton alloc]initWithFrame:self.bounds];
        [_bgButton addTarget:self action:@selector(dismissDatePicker) forControlEvents:UIControlEventTouchUpInside];
        _bgButton.backgroundColor = [UIColor blackColor];
        _bgButton.alpha = 1;
    }
    return _bgButton;
}


/**
 property datePickerView

 @return datePickerView
 */
-(YJ_DatePickerView *)datePickerView{
    
    if (!_datePickerView) {
        // 时间选择器
        _datePickerView = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([YJ_DatePickerView class]) owner:self options:nil].lastObject;
        _datePickerView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, kPickerViewHeight);
        [_datePickerView.cancleButton addTarget:self action:@selector(dismissDatePicker) forControlEvents:UIControlEventTouchUpInside];
        [_datePickerView.confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_datePickerView.datePicer addTarget:self action:@selector(datePickerValueChange:) forControlEvents:UIControlEventValueChanged];
        
        _selectedDate = [NSDate new];
        _datePickerView.datePicer.date = _selectedDate;
        _datePickerView.datePicer.minimumDate = _selectedDate;
        _datePickerView.datePicer.datePickerMode = UIDatePickerModeDateAndTime;
    }
    
    return _datePickerView;
    
}

-(void)setSelectedDate:(NSDate *)selectedDate{
    
    _selectedDate = selectedDate;
    if (selectedDate) {
        _datePickerView.datePicer.date = selectedDate;
    }
}

-(void)setDatePickerMode:(UIDatePickerMode)datePickerMode{
    
    _datePickerMode = datePickerMode;
    if (_datePickerMode) {
        _datePickerView.datePicer.datePickerMode = _datePickerMode;
    }
    
}

-(void)setIsBeforeTimeCanSelected:(BOOL)isBeforeTimeCanSelected{
    
    if (isBeforeTimeCanSelected) {
        [_datePickerView.datePicer setMinimumDate:[NSDate dateWithTimeIntervalSince1970:0]];
    }else{
        [_datePickerView.datePicer setMinimumDate:[NSDate date]];
    }
    
}

-(void)setMinSelectedDate:(NSDate *)minSelectedDate{
    
    if (minSelectedDate) {
        _datePickerView.datePicer.minimumDate = minSelectedDate;
    }
    
}


#pragma mark  -- pushDatePicker  --

-(void)pushDatePicker{
    
    __weak  typeof (self)weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        
        __weak typeof (weakSelf)strongSelf = weakSelf;
       
        strongSelf.datePickerView.frame = CGRectMake(0, SCREEN_HEIGHT - kPickerViewHeight, SCREEN_WIDTH, kPickerViewHeight);
        strongSelf.bgButton.alpha = 0.2;
        
    }];
    
}

#pragma mark  -- datePicker valueChange  --

-(void)datePickerValueChange:(id)sender{
    
    _selectedDate = [sender date];
    
}

#pragma mark  -- confirm action  --

-(void)confirmButtonAction:(id)sender{
    
    if (_selectedBlock) {
        _selectedBlock(_selectedDate);
    }
    [self dismissDatePicker];
}

#pragma mark  -- finish selected  --

-(void)disFinishSelectedDate:(DateTimeSelectedBlock)selectedBlock{
    
    _selectedBlock = selectedBlock;
}

#pragma mark  -- dismiss picker  --

-(void)dismissDatePicker{
    
    __weak typeof (self)weakSelf = self;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        weakSelf.datePickerView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, kPickerViewHeight);
        weakSelf.bgButton.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        
        [weakSelf.datePickerView removeFromSuperview];
        [weakSelf.bgButton removeFromSuperview];
        [weakSelf removeFromSuperview];
        
    }];
    
}

@end
