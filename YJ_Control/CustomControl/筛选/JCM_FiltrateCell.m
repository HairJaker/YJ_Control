//
//  JCM_FiltrateCell.m
//  竞彩猫
//
//  Created by yujie on 2017/5/27.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "JCM_FiltrateCell.h"

@implementation JCM_FiltrateCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        CGFloat  selfHeight = 114 * SCALE_ELEMENT;
        
        _sclassStateButton = [UIButton createButtonWithFrame:CGRectMake(46 * SCALE_ELEMENT, 39 * SCALE_ELEMENT, 36 * SCALE_ELEMENT, 36 * SCALE_ELEMENT)
                                                       title:nil
                                                    fontSize:0
                                                    fontName:nil
                                                   backColor:nil
                                                  titleColor:nil
                                                  showBorder:NO
                                                 borderColor:nil
                                                 normalImage:[UIImage imageNamed:@"筛选未选中"]
                                                cornerRadius:0
                                               selectedImage:[UIImage imageNamed:@"筛选选中"]];
        _sclassStateButton.selected = YES;
        [self addSubview:_sclassStateButton];
        
        _sclassNameLabel = [UILabel createLabelWithFrame:CGRectMake(138 * SCALE_ELEMENT, 0, SCREEN_WIDTH - 2 * 138 * SCALE_ELEMENT, selfHeight)
                                                    text:nil
                                               backColor:nil
                                               textColor:[UIColor colorWithHexString:@"#FF401A" withAlpha:1.0f]
                                              showBorder:NO
                                                fontSize:40 * SCALE_ELEMENT
                                             borderColor:nil
                                            cornerRadius:0];
        _sclassNameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_sclassNameLabel];
        
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, selfHeight - 1, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = RGBA(241, 242, 243, 1.0f);
        [self addSubview:lineView];
        
    }

    return self;
}

-(void)reloadWithNSDictionary:(NSMutableDictionary *)dic{

    BOOL isSelected = [[dic valueForKey:@"isSelected"] boolValue];
    
    _sclassStateButton.selected = isSelected;
    
    NSString * colorStr = isSelected?@"#FF401A":@"666666";
    
    self.sclassNameLabel.textColor = [UIColor colorWithHexString:colorStr withAlpha:1.0f];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
