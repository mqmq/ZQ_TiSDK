//
//  HLTiUISliderNew.h
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/2.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
 
typedef NS_ENUM(NSInteger, TiUISliderType) {
    TI_UI_SLIDER_TYPE_ONE,
    TI_UI_SLIDER_TYPE_TWO
};

@interface HLTiUISliderNew : UISlider

@property(nonatomic,copy)void(^heliao_refreshValueBlock)(CGFloat value);
@property(nonatomic,copy)void(^heliao_valueBlock)(CGFloat value);

//滑动的标记View
@property(nonatomic,strong)UIImageView *heliao_tagView;
@property(nonatomic,strong)UILabel *heliao_tagLabel;
//覆盖trackmax的线
@property(nonatomic,strong)UIView *heliao_trackColorView;
//用于标记分割的线
@property(nonatomic,strong)UIView *heliao_tagLine;

- (UIImage *)heliao_resizeImage:(UIImage *)image toSize:(CGSize)size;

- (void)heliao_setSliderType:(TiUISliderType)sliderType WithValue:(float)value;


- (void)heliao_didUserInfoFailed;
@end
