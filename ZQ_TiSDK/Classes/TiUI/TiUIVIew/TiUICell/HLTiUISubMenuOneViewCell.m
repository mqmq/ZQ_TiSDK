//
//  HLTiUISubMenuOneViewCell.m
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/4.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "HLTiUISubMenuOneViewCell.h"
#import "HLTiButton.h"


@interface HLTiUISubMenuOneViewCell ()

@property(nonatomic ,strong)HLTiButton *heliao_cellButton;

@end

@implementation HLTiUISubMenuOneViewCell

- (HLTiButton *)heliao_cellButton{
    if (!_heliao_cellButton) {
        _heliao_cellButton = [[HLTiButton alloc]initWithScaling:0.9];
        _heliao_cellButton.userInteractionEnabled = NO;
    }
    return _heliao_cellButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.heliao_cellButton];
        [self.heliao_cellButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self.mas_left).offset(6);
            make.right.equalTo(self.mas_right).offset(-6);
        }];
    }
    return self;
}

- (void)setHeliao_subMod:(TIMenuMode *)subMod{
    
    if (subMod) {
        _heliao_subMod = subMod;
        if ([subMod.normalThumb  isEqual: @""]) {
            [self.heliao_cellButton heliao_setTitle:[NSString stringWithFormat:@"%@",@""] withImage:nil withTextColor:UIColor.clearColor forState:UIControlStateNormal];
            [self.heliao_cellButton heliao_setClassifyText:subMod.name withTextColor:UIColor.whiteColor];
        }else{
            [self.heliao_cellButton heliao_setTitle:[NSString stringWithFormat:@"%@",subMod.name] withImage:[UIImage imageNamed:subMod.normalwhiteThumb] withTextColor:UIColor.whiteColor forState:UIControlStateNormal];
            [self.heliao_cellButton heliao_setTitle:[NSString stringWithFormat:@"%@",subMod.name]
                    withImage:[UIImage imageNamed:subMod.selectedThumb]
                withTextColor:TI_Color_Default_Background_Pink
                     forState:UIControlStateSelected];
            [self.heliao_cellButton setSelected:subMod.selected];
            [self.heliao_cellButton heliao_setTextFont:[UIFont fontWithName:@"PingFang-SC-Regular" size:10]];
        }
    }
    
}

- (void)heliao_setCellTypeBorderIsShow:(BOOL)show{
   
    if (show) {
        [self.heliao_cellButton setBorderWidth:0.0 BorderColor:[UIColor clearColor] forState:UIControlStateNormal];
        [self.heliao_cellButton setBorderWidth:1.f BorderColor:TI_Color_Default_Background_Pink forState:UIControlStateSelected];
    }else{
        [self.heliao_cellButton setBorderWidth:0.0 BorderColor:[UIColor clearColor] forState:UIControlStateNormal];
        [self.heliao_cellButton setBorderWidth:0.f BorderColor:[UIColor clearColor] forState:UIControlStateSelected];
    }
       
}


- (void)heliao_getUsersMostLiked:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}
@end
