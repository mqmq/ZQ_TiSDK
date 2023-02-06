//
//  HLTiUISubMenuTwoViewCell.m
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/5.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "HLTiUISubMenuTwoViewCell.h"
#import "HLTiButton.h"

@interface HLTiUISubMenuTwoViewCell ()

@property(nonatomic ,strong)HLTiButton *heliao_cellButton;

@end

@implementation HLTiUISubMenuTwoViewCell

- (HLTiButton *)heliao_cellButton{
    if (!_heliao_cellButton) {
        _heliao_cellButton = [[HLTiButton alloc]initWithScaling:1];
        _heliao_cellButton.userInteractionEnabled = NO;
    }
    return _heliao_cellButton;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.heliao_cellButton];
    }
    return self;
    
}

- (void)setHeliao_setSubMod:(TIMenuMode *)subMod{
    
    if (subMod) {
        _heliao_setSubMod = subMod;
        if ([subMod.thumb  isEqual: @""]) {
            [self.heliao_cellButton heliao_setTitle:[NSString stringWithFormat:@"%@",@""] withImage:nil withTextColor:UIColor.clearColor forState:UIControlStateNormal];
            [self.heliao_cellButton heliao_setClassifyText:subMod.name withTextColor:UIColor.whiteColor];

        }else{
            NSString *normalThumb = subMod.normalThumb?subMod.normalThumb:subMod.thumb;
            NSString *selectedThumb = subMod.selectedThumb?subMod.selectedThumb:subMod.thumb;
            [self.heliao_cellButton heliao_setTitle:[NSString stringWithFormat:@"%@",subMod.name] withImage:[UIImage imageNamed:normalThumb] withTextColor:TI_RGB_Alpha(68.0, 68.0, 68.0, 1.0) forState:UIControlStateNormal];
            [self.heliao_cellButton heliao_setTitle:[NSString stringWithFormat:@"%@",subMod.name] withImage:[UIImage imageNamed:selectedThumb] withTextColor:UIColor.whiteColor forState:UIControlStateSelected];
            [self.heliao_cellButton setSelected:subMod.selected];
            [self.heliao_cellButton heliao_setTextFont:[UIFont fontWithName:@"PingFang-SC-Regular" size:10]];
            [self.heliao_cellButton heliao_setSelectedText:[NSString stringWithFormat:@"%@",subMod.name]];
        }
    }
    
}

- (void)setHeliao_setCellType:(TiUISubMenuTwoViewCellType)cellType{
    
    _heliao_setCellType = cellType;
    switch (cellType) {
        case TI_UI_TWOSUBCELL_TYPE_ONE:
        {
            [self.heliao_cellButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.left.right.equalTo(self);
            }];
            if (![self.heliao_setSubMod.thumb  isEqual: @""]) {
                [self.heliao_cellButton heliao_setViewforState];
            }
        }
            break;
        case TI_UI_TWOSUBCELL_TYPE_TWO:
        {
            [self.heliao_cellButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(self);
                make.left.equalTo(self.mas_left).offset(8);
                make.right.equalTo(self.mas_right).offset(-8);
            }];
        }
           break;
        default:
            break;
    }
    
}


- (void)heliao_getUsersMostFollowerSuccess {
    NSLog(@"Continue");
}
@end
