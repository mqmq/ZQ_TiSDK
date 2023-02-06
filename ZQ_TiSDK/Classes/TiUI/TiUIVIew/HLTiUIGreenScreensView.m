//
//  HLTiUIGreenScreensView.m
//  TiFancy
//
//  Created by N17 on 2021/4/16.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import "HLTiUIGreenScreensView.h"
#import "HLTiSetSDKParameters.h"

@implementation HLTiUIGreenScreensView


- (HLTiButton *)heliao_resetBtn{
    if (!_heliao_resetBtn) {
        _heliao_resetBtn = [[HLTiButton alloc] initWithScaling:1.0];
        [_heliao_resetBtn heliao_setTitle:@"恢复" withImage:[UIImage imageNamed:@"icon_lvmu_huifu_disabled"] withTextColor:TI_RGB_Alpha(254.0, 254.0, 254.0, 0.4) forState:UIControlStateNormal];
        [_heliao_resetBtn setEnabled:NO];
        [_heliao_resetBtn addTarget:self action:@selector(heliao_ResetEdit:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _heliao_resetBtn;
}

- (UIView *)heliao_dividingLine{
    if (!_heliao_dividingLine) {
        _heliao_dividingLine = [[UIView alloc]init];
        _heliao_dividingLine.backgroundColor = TI_Color_Default_Text_Black;
    }
    return _heliao_dividingLine;
}


- (HLTiButton *)heliao_similarityBtn{
    if (!_heliao_similarityBtn) {
        _heliao_similarityBtn = [[HLTiButton alloc] initWithScaling:1.0];
        [_heliao_similarityBtn heliao_setTitle:@"相似度" withImage:[UIImage imageNamed:@"icon_lvmu_xiangsi"] withTextColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_heliao_similarityBtn heliao_setTitle:@"相似度" withImage:[UIImage imageNamed:@"icon_lvmu_xiangsi"] withTextColor:TI_RGB_Alpha(88.0, 221.0, 221.0, 1.0) forState:UIControlStateSelected];
        [_heliao_similarityBtn setBorderWidth:0.0 BorderColor:UIColor.clearColor forState:UIControlStateNormal];
        [_heliao_similarityBtn setBorderWidth:1.0 BorderColor:TI_RGB_Alpha(88.0, 221.0, 221.0, 1.0) forState:UIControlStateSelected];
        [_heliao_similarityBtn addTarget:self action:@selector(heliao_clickEdit:) forControlEvents:UIControlEventTouchUpInside];
        [self.heliao_similarityBtn heliao_setRoundSelected:YES width:40];

    }
    return _heliao_similarityBtn;
}


- (HLTiButton *)heliao_smoothBtn{
    if (!_heliao_smoothBtn) {
        _heliao_smoothBtn = [[HLTiButton alloc] initWithScaling:1.0];
        [_heliao_smoothBtn  heliao_setTitle:@"平滑度" withImage:[UIImage imageNamed:@"icon_lvmu_smoothness"] withTextColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_heliao_smoothBtn  heliao_setTitle:@"平滑度" withImage:[UIImage imageNamed:@"icon_lvmu_smoothness"] withTextColor:TI_RGB_Alpha(88.0, 221.0, 221.0, 1.0) forState:UIControlStateSelected];
        [_heliao_smoothBtn setBorderWidth:0.0 BorderColor:UIColor.clearColor forState:UIControlStateNormal];
        [_heliao_smoothBtn setBorderWidth:1.0 BorderColor:TI_RGB_Alpha(88.0, 221.0, 221.0, 1.0) forState:UIControlStateSelected];
        [_heliao_smoothBtn addTarget:self action:@selector(heliao_clickEdit:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _heliao_smoothBtn;
}

- (HLTiButton *)heliao_hyalineBtn{
    if (!_heliao_hyalineBtn) {
        _heliao_hyalineBtn = [[HLTiButton alloc] initWithScaling:1.0];
        [_heliao_hyalineBtn heliao_setTitle:@"透明度" withImage:[UIImage imageNamed:@"icon_lvmu_alpha"] withTextColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_heliao_hyalineBtn heliao_setTitle:@"透明度" withImage:[UIImage imageNamed:@"icon_lvmu_alpha"] withTextColor:TI_RGB_Alpha(88.0, 221.0, 221.0, 1.0) forState:UIControlStateSelected];
        [_heliao_hyalineBtn setBorderWidth:0.0 BorderColor:UIColor.clearColor forState:UIControlStateNormal];
        [_heliao_hyalineBtn setBorderWidth:1.0 BorderColor:TI_RGB_Alpha(88.0, 221.0, 221.0, 1.0) forState:UIControlStateSelected];
        [_heliao_hyalineBtn addTarget:self action:@selector(heliao_clickEdit:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _heliao_hyalineBtn;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.heliao_resetBtn];
        [self.heliao_resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(17.5);
            make.width.equalTo(@(24));
            make.height.equalTo(@(60));
            make.top.equalTo(self).offset(30);
        }];
        [self addSubview:self.heliao_dividingLine];
        [self.heliao_dividingLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.heliao_resetBtn.mas_right).offset(28);
            make.width.equalTo(@(0.5));
            make.height.equalTo(@(55));
            make.top.equalTo(self).offset(30);
        }];
        [self addSubview:self.heliao_similarityBtn];
        [self.heliao_similarityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.heliao_dividingLine.mas_right).offset(28);
            make.width.equalTo(@(40));
            make.height.equalTo(@(70));
            make.bottom.equalTo(self.heliao_resetBtn.mas_bottom);
        }];
        [self addSubview:self.heliao_smoothBtn];
        [self.heliao_smoothBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.heliao_similarityBtn.mas_right).offset(30);
            make.width.equalTo(@(40));
            make.height.equalTo(@(70));
            make.centerY.equalTo(self.heliao_similarityBtn);
        }];
        [self addSubview:self.heliao_hyalineBtn];
        [self.heliao_hyalineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.heliao_smoothBtn.mas_right).offset(30);
            make.width.equalTo(@(40));
            make.height.equalTo(@(70));
            make.centerY.equalTo(self.heliao_smoothBtn);
        }];
        
        //注册通知——通知是否可以开启恢复功能
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(heliao_isResetEdit:) name:@"NotificationName_TiUIGreenScreensView_isResetEdit" object:nil];
    }
    return self;
}

