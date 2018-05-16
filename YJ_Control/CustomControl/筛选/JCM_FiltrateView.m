//
//  JCM_FiltrateView.m
//  竞彩猫
//
//  Created by yujie on 2017/5/26.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "JCM_FiltrateView.h"

@interface JCM_FiltrateView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView * alphaBackView;

@end

@implementation JCM_FiltrateView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = RGBA(241, 242, 243, 1.0f);
        
        _filtrateSclassData = [[NSMutableArray alloc]init];
        _normalChooseData = [[NSMutableArray alloc]init];
        
        [self headView];
        
        [self allChooseButton];
        
        [self affirmButton];
    }
    
    return self;
    
}

-(UIView *)headView{
    
    if (!_headView) {
        
        CGRect headViewRect =  CGRectMake(0, 0, self.bounds.size.width, NAVI_HEGIHT);
        
        _headView = [[UIView alloc]initWithFrame:headViewRect];
        _headView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_headView];
        
    }
    
    return _headView;
    
}

-(UILabel *)titleLabel
{
    CGRect titleLabelRect = CGRectMake(0, 0, 500 * SCALE_ELEMENT, 70 * SCALE_ELEMENT);
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:titleLabelRect];
        _titleLabel.center = CGPointMake(CGRectGetMidX(self.bounds), NAVI_HEGIHT - CENTER_ORIGIN_Y);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithHexString:@"#3D3D3D" withAlpha:1.0f];
        _titleLabel.font = [UIFont systemFontOfSize:50 * SCALE_ELEMENT];
        [_headView addSubview:_titleLabel];
    }
    
    return _titleLabel;
    
}

