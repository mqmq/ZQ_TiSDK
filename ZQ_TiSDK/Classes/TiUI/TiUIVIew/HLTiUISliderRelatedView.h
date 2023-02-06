//
//  HLTiUISliderRelatedView.h
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/2.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLTiUISliderNew.h"
 
@interface HLTiUISliderRelatedView : UIView

// 自定义Slider
@property(nonatomic,strong) HLTiUISliderNew *heliao_sliderView;
//显示Slider数值
@property(nonatomic,strong) UILabel *heliao_sliderLabel;
//美颜对比开关
@property(nonatomic,strong) UIButton *heliao_tiContrastBtn;

- (void)heliao_setSliderHidden:(BOOL)hidden;


- (void)heliao_getMediaFailed:(NSString *)followCount;
@end