- (void)heliao_isResetEdit:(NSNotification *)notification{
    
    NSNumber *isResetN = notification.object;
    BOOL isReset =  [isResetN boolValue];
    [self.heliao_resetBtn setEnabled:isReset];
    if (isReset) {

        [self.heliao_resetBtn heliao_setTitle:@"恢复" withImage:[UIImage imageNamed:@"icon_lvmu_huifu"] withTextColor:UIColor.whiteColor forState:UIControlStateNormal];
    }else{
        [self.heliao_resetBtn heliao_setTitle:@"恢复" withImage:[UIImage imageNamed:@"icon_lvmu_huifu_disabled"] withTextColor:TI_RGB_Alpha(254.0, 254.0, 254.0, 0.4) forState:UIControlStateNormal];
    }
}


- (void)heliao_clickEdit:(HLTiButton *)sender{
    if (sender == self.heliao_similarityBtn) {
        heliao_is_greenEdit = 1;
    }
    if (sender == self.heliao_smoothBtn) {
        heliao_is_greenEdit = 2;
    }
    if (sender == self.heliao_hyalineBtn) {
        heliao_is_greenEdit = 3;
    }
    [self heliao_Edit:heliao_is_greenEdit];
}

- (void)heliao_Edit:(int)sender{
    if (sender == 1) {

        [self.heliao_similarityBtn heliao_setRoundSelected:YES width:self.heliao_similarityBtn.layer.frame.size.width];
        [self.heliao_smoothBtn heliao_setRoundSelected:NO width:0];
        [self.heliao_hyalineBtn heliao_setRoundSelected:NO width:0];
        [[HLTiUIManager shareManager].heliao_tiUIViewBoxView.heliao_sliderRelatedView.heliao_sliderView heliao_setSliderType:TI_UI_SLIDER_TYPE_TWO WithValue:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_SIMILARITY_SLIDER]];
    }
    if (sender == 2) {
        [self.heliao_similarityBtn heliao_setRoundSelected:NO width:0];
        [self.heliao_smoothBtn heliao_setRoundSelected:YES width:self.heliao_similarityBtn.layer.frame.size.width];
        [self.heliao_hyalineBtn heliao_setRoundSelected:NO width:0];
        [[HLTiUIManager shareManager].heliao_tiUIViewBoxView.heliao_sliderRelatedView.heliao_sliderView heliao_setSliderType:TI_UI_SLIDER_TYPE_ONE WithValue:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_SMOOTH_SLIDER]];
    }
    if (sender == 3) {
        [self.heliao_similarityBtn heliao_setRoundSelected:NO width:0];
        [self.heliao_smoothBtn heliao_setRoundSelected:NO width:0];
        [self.heliao_hyalineBtn heliao_setRoundSelected:YES width:self.heliao_similarityBtn.layer.frame.size.width];
        [[HLTiUIManager shareManager].heliao_tiUIViewBoxView.heliao_sliderRelatedView.heliao_sliderView heliao_setSliderType:TI_UI_SLIDER_TYPE_ONE WithValue:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_HYALINE_SLIDER]];

    }
}

- (void)heliao_ResetEdit:(UIButton *)sender{
    //相似度
    [HLTiSetSDKParameters heliao_setFloatValue:SimilarityValue forKey:TI_UIDCK_SIMILARITY_SLIDER];
    //平滑度
    [HLTiSetSDKParameters heliao_setFloatValue:SmoothnessValue forKey:TI_UIDCK_SMOOTH_SLIDER];
    //透明度
    [HLTiSetSDKParameters heliao_setFloatValue:AlphaValue forKey:TI_UIDCK_HYALINE_SLIDER];
    
    [[TiSDKManager shareManager] setGreenScreen:@"绿幕抠图" Similarity:SimilarityValue Smoothness:SmoothnessValue Alpha:AlphaValue];
    

    [self heliao_Edit:heliao_is_greenEdit];
    [self.heliao_resetBtn setEnabled:NO];
    [self.heliao_resetBtn heliao_setTitle:@"恢复" withImage:[UIImage imageNamed:@"icon_lvmu_huifu_disabled"] withTextColor:TI_RGB_Alpha(254.0, 254.0, 254.0, 0.4) forState:UIControlStateNormal];    

}

- (void)dealloc{
    //移除通知
   [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (void)heliao_didGetInfoSuccess {
    NSLog(@"Continue");
}
    
@end