-(UIButton *)backButton
{
    CGRect frame = CGRectMake(0, 0, 140 * SCALE_ELEMENT, 140 * SCALE_ELEMENT);
    
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = frame;
        [_backButton setTitle:nil forState:UIControlStateNormal];
        _backButton.center = CGPointMake(CENTER_ORIGIN_Y, NAVI_HEGIHT - CENTER_ORIGIN_Y);
        [_backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _backButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [_backButton addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
        [_headView addSubview:_backButton];
    }
    
    return _backButton;
    
}
// 全选
-(UIButton *)allChooseButton
{
    CGRect frame = CGRectMake(0, self.bounds.size.height - TABBAR_HEIGHT, 508 * SCALE_ELEMENT, TABBAR_HEIGHT - BOTTOM_SAFE_HEIGHT);
    
    if (!_allChooseButton) {
        _allChooseButton = [UIButton createButtonWithFrame:frame
                                                     title:@"全选"
                                                  fontSize:44 * SCALE_ELEMENT
                                                  fontName:nil
                                                 backColor:[UIColor whiteColor]
                                                titleColor:[UIColor colorWithHexString:@"#3D3D3D" withAlpha:1.0f] showBorder:NO borderColor:nil normalImage:[UIImage imageNamed:@"筛选未选中"] cornerRadius:0 selectedImage:[UIImage imageNamed:@"筛选选中"]];
        _allChooseButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 52 * SCALE_ELEMENT);
        _allChooseButton.selected = YES;
        _allChooseButton.userInteractionEnabled = YES;
        [_allChooseButton addTarget:self action:@selector(allChooseAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_allChooseButton];
    }
    
    return _allChooseButton;
    
}

-(void)allChooseAction:(UIButton *)sender{
    
    if (_normalChooseData.count == 0) {
        for (NSMutableDictionary * dic  in _filtrateSclassData) {
            NSMutableDictionary * item = [dic mutableCopy];
            [_normalChooseData addObject:item];
        }
    }
    
    _allChooseButton.selected = !_allChooseButton.selected;
    
    NSInteger isSelected = _allChooseButton.selected?1:0;
    
    for (NSMutableDictionary * dic  in _normalChooseData) {
        [dic setValue:@(isSelected) forKey:@"isSelected"];
    }
    
    [_filtrateTableView reloadData];
    
}

-(UIButton *)affirmButton
{
    CGRect frame = CGRectMake(self.bounds.size.width - 304 * SCALE_ELEMENT, self.bounds.size.height - TABBAR_HEIGHT, 304 * SCALE_ELEMENT, TABBAR_HEIGHT - BOTTOM_SAFE_HEIGHT);
    
    if (!_affirmButton) {
        _affirmButton = [UIButton createButtonWithFrame:frame
                                                  title:@"确认"
                                               fontSize:44 * SCALE_ELEMENT
                                               fontName:nil
                                              backColor:[UIColor colorWithHexString:@"#FF401A" withAlpha:1.0f]
                                             titleColor:[UIColor whiteColor] showBorder:NO borderColor:nil normalImage:nil cornerRadius:0 selectedImage:nil];
        _affirmButton.selected = NO;
        _affirmButton.userInteractionEnabled = YES;
        [_affirmButton addTarget:self action:@selector(affirmAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_affirmButton];
    }
    
    return _affirmButton;
    
}

-(void)affirmAction:(UIButton *)sender{
    
    BOOL isChooseOne = NO;
    
    if (_normalChooseData.count != 0) {
        for (NSMutableDictionary * item in _normalChooseData) {
            if ([[item valueForKey:@"isSelected"] intValue] == 1) {
                isChooseOne = YES;
            }
        }
    }
    
    if (_normalChooseData.count == 0) {
        
        [_normalChooseData removeAllObjects];
        
        self.filtrateBackBlock(_normalChooseData);
        
    }else if(!isChooseOne){
        [MBProgressHUD showProgress:@"请至少选择一个联赛以确认" toView:self afterDelay:1];
        return;
    }else{
        
        _filtrateSclassData = [_normalChooseData mutableCopy];
        
        self.filtrateBackBlock(_filtrateSclassData);
        
        [_normalChooseData removeAllObjects];
    }
    
}

-(UITableView *)filtrateTableView{
    
    if (!_filtrateTableView) {
        _filtrateTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVI_HEGIHT + 1, self.bounds.size.width, self.bounds.size.height - NAVI_HEGIHT - TABBAR_HEIGHT - 1)];
        _filtrateTableView.dataSource = self;
        _filtrateTableView.delegate = self;
        _filtrateTableView.backgroundColor = [UIColor clearColor];
        _filtrateTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_filtrateTableView];
    }
    
    return _filtrateTableView;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_normalChooseData.count != 0) {
        return _normalChooseData.count;
    }
    
    return _filtrateSclassData.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * filtrateCell = @"filtrateCell";
    
    JCM_FiltrateCell * cell = [tableView dequeueReusableCellWithIdentifier:filtrateCell];
    
    if (cell == nil) {
        cell = [[JCM_FiltrateCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:filtrateCell];
    }
    
    NSMutableArray * array = _normalChooseData.count == 0?_filtrateSclassData:_normalChooseData;
    
    cell.sclassNameLabel.text = [[array objectAtIndex:indexPath.row] valueForKey:@"sclass_name"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell reloadWithNSDictionary:[array objectAtIndex:indexPath.row]];
    
    BOOL  isAll = YES;
    
    for (NSMutableDictionary * dic in array) {
        if ([[dic valueForKey:@"isSelected"] intValue] == 0) {
            isAll = NO;
        }
    }
    
    _allChooseButton.selected = isAll;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 114 * SCALE_ELEMENT;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BOOL isAll = YES;
    
    JCM_FiltrateCell * cell = [_filtrateTableView cellForRowAtIndexPath:indexPath];
    
    cell.sclassStateButton.selected = !cell.sclassStateButton.selected;
    
    NSString * colorStr = cell.sclassStateButton.selected?@"#FF401A":@"666666";
    
    cell.sclassNameLabel.textColor = [UIColor colorWithHexString:colorStr withAlpha:1.0f];
    
    if (_normalChooseData.count == 0) {
        
        for (NSMutableDictionary * dic in _filtrateSclassData) {
            NSMutableDictionary * item = [dic mutableCopy];
            [_normalChooseData addObject:item];
        }
        
    }
    
    NSDictionary * dic = [_normalChooseData objectAtIndex:indexPath.row];
    [dic setValue:@(cell.sclassStateButton.selected) forKey:@"isSelected"];
    
    for (NSMutableDictionary * item in _normalChooseData) {
        
        if ([[item valueForKey:@"isSelected"] intValue] == 0) {
            isAll = NO;
        }
        
    }
    
    _allChooseButton.selected = isAll;
    
}

-(void)leftAction:(UIButton *)sender{
    
    [_normalChooseData removeAllObjects];
    
    self.filtrateBackBlock(_normalChooseData);
}

-(void)setHeadViewTitleLabelTextWith:(NSString *)text{
    
    self.titleLabel.text = text;
    
}

-(void)setBackButtonTitle:(NSString *)title imageName:(NSString *)imageName{
    
    if (title) {
        [self.backButton setTitle:title forState:UIControlStateNormal];
    }
    
    if (imageName) {
        [self.backButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    
}

@end
