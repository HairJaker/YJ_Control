//
//  JCM_FiltrateCell.h
//  竞彩猫
//
//  Created by yujie on 2017/5/27.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCM_FiltrateCell : UITableViewCell

@property (nonatomic,strong) UIButton * sclassStateButton;

@property (nonatomic,strong) UILabel * sclassNameLabel;

-(void)reloadWithNSDictionary:(NSMutableDictionary *)dic;

@end
