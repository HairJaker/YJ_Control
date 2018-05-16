//
//  YJ_DatePickerVc.m
//  YJ_Control
//
//  Created by yujie on 2018/1/19.
//  Copyright © 2018年 yujie. All rights reserved.
//

#import "YJ_DatePickerVc.h"
#import "YJ_DatePicker.h"

@interface YJ_DatePickerVc ()

@property (nonatomic,strong) YJ_DatePicker * timePicker;
@property (nonatomic,strong) YJ_DatePicker * datePicker;

@end

@implementation YJ_DatePickerVc

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray * buttonTitles = @[@"时间选择",@"日期选择"];
    
    for (int i = 0; i < buttonTitles.count; i ++) {
        CGRect frame = CGRectMake(SCALE(120), SCALE(600) + SCALE(240) * i,SCREEN_WIDTH - SCALE(240) , SCALE(120));
        UIButton * button = [UIButton createButtonWithFrame:frame
                                                      title:[buttonTitles objectAtIndex:i]
                                                   fontSize:SCALE(36)
                                                   fontName:nil
                                                  backColor:[UIColor lightGrayColor]
                                                 titleColor:[UIColor redColor]
                                                 showBorder:NO
                                                borderColor:nil
                                                normalImage:nil
                                               cornerRadius:0
                                              selectedImage:nil];
        button.tag = 0;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
}

#pragma mark  -- button action  --

-(void)buttonAction:(UIButton *)sender{
    
    NSLog(@"%d",sender.tag);
    
    switch (sender.tag) {
        case 0:
            {
                _timePicker = [[YJ_DatePicker alloc]init];
                [_timePicker disFinishSelectedDate:^(NSDate *selctedDate) {
                   
                    NSString * dateStr = [ self dateStringWithDate:selctedDate dateFormat:@"MM月dd日 HH:mm"];
                    
                    NSLog(@"time  ==  %@",dateStr);
                    
                }];
            }
            break;
            
        default:
            break;  
    }
    
}

-(NSString *)dateStringWithDate:(NSDate *)date dateFormat:(NSString *)dateFormat{
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:dateFormat];
    NSLocale * locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setLocale:locale];
    NSString * dateStr = [dateFormatter stringFromDate:date];
    
    return dateStr;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
