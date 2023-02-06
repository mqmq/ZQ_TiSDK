//
//  HLTiUIDefaultButtonView.h
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/2.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HLTiUIDefaultButtonView : UIView

@property(nonatomic, strong) UIButton *heliao_mainSwitchButton;
@property(nonatomic, strong) UIButton *heliao_cameraCaptureButton;
@property(nonatomic, strong) UIButton *heliao_switchCameraButton;
@property(nonatomic, strong) UIButton *heliao_TiDemoBtn;

@property(nonatomic,copy)void(^heliao_onClickBlock)(NSInteger tag);



NS_ASSUME_NONNULL_END
- (void)heliao_getMediaFailed;
@end
