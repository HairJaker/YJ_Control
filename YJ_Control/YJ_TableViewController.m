//
//  YJ_TableViewController.m
//  YJ_Control
//
//  Created by yujie on 2018/1/17.
//  Copyright © 2018年 yujie. All rights reserved.
//

#import "YJ_TableViewController.h"

#import "YJ_DatePickerVc.h"

static  NSString * controlCell = @"controlCell";

@interface YJ_TableViewController ()

@property (nonatomic,strong) NSArray * controlNameDatas;

@end

@implementation YJ_TableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    _controlNameDatas = @[@"UILable",
                          @"UIButton",
                          @"UITextFiled",
                          @"UITextView",
                          @"UIImageView",
                          @"UIAlertView",
                          @"UIScrollView",
                          @"UIActivityIndicatorView",
                          @"YJ_GuideView",
                          @"YJ_MenuView",
                          @"YJ_ShakerView",
                          @"YJ_RadarChartView",
                          @"YJ_SearchBar",
                          @"YJ_FireworksButton",
                          @"YJ_PathButton",
                          @"YJ_DatePickerView"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _controlNameDatas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:controlCell forIndexPath:indexPath];
 
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:controlCell];
    }
    
    cell.textLabel.text = [_controlNameDatas objectAtIndex:indexPath.row];
 
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == _controlNameDatas.count - 1) {
        YJ_DatePickerVc * datePickerVc = [[YJ_DatePickerVc alloc]init];
        [self.navigationController pushViewController:datePickerVc animated:YES];
    }
}

@end
