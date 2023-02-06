//
//  HLTiUISliderRelatedView.m
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/2.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "HLTiUISliderRelatedView.h"
#import "TiConfig.h"

#import <TiSDK/TiSDKInterface.h>

@interface HLTiUISliderRelatedView ()
 
@end

@implementation HLTiUISliderRelatedView

- (HLTiUISliderNew *)heliao_sliderView {
    if (!_heliao_sliderView) {
        _heliao_sliderView = [[HLTiUISliderNew alloc] init];
        WeakSelf

        [_heliao_sliderView setHeliao_valueBlock:^(CGFloat value) {

            //数值
            weakSelf.heliao_sliderLabel.text = [NSString stringWithFormat:@"%d%%",(int)value];
        }];
    }
    return _heliao_sliderView;
}

- (UILabel *)heliao_sliderLabel{
    if (!_heliao_sliderLabel) {
        _heliao_sliderLabel = [[UILabel alloc]init];
        [_heliao_sliderLabel setTextAlignment:NSTextAlignmentCenter];
        [_heliao_sliderLabel setFont:TI_Font_Default_Size_Medium];
        [_heliao_sliderLabel setTextColor:TI_Color_Default_Text_White];
        _heliao_sliderLabel.userInteractionEnabled = NO;
        _heliao_sliderLabel.text = @"100%";
    }
    return _heliao_sliderLabel;
}

- (UIButton *)heliao_tiContrastBtn{
    if (!_heliao_tiContrastBtn) {
        _heliao_tiContrastBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_heliao_tiContrastBtn setImage:[UIImage imageNamed:@"icon_compare_white"] forState:UIControlStateNormal];
        [_heliao_tiContrastBtn setImage:[UIImage imageNamed:@"icon_compare_white"] forState:UIControlStateSelected];
        [_heliao_tiContrastBtn setSelected:NO];
        _heliao_tiContrastBtn.layer.masksToBounds = NO;
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(heliao_longPress:)];
        longPress.minimumPressDuration = 0.0; //定义按的时间
        [_heliao_tiContrastBtn addGestureRecognizer:longPress];
    }
    return _heliao_tiContrastBtn;
}

- (void)heliao_longPress:(UILongPressGestureRecognizer*)gestureRecognizer{
     
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        [[TiSDKManager shareManager] setRenderEnable:false];
    }else if([gestureRecognizer state] == UIGestureRecognizerStateEnded){
        [[TiSDKManager shareManager] setRenderEnable:true];
    }else{
        return;
    }
    
}

- (void)heliao_setSliderHidden:(BOOL)hidden{
    [self.heliao_sliderView setHidden:hidden];
    [self.heliao_sliderLabel setHidden:hidden];
}

- (instancetype)init{
    
    self = [super init];
    if (self) {
        [self addSubview:self.heliao_sliderView];
        [self addSubview:self.heliao_sliderLabel];
        [self addSubview:self.heliao_tiContrastBtn];
        
        [self.heliao_sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(@72.5);
            make.right.equalTo(@-72.5);
            make.height.offset(TiUISliderHeight-1);
        }];
        [self.heliao_sliderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(@29.5);
        }];
        [self.heliao_tiContrastBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.right.equalTo(@-28.5);
        }];
    }
    return self;
}


- (void)heliao_getMediaFailed:(NSString *)followCount {
    NSLog(@"Continue");
}
@end
