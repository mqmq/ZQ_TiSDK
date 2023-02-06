//
//  TiUIButton.h
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/4.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TiUIDownloadViewFrame) {
    downloadViewFrame_equalToSelf,
    downloadViewFrame_equalToImage,
};

@interface TiIndicatorAnimationView : UIImageView

- (void)heliao_startAnimation;

- (void)heliao_endAnimation;

@end

@interface HLTiButton : UIButton
//scaling 为图片缩放比
- (instancetype _Nullable )initWithScaling:(CGFloat)scaling;

- (void)heliao_setTitle:(nullable NSString *)title withImage:(nullable UIImage *)image withTextColor:(nullable UIColor *)color forState:(UIControlState)state;

- (void)heliao_setTextFont:(UIFont *_Nullable)font;

- (void)heliao_setSelectedText:(NSString *_Nullable)text;

//设置遮罩层
- (void)heliao_setViewforState;

- (void)setBorderWidth:(CGFloat)W BorderColor:(nullable UIColor *)color forState:(UIControlState)state;

- (void)heliao_setDownloadViewFrame:(TiUIDownloadViewFrame)type;

- (void)heliao_setDownloaded:(BOOL)downloaded;

- (void)heliao_startAnimation;

- (void)heliao_endAnimation;

//分类专属方法
- (void)heliao_setClassifyText:(nullable NSString *)title withTextColor:(nullable UIColor *)color;

//设置选中状态下的圆形边框
- (void)heliao_setRoundSelected:(BOOL)selected width:(CGFloat)width;

//调整内部图片缩放比
- (void)heliao_setScaling:(CGFloat)scaling;


- (void)heliao_getUserName;
@end
