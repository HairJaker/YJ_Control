//
//  JCM_MenuView.m
//  竞彩猫
//
//  Created by yujie on 2017/9/4.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "JCM_MenuView.h"

@interface JCM_MenuView ()

@property (nonatomic,strong) NSMutableArray * lineLabels;

@end

@implementation JCM_MenuView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _items = [NSMutableArray array];
        _lineLabels = [NSMutableArray array];
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

-(void)reloadMenuItems{
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(menuTitles)]) {
        _titles = [self.dataSource menuTitles];
    }
    
    for (UIButton * btn in _items) {
        [btn removeFromSuperview];
    }
    for (UILabel * label in _lineLabels) {
        [label removeFromSuperview];
    }
    
    [_items removeAllObjects];
    [_lineLabels removeAllObjects];
    
    [self creatMenuItemsWithFrame:self.frame];
}

-(void)creatMenuItemsWithFrame:(CGRect)frame
{
    for (int i = 0; i < _titles.count; i ++) {
        UIButton * menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        menuButton.frame = CGRectMake(0, (frame.size.height/_titles.count) * i, frame.size.width, frame.size.height/_titles.count);
        [menuButton setTitle:[_titles objectAtIndex:i] forState:UIControlStateNormal];
        menuButton.titleLabel.font = [UIFont systemFontOfSize:38 * SCALE_ELEMENT];
        if (i == 0) {
            menuButton.selected = YES;
        }
        menuButton.tag = i;
        [menuButton setTitleColor:[UIColor colorWithHexString:@"#666666" withAlpha:1.0f] forState:UIControlStateNormal];
        [menuButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [menuButton addTarget:self action:@selector(menuChooseAction:) forControlEvents:UIControlEventTouchUpInside];
        [_items addObject:menuButton];
        [self addSubview:menuButton];
        
        if (i < _titles.count - 1) {
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, (frame.size.height/_titles.count) * (i + 1) - 1, frame.size.width, 1.0f)];
            label.backgroundColor = RGBA(235, 235, 235, 1.0f);
            [self addSubview:label];
            [_lineLabels addObject:label];
        }
        
    }
}

-(void)menuChooseAction:(UIButton *)sender
{
    _menuChooseBlock((int)sender.tag);
}

-(void)reloadItmesFrameWithFrame:(CGRect)frame{
    for (int i = 0; i < _items.count; i ++) {
        UIButton * menuButton = [_items objectAtIndex:i];
        menuButton.frame = CGRectMake(0, (frame.size.height/_items.count) * i, frame.size.width, frame.size.height/_items.count);
        if (i < _items.count - 1) {
            UILabel * label = [_lineLabels objectAtIndex:i];
            label.frame = CGRectMake(0,(frame.size.height/_items.count) * (i + 1) - 1, frame.size.width, 1.0f);
        }
        
    }
    
}

@end
